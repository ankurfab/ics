package ics
import groovy.sql.Sql;

class BookService {

    def springSecurityService
    def housekeepingService
    def receiptSequenceService
    def dataSource
    
    def orderSubmit(Map params) {
    	def retVal = "Invalid order"
    	def order = BookOrder.get(params.orderid)
    	if(order && order.status=='Draft' && order.lineItems && order.lineItems.size()>0) {
    		order.status='Submitted'
    		order.orderDate = new Date()
    		order.save()
    		retVal = "Order Submitted!!"
    	}
    	return retVal
    }

    def orderReject(Map params) {
    	def retVal = "Invalid order"
    	def order = BookOrder.get(params.orderid)
    	if(order && (order.status=='Submitted' || order.status=='In-Progress')) {
    		order.status='Rejected'
    		order.orderDate = new Date()
    		order.save()
    		retVal = "Order Rejected!!"
    	}
    	return retVal
    }

    def orderProcess(Map params) {
    	def retVal = "Invalid order"
    	def order = BookOrder.get(params.orderid)
    	if(order && order.status=='Submitted') {
    		order.status='In-Progress'
    		order.orderDate = new Date()
    		order.save()
    		retVal = "Order Processed!!"
    	}
    	return retVal
    }

    def orderIssue(Map params) {
    	def order = BookOrder.get(params.orderid)
    	if(order && (order.status=='In-Progress' ||  order.status=='Submitted')) {
    		//now create challan automatically from this order
    		def challan = createChallan(order)
    		order.challan = challan
    		order.status='Fulfilled'
    		order.orderDate = new Date()
    		order.save()
    		if(params.quick)
    			{
    			challan.status='PREPARED'
    			challan.save()
    			}
    	}
    	return order
    }
    
    def createChallan(BookOrder order) {
    	def challan = new Challan()
    	challan.updator = challan.creator = springSecurityService.principal.username
    	challan.issuedTo = order.placedBy
    	challan.issuedBy = Individual.findByLoginid(springSecurityService.principal.username)
    	challan.issueDate = new Date()
    	challan.type = "OUTWARD"
 	challan.status = "DRAFT"    	
    	challan.totalAmount = order.lineItems?.sum{it.requiredQuantity*it.book.sellPrice}
    	
    	if(!challan.save())
			    challan.errors.allErrors.each {
				log.debug(it)
				}    	
    	else
    		{
    		//generate challan refNo
			def key = 'JDCHLN'+housekeepingService?.getFY()
		    challan.refNo = key +"/"+ receiptSequenceService.getNext(key)
		    //challan.refNo = "JDCHLN"+housekeepingService.getFY() +"/"+ receiptSequenceService.getNext("JD-Challan")
		    challan.save()
		
		//add challan line items
		challan.lineItems = []
		order.lineItems?.each{
			challan.lineItems.add(createChallanLineItem(challan,it))
		}
    		
    		}
    	return challan
    }
    
    def createChallanLineItem(Challan challan, BookOrderLineItem boli) {
    	def challanLineItem = new ChallanLineItem()
    	challanLineItem.updator = challanLineItem.creator = springSecurityService.principal.username
    	challanLineItem.book = boli.book
    	challanLineItem.issuedQuantity = boli.requiredQuantity
    	challanLineItem.rate = boli.book.sellPrice?:0
    	challanLineItem.discountedRate = 0
    	challanLineItem.returnedQuantity = 0
    	challanLineItem.challan = challan
    	if(!challanLineItem.save())
			    challanLineItem.errors.allErrors.each {
				log.debug(it)
				}
	return challanLineItem
    }
    
    def uploadBookStock(Object tokens) {
    	//colNames:['Name','Author','Publisher','Category','Type','Language','Alias','CostPrice','SellPrice','Stock','ReorderLevel'],
	def book,bookStock,newBook=false,success=false  

	try{
	//first check if new book or existing book (by name,category,type,language)
	book = Book.findWhere(name:tokens[0],category:tokens[3],type:tokens[4],language:tokens[5])
	if(!book)
		{
		book = createBook(tokens)
		if(book)
			newBook=true
		}
	
	if(book) {
		//now create the book stock entry
		bookStock = new BookStock()
		bookStock.book = book
		bookStock.stockDate = new Date()
		bookStock.price = newBook?book.sellPrice:new BigDecimal(tokens[8])
		bookStock.stock = newBook?book.stock:new Integer(tokens[9])
		if(!newBook)
			book.stock+=bookStock.stock
		bookStock.updator = bookStock.creator = springSecurityService.principal.username
		if(!bookStock.save())
				bookStock.errors.allErrors.each {
					println "Error in bulk saving bookStock :"+it
				}
		else
			{
			success=true
			//log.debug(bookStock.toString()+" saved!")
			}
	}
	}
	catch(Exception e){log.debug("Exception occured in uploadBookStock"+e)}
	return success    	
    }
    
    def createBook(Object tokens) {
	try{
		def book = new Book()
		book.name = tokens[0]
		try{
			book.author = tokens[1]
		}
		catch(all){
			book.author = ''
		}
		try{
			book.publisher = tokens[2]
		}
		catch(all){
			book.publisher = ''
		}
		try{
			book.category = tokens[3]
		}
		catch(all){
			book.category = ''
		}
		try{
			book.type = tokens[4]
		}
		catch(all){
			book.type = ''
		}
		try{
			book.language = tokens[5]
		}
		catch(all){
			book.language = ''
		}
		try{
			book.alias = tokens[6]
		}
		catch(all){
			book.alias = ''
		}
		try{
			book.costPrice = new BigDecimal(tokens[7])
		}
		catch(all){
			book.costPrice = 0
		}
		try{
			book.sellPrice = new BigDecimal(tokens[8])
		}
		catch(all){
			book.sellPrice = 0
		}
		try{
			book.stock = new Integer(tokens[9])
		}
		catch(all){
			book.stock = 0
		}
		try{
			book.reorderLevel = new Integer(tokens[10])
		}
		catch(all){
			book.reorderLevel = 0
		}
		try{
			book.updator = book.creator = springSecurityService.principal.username
		}
		catch(all){
			book.updator = book.creator = ''
		}
		if(!book.save())
				book.errors.allErrors.each {
					println "Error in createBook book :"+it
				}
		else
			return book
	}
	catch(Exception e) {
		log.debug("Exception in  createBook:"+tokens+": "+e)
	}
	return null
    }
    
    def uploadBookOrder(BookOrder order, Object tokens) {
    	//colNames:Name,Language,Type,SellingPrice,IssueQuantity,ReturnQuantity
	def book,boli,success=false,quantity=0  
	if(tokens[0]&&tokens[1]&&tokens[2]&&tokens[4]) {
		//first check if existing book (by name,type,language)
		book = Book.findWhere(name:tokens[0],type:tokens[2],language:tokens[1])
		if(book) {
			try{
				quantity=new Integer(tokens[4])
			}
			catch(Exception e){}
			if(quantity>0){
				//now create the book Order Line Item entry
				boli = new BookOrderLineItem()
				boli.book = book
				boli.requiredQuantity = quantity
				boli.order = order
				boli.updator = boli.creator = order.creator
				/*if(!order.lineItems)
					order.lineItems = []
				order.lineItems.add(boli)*/
				if(!boli.save())
						boli.errors.allErrors.each {
							println "Error in bulk saving boli :"+it
						}
				else
					{
					success=true
					//log.debug(boli.toString()+" saved!")
					}
			}
		}
	}
	return success    	
    }
    
	def updateChallanLineItem(Challan challan, Object tokens) {
    	//colNames:Name,Language,Type,SellingPrice,IssueQuantity,ReturnQuantity
	def book,cli,success=false,quantity=0  
	if(tokens[0]&&tokens[1]&&tokens[2]&&tokens[5]) {
		//first check if existing book (by name,type,language)
		book = Book.findWhere(name:tokens[0],type:tokens[2],language:tokens[1])
		if(book) {
			try{
				quantity=new Integer(tokens[5])
			}
			catch(Exception e){}
			if(quantity>0){
				//now create the book Order Line Item entry
				cli = ChallanLineItem.findByChallanAndBook(challan,book)
				if(cli) {
					cli.returnedQuantity = (cli.returnedQuantity?:0)+quantity
					try{
						cli.updator = springSecurityService.principal.username
						}
					catch(Exception e){
						cli.updator = 'jdorder'
						}
					if(!cli.save())
							cli.errors.allErrors.each {
								println "Error in bulk updating cli :"+it
							}
					else
						{
						success=true
						//increase book stock by the corresponding quantity
						updateBookStock(book,quantity,'increment')
						}
				}
			}
		}
	}
	return success    	
	}
	
	def updateBookStock(Book book, Integer quantity, String oper) {
		//log.debug('updateBookStock:'+book+':'+quantity+':'+oper)
		switch(oper) {
			case 'increment':
				book.stock = (book.stock?:0)+quantity
				break
			case 'decrement':
				book.stock = (book.stock?:0)-quantity
				break
			default:
				break
			}		
		if(!book.save())
			book.errors.allErrors.each {
				println "Error in "+oper+" book stock :"+it
			}	
	}
	
	def scores() {
		def sql = new Sql(dataSource)
		def query = """select date_format(q.settle_date,'%D %b`%y') date,q.*,(q.SmallPoint+q.MediumPoint+q.BigPoint+q.MahaBigPoint) BookPoints  from
			(SELECT  P.challan_id,P.dist_id,P.settle_date,P.distributor,
			    SUM(
				CASE 
				    WHEN P.category='Small' 
				    THEN P.numdist 
				    ELSE 0
				END
			    ) AS 'Small',
			    SUM(
				CASE 
				    WHEN P.category='Medium' 
				    THEN P.numdist 
				    ELSE 0
				END
			    ) AS 'Medium',
			    SUM(
				CASE 
				    WHEN P.category='Big' 
				    THEN P.numdist 
				    ELSE 0
				END
			    ) AS 'Big',
			    SUM(
				CASE 
				    WHEN P.category='MahaBig' 
				    THEN truncate(P.numdist* (P.point/2),0)
				    ELSE 0
				END
			    ) AS 'MahaBig',
			    SUM(
				CASE 
				    WHEN P.category='Small' 
				    THEN P.numdist * P.point
				    ELSE 0
				END
			    ) AS 'SmallPoint',
			    SUM(
				CASE 
				    WHEN P.category='Medium' 
				    THEN P.numdist  * P.point
				    ELSE 0
				END
			    ) AS 'MediumPoint',
			    SUM(
				CASE 
				    WHEN P.category='Big' 
				    THEN P.numdist  * P.point
				    ELSE 0
				END
			    ) AS 'BigPoint',
			    SUM(
				CASE 
				    WHEN P.category='MahaBig' 
				    THEN P.numdist * P.point
				    ELSE 0
				END
			    ) AS 'MahaBigPoint'
			FROM    (select c.id challan_id,i.id dist_id,c.settle_date,ifnull(i.initiated_name,i.legal_name) distributor,b.category,b.point,sum((cli.issued_quantity-cli.returned_quantity)) numdist from challan c, challan_line_item cli, book b, individual i where c.issued_to_id=i.id and c.id=cli.challan_id and c.status='SETTLED' and cli.book_id=b.id group by settle_date,distributor,b.category having numdist >0 order by c.settle_date desc) P
			GROUP BY P.settle_date,P.distributor order by P.settle_date desc) q;"""
		def result = sql.rows(query)
		sql.close()
		return result
	}

	def oldscores() {
		def scores=[]
		def score=[:]
		def quantity
		def challans = Challan.createCriteria().list{
			eq('status','SETTLED')
			order('settleDate','desc')
			}
		challans.each{challan->
			challan.lineItems.sort{it.id}.each{cli->
				quantity = cli.issuedQuantity-cli.returnedQuantity
				score=['category':cli.book.category,'book':cli.book.name,'quantity':quantity,'distributor':challan.issuedTo,'from':challan.issueDate,'to':challan.settleDate,'points':calculatePoints(cli.book.category,quantity)]
				scores.add(score)
			}
		}
		return scores
	}
	
	def calculatePoints(String category, Integer quantity) {
		BigDecimal point= new BigDecimal(0)
		switch(category) {
			case 'MahaBig':
				point = 2
				break
			case 'Big':
				point = 1
				break
			case 'Medium':
				point = 0.5
				break
			case 'Small':
				point = 0.25
				break
			case 'BTGMagazine':
				point = 0.1
				break
			case 'BTGSubscriptionIndia':
				point = 2.5
				break
			case 'BTGSubscriptionInternational':
				point = 5.0
				break
			default:
				break
			
		}
		return point*quantity
	}
	
	//create a RelationshipGroup with team member names in comments if specified that way
	//if already exists then update
	def createTeam(Challan challan, String teamMembers) {
		  def order = BookOrder.findByChallan(challan)
		  def team = order?.team
		  boolean isNew = false
		  Map params = [:]
		  
		  if(!team) {			  
			  params.fromDate = challan.issueDate
			  params.tillDate = challan.settleDate
			  params.refid = challan.issuedTo.id
			  params.category = 'JIVADAYA'
			  params.groupName = "JivaDaya Team of "+challan.issuedTo.toString()
			  params.status = "INACTIVE"

			  team = new RelationshipGroup(params)
			  try{
			  team.updator=team.creator=springSecurityService.principal.username
			  }
			  catch(Exception e) {team.updator=team.creator="systemjd"}
			  isNew = true
		  }

		  team.comments = teamMembers
		    
		  if (! team.save())
		    team.errors.allErrors.each {
		    log.debug(it)
		    }

		    //now save this if new
		    if(order && isNew) {
		    	order.team = team
		    	if(!order.save())
		    		order.errors.allErrors.each {"Error in updating team in book order "+log.debug(it)}
		    }		    	
		
		return team
	}
	
	def getTeam(Challan challan) {
		  def bo =  BookOrder.findByChallan(challan)
		  def team=""
		  if(bo)
		   team = bo.team?.comments
		  else {
		  	//check if rg exists w/o bo, use the latest one
		  	def rgs = RelationshipGroup.findAllByCategoryAndRefid('JIVADAYA',challan.issuedTo?.id,[max: 1, sort: "id", order: "desc"])
		  	if(rgs?.size()>0)
		  		team = rgs[0].comments
		  }
		  return team
	}

}
