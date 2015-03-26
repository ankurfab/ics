package ics
import groovy.sql.Sql;

class DataService {
    def dataSource

    def serviceMethod() {
    }
    
	def eventRegistrationSummaryByStatusData(boolean vipFlag) {
		def result
		def numV=0,numUnderV=0,numR=0,numUnV=0
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						isNull('status')
						projections {
							groupProperty('verificationStatus')
							rowCount('num')
						}
					}
		//log.debug("eventRegistrationSummaryByStatusData: "+result)
		result?.each {
			switch(it[0]) {
				case VerificationStatus.VERIFIED :
					numV = it[1]
					break
				case VerificationStatus.UNDER_VERIFICATION :
					numUnderV = it[1]
					break
				case VerificationStatus.REJECTED :
					numR = it[1]
					break
				case VerificationStatus.UNVERIFIED :
					numUnV = it[1]
					break
				default:
					break
			}
		}

		//render( [[1, 3, 2, 4, 6, 9]] as JSON)
		return [[[VerificationStatus.VERIFIED.toString(),numV], [VerificationStatus.UNDER_VERIFICATION.toString(),numUnderV], [VerificationStatus.REJECTED.toString(),numR], [VerificationStatus.UNVERIFIED.toString(),numUnV]]]
	}

	def eventRegistrationSummaryData(boolean vipFlag) {
		def result
		def numP=0,numM=0,numC=0,numB=0
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						ne('verificationStatus',VerificationStatus.REJECTED)
						isNull('status')
						projections {
							sum('numberofPrabhujis')
							sum('numberofMatajis')
							sum('numberofChildren')
							sum('numberofBrahmacharis')
						}
					}
		//log.debug("eventRegistrationSummaryData: "+result)

		//render( [[['a',25],['b',14],['c',7]]] as JSON)
		return [[['Prji',result[0][0]?:0],['Mataji',result[0][1]?:0],['Children',result[0][2]?:0],['Brahmacharis/Students',result[0][3]?:0]]]
	}

	def eventRegistrationDetailData(boolean vipFlag) {
		def list = []
		def result
		def sql = new Sql(dataSource)
		//def query = "SELECT DATE_FORMAT(date_created,'%d-%b-%y') AS date, count(name) AS total_reg FROM event_registration GROUP BY date"
		def query = "SELECT DATE(date_created) AS date, count(name) AS total_reg FROM event_registration where status is null and is_Vip_Devotee="+ vipFlag+" GROUP BY date"
		result = sql.rows(query)
		sql.close()
		//log.debug("eventRegistrationDetailData: "+result)
		result.each {
			def data = []
			//data.add("'"+it.date.toString()+' 1:00AM'+"'")
			data.add(it.date.getTime())
			data.add(it.total_reg)
			list.add(data)
		}
		//log.debug("list: "+list)

		return [list]
	}

	def eventSummaryData(boolean vipFlag) {
		//summarize reg,acco,trans,prasad,volunteer later
		
		//summarize reg,acco,volunteer
		def  dataP = []
		def  dataM = []
		def  dataC = []
		def  dataB = []
		def result
		
		//reg
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						eq('verificationStatus',VerificationStatus.VERIFIED)
						isNull('status')
						projections {
							sum 'numberofPrabhujis'
							sum 'numberofMatajis'
							sum 'numberofChildren'
							sum 'numberofBrahmacharis'
							sum 'numPrjiVolunteer'
							sum 'numMatajiVolunteer'
							sum 'numBrahmacharisVolunteer'
						}
					}
		//log.debug("Reg:"+result)

		dataP.add([result[0][0]?:0,1])
		dataM.add([result[0][1]?:0,1])
		dataC.add([result[0][2]?:0,1])
		dataB.add([result[0][3]?:0,1])
		dataP.add([result[0][4]?:0,3])
		dataM.add([result[0][5]?:0,3])
		dataC.add([0,3])//no volunteer children
		dataB.add([result[0][6]?:0,3])


		/*dataP.add([result[0][0]?:0,1])
		dataM.add([result[0][1]?:0,1])
		dataC.add([result[0][2]?:0,1])
		dataP.add([result[0][3]?:0,3])
		dataM.add([result[0][4]?:0,3])
		dataC.add([0,3])//no volunteer children*/
		
		//acco
		//todo condider VIP case
		result = AccommodationAllotment.createCriteria().list {
						eventRegistration{eq('isVipDevotee',vipFlag)}
						projections {
							sum 'numberofPrabhujisAllotted'
							sum 'numberofMatajisAllotted'
							sum 'numberofChildrenAllotted'
							sum 'numberofBrahmacharisAllotted'
						}
					}
		//log.debug("Reg:"+result)
		dataP.add([result[0][0]?:0,2])
		dataM.add([result[0][1]?:0,2])
		dataC.add([result[0][2]?:0,2])
		dataB.add([result[0][3]?:0,2])
				
		/*dataP.add([result[0][0]?:0,2])
		dataM.add([result[0][1]?:0,2])
		dataC.add([result[0][2]?:0,2])*/

		/*log.debug('dataP'+dataP)
		log.debug('dataM'+dataM)
		log.debug('dataC'+dataC)*/
		//render( [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]] as JSON)
		return [dataP,dataM,dataC,dataB]
	}
	
	def counsellorCounselleeCollectionData(Date fd, Date td) {
    		/*** new logic
    		def donor_collectorid_query = "select c.name AS donor,c.counsellor AS donors_counsellor,d.collected_by_id AS collectorid,round(sum(d.amount)) AS donation from (donation d join individual_counsellor_view c) where ((d.donated_by_id = c.id) and (d.fund_receipt_date >= '"+String.format('%tF',fd)+"') and (d.fund_receipt_date <= '"+String.format('%tF',td)+"')) group by c.name,c.counsellor,d.collected_by_id"
    		
    		def query = "select i.id AS id,d.donor AS donor,d.donors_counsellor AS donors_counsellor,d.donation AS donation,if(isnull(d.donors_counsellor),i.name,d.donor) AS collector,ifnull(d.donors_counsellor,i.counsellor) AS collectors_counsellor from (("+donor_collectorid_query+") d join individual_counsellor_view i) where (d.collectorid = i.id);"
    		****/
    		/*def sql = new Sql(dataSource);
    		
    		def query = "select * from (select * from (select iclor.id councellor_id1, iclor.initiated_name councellor_name1, iclee.id councellee_id1, iclee.legal_name councellee_legal_name1, iclee.initiated_name councellee_initiated_name1, sum(amount) collection from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.collected_by_id=iclee.id and d.collected_by_id<>d.donated_by_id and d.donated_by_id not in (select distinct d.donated_by_id from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.donated_by_id<>d.collected_by_id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"') and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q1 left join (select iclor.id councellor_id2, iclor.initiated_name councellor_name2, iclee.id councellee_id2, iclee.legal_name councellee_legal_name2, iclee.initiated_name councellee_initiated_name2, sum(amount) donation from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"'  group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q2 on q1.councellee_legal_name1=q2.councellee_legal_name2) q3 left join (select iclor.id councellor_id1, iclor.initiated_name councellor_name, iclee.id councellee_id, iclee.legal_name councellee_legal_name, iclee.initiated_name councellee_initiated_name, sum(amount) loanAmount from individual iclee ,loan l, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and l.loaned_by_id=iclee.id  and l.loan_date>='"+String.format('%tF',fd)+"' and l.loan_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q4 on q3.councellee_legal_name1=q4.councellee_legal_name"
    		
    		
    		def queryResult = sql.rows(query)
    		sql.close()
     		return [queryResult: queryResult, fd:fd, td:td]*/
     		
		
		
		/*def result = Donation.createCriteria().list() {
				 ge('fundReceiptDate',fd)
				 le('fundReceiptDate',td)
				}
		return result*/
		
		def query="select d.id id, date_format(d.fund_receipt_date,'%d/%m/%Y') fundReceiptDate,d.nvcc_receipt_book_no nvccReceiptBookNo,d.nvcc_receipt_no nvccReceiptNo,date_format(donation_Date,'%d/%m/%Y') donationDate,amount,donated_By_id donorId,dc.name systemdonorName,dc.counsellor donorCounsellor, donor_Name donorName,donor_Address donorAddress,donor_Contact donorContact,donor_Email donorEmail,collected_By_id collectedById,cc.name collectedByName,cc.counsellor collectedByCounsellorName from donation d left join individual_counsellor_view dc on d.donated_by_id=dc.id left join individual_counsellor_view cc on d.collected_by_id=cc.id where d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"'"
		log.debug("In counsellorCounselleeCollectionData: "+query)
		def sql = new Sql(dataSource)
    		def queryResult = sql.rows(query)
    		sql.close()
    		return queryResult
		
	}
	
	//store the attribute names in a generic csv file
	//@TODO: take care of dep,centre and other attributes
	def storeHeader(String domainClassName,Object tokens) {
		def attr
		tokens.eachWithIndex{it,idx ->
			attr = new Attribute()
			attr.name = it
			attr.position = idx
			if(!attr.save())
				attr.errors.allErrors.each {log.debug("exception in saving arrr:"+ it)}
		}
	}
	
	//store the attribute values in a generic csv file
	def storeValues(String objectClassName,Long objectId, Object tokens) {
		def attrList = Attribute.list()	//@TODO: hardcoded
		def attrMap = [:]
		attrList.each{
			attrMap.put(it.position,it)
		}
		def attrValue,attr
		tokens.eachWithIndex{it,idx ->
			if(it) {
				attr = attrMap.get(idx)
				attrValue = new AttributeValue()
				attrValue.objectClassName = objectClassName
				attrValue.objectId = objectId
				attrValue.attribute = attr
				attrValue.value = it
				attrValue.updator = attrValue.creator = 'system'
				if(!attrValue.save())
					attrValue.errors.allErrors.each {log.debug("exception in saving attrValue:"+ it)}
			}
		}
	}
	
	
	//refresh the individual summary objects, truncate and rebuild if no params else refresh only for the spefcified ids
	def refreshIndividualSummary(Map params) {
		def sql = new Sql(dataSource)
		def query=""
		
		if(params?.idlist) {
		}
		else {
			//blankout
			query="truncate individual_summary;"
			sql.execute(query);
			//basic data
			query="insert into individual_summary (version,indid,name,refresh_date) select 0,i.id,if(initiated_name is not null and trim(initiated_name)!='',initiated_name,legal_name) name,now() from individual i;"
			sql.execute(query);
			//phone
			//query="update individual_summary il, (select i.id,group_concat(concat(vc.category,':',vc.number)) number from individual i, voice_contact vc where i.id=vc.individual_id group by i.id) vct set il.phone=vct.number where il.indid=vct.id;"
			query="update individual_summary il, (select i.id,group_concat(concat(vc.number,',')) number from individual i, voice_contact vc where i.id=vc.individual_id and vc.category='CellPhone' group by i.id) vct set il.phone=vct.number where il.indid=vct.id;"
			sql.executeUpdate(query);
			//email
			//query="update individual_summary il, (select i.id,group_concat(concat(ec.category,':',ec.email_address)) email from individual i, email_contact ec where i.id=ec.individual_id group by i.id) ect set il.email=ect.email where il.indid=ect.id;"
			query="update individual_summary il, (select i.id,group_concat(concat(ec.email_address,',')) email from individual i, email_contact ec where i.id=ec.individual_id and ec.category='Personal' group by i.id) ect set il.email=ect.email where il.indid=ect.id;"
			sql.executeUpdate(query);
			//address
			query="update individual_summary il, (select id,group_concat(concat(category,':',address)) address from (select i.id,a.category,group_concat(concat(a.address_line1,' CITY:',c.name,' STATE:',s.name,' COUNTRY:',ctry.name,' PIN:',ifnull(a.pincode,''))) address from individual i, address a,city c, state s,country ctry  where i.id=a.individual_id and a.city_id=c.id and a.state_id=s.id and a.country_id=ctry.id group by i.id,a.category) q group by id) qa set il.address=qa.address where il.indid=qa.id;"
			sql.executeUpdate(query);
			//update familyid
			query="update individual_summary il, relationship r set il.familyid=r.individual2_id where r.status='ACTIVE' and r.relationship_group_id!=1 and il.indid=r.individual1_id;"
			sql.executeUpdate(query);
			//update head of family as root
			query="update individual_summary il, (select distinct familyid from individual_summary) f set il.familyid=f.familyid where il.indid=f.familyid;"
			sql.executeUpdate(query);
			//update family name
			query="update individual_summary il1, individual_summary il2 set il1.familyof=il2.name where il1.familyid=il2.indid;"
			sql.executeUpdate(query);
			//update clor fields
			query="update individual_summary il,relationship set clorid=individual2_id where individual1_id=il.indid and relation_id=(select id from relation where name='Councellee of') and status='ACTIVE';"
			sql.executeUpdate(query);
			query="update individual_summary ilclee, individual_summary clor set ilclee.counsellor=clor.name where ilclee.clorid=clor.indid;"
			sql.executeUpdate(query);
			//update guru fields
			query="update individual_summary il,relationship set guruid=individual2_id where individual1_id=il.indid and relation_id=(select id from relation where name='Disciple of') and status='ACTIVE';"
			sql.executeUpdate(query);
			query="update individual_summary ildisc, individual_summary guru set ildisc.guru=guru.name where ildisc.guruid=guru.indid;"
			sql.executeUpdate(query);
			//update cult fields
			query="update individual_summary il,relationship set cultid=individual2_id where individual1_id=il.indid and relation_id=(select id from relation where name='Cultivated by') and status='ACTIVE';"
			sql.executeUpdate(query);
			query="update individual_summary il, individual_summary cult set il.cultivator=cult.name where il.cultid=cult.indid;"
			sql.executeUpdate(query);

			//update summary fields
			query="update individual_summary il,(select individual_id,count(1) c from address group by individual_id) a set il.numaddresses=c where il.indid=a.individual_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select individual_id,count(1) c from voice_contact group by individual_id) vc set il.numphones=c where il.indid=vc.individual_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select individual_id,count(1) c from email_contact group by individual_id) ec set il.numemails=c where il.indid=ec.individual_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select individual_id,count(1) c from event_participant group by individual_id) e set il.numep=c where il.indid=e.individual_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select individual_id,count(1) c from event_registration group by individual_id) e set il.numer=c where il.indid=e.individual_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select issued_to_id,sum(total_amount) c from challan group by issued_to_id) e set il.bookstaken=c where il.indid=e.issued_to_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select issued_to_id,sum(total_amount+settle_amount) c from challan where status='SETTLED' group by issued_to_id) e set il.booksdist=c where il.indid=e.issued_to_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select donated_by_id,sum(amount) c from donation group by donated_by_id) e set il.donation=c where il.indid=e.donated_by_id;"
			sql.executeUpdate(query);
			query="update individual_summary il,(select collected_by_id,sum(amount) c from donation group by collected_by_id) e set il.collection=c where il.indid=e.collected_by_id;"
			sql.executeUpdate(query);
			
		}
		
		sql.close();
	}
	

	def clorBoardSummaryData(String rolename) {
		def result = []
		
		def sql = new Sql(dataSource)
		
		//#clees
		def query="select qir.individual_id,count(1) c from (select * from individual_role ir where ir.role_id=(select id from role where name='PuneLeadCouncellors') and status='VALID') qir left join individual_summary isum on qir.individual_id=isum.clorid group by clorid order by qir.individual_id"
		def queryResults = sql.rows(query)
		def corlist = []
		queryResults.eachWithIndex{it, index ->
			corlist.add([it[1],index+1])
		}
		result.add(corlist)
		
		//#donation
		query="select qir.individual_id,sum(donation+collection) c from (select * from individual_role ir where ir.role_id=(select id from role where name='PuneLeadCouncellors') and status='VALID') qir left join individual_summary isum on qir.individual_id=isum.clorid group by clorid order by qir.individual_id"
		queryResults = sql.rows(query)
		corlist = []
		queryResults.eachWithIndex{it, index ->
			corlist.add([(it[1]?:0)/100000,index+1])
		}
		result.add(corlist)

		//#books
		query="select qir.individual_id,sum(booksdist) c from (select * from individual_role ir where ir.role_id=(select id from role where name='PuneLeadCouncellors') and status='VALID') qir left join individual_summary isum on qir.individual_id=isum.clorid group by clorid order by qir.individual_id"
		queryResults = sql.rows(query)
		corlist = []
		queryResults.eachWithIndex{it, index ->
			corlist.add([(it[1]?:0)/1000,index+1])
		}
		result.add(corlist)


		sql.close()

		//log.debug("Result:"+result)		
		return result
		//return [[[1,25],[2,15],[3,13]]]
		//return [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]]
		//return [dataP,dataM,dataC,dataB]
	}	


	def clorSummaryData(String clorid) {
		def result = []
		
		def sql = new Sql(dataSource)
		
		//#clees
		def query="select clorid,if(is_male,'Prabhuji','Mataji'),count(1) from individual_summary isum,individual i where isum.indid=i.id and (i.status is null or i.status='VALID') group by clorid,is_male having clorid="+clorid
		def queryResults = sql.rows(query)
		def corlist = []
		queryResults.eachWithIndex{it, index ->
			corlist.add([it[1],it[2]])
		}
		result.add(corlist)
		

		sql.close()

		log.debug("clorSummaryData:"+result)		
		return result
		//return [[[1,25],[2,15],[3,13]]]
		//return [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]]
		//return [dataP,dataM,dataC,dataB]
	}	

	def clorBookDistributionData(String clorid) {
		def result = []
		
		def sql = new Sql(dataSource)
		
		//#books per clee
		def query="""
			select ibp.*,isum.clorid,isum.counsellor from (
			select q.*,(q.SmallPoint+q.MediumPoint+q.BigPoint+q.MahaBigPoint) BookPoints  from
			(SELECT  P.dist_id,P.distributor,
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
			FROM    (select i.id dist_id,ifnull(i.initiated_name,i.legal_name) distributor,b.category,b.point,sum((cli.issued_quantity-cli.returned_quantity)) numdist from challan c, challan_line_item cli, book b, individual i where c.issued_to_id=i.id and c.id=cli.challan_id and c.status='SETTLED' and cli.book_id=b.id group by distributor,b.category having numdist >0) P
			GROUP BY P.distributor) q) ibp , individual_summary isum where ibp.dist_id=isum.indid and clorid="""
		query = query+clorid			
		
		def queryResults = sql.rows(query)
		def smallBook = []
		def mediumBook = []
		def bigBook = []
		def mahabigBook = []
		queryResults.eachWithIndex{it, index ->
			def datas=[]
			datas.add(it[1]?:'Others')
			datas.add(it[2])
			smallBook.add(datas)

			def datam=[]
			datam.add(it[1]?:'Others')
			datam.add(it[3])
			mediumBook.add(datas)

			def datab=[]
			datab.add(it[1]?:'Others')
			datab.add(it[4])
			bigBook.add(datab)

			def datamb=[]
			datamb.add(it[1]?:'Others')
			datamb.add(it[5])
			mahabigBook.add(datamb)
		}
		result.add(smallBook)
		result.add(mediumBook)
		result.add(bigBook)
		result.add(mahabigBook)
		
		sql.close()

		log.debug("Result:"+[smallBook,mediumBook,bigBook,mahabigBook])		
		return [smallBook,mediumBook,bigBook,mahabigBook]
		//return [[[1,25],[2,15],[3,13]]]
		//return [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]]
		//return [dataP,dataM,dataC,dataB]
	}	

	def clorDonationData(String clorid) {
		def result = []
		def list = []
		
		def sql = new Sql(dataSource)
		
		//#clee family donation
		def query="select familyid,familyof,sum(donation+collection) contribution from individual_summary group by clorid,familyid having contribution>0 and clorid="+clorid
		def queryResults = sql.rows(query)
		def dlist = []
		queryResults.eachWithIndex{it, index ->
			//dlist.add([it[1],it[2]])
			def data = []
			data.add(it[1]?:'Others')
			data.add(it[2])
			list.add(data)			
		}
		//result.add(dlist)

		sql.close()

		log.debug("clorDonationData:"+[list])		
		return [list]
		//return [[[1,25],[2,15],[3,13]]]
		//return [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]]
		//return [dataP,dataM,dataC,dataB]
	}	
	
	def clorIndividualData(String clorid) {
		def result = []
		
		def sql = new Sql(dataSource)

		def instation,outstation
		
		//#pune @TODO: get home city from counsellor's home city
		def query="select clorid,counsellor,count(1) from individual_summary isum,address a where isum.indid=a.individual_id and a.category='Correspondence' and a.city_id=(select id from city where name='Pune') group by clorid having clorid="+clorid	
		def queryResults = sql.rows(query)
		def instationCount = []
		queryResults.eachWithIndex{it, index ->
			instationCount.add(['In-Station',it[2]])
			instation=it[2]
		}
		

		//#outside pune
		query="select clorid,counsellor,count(1) from individual_summary isum,address a where isum.indid=a.individual_id and a.category='Correspondence' and a.city_id!=(select id from city where name='Pune') group by clorid having clorid="+clorid	
		queryResults = sql.rows(query)
		def outstationCount = []
		queryResults.eachWithIndex{it, index ->
			outstationCount.add(['Out-station',it[2]])
			outstation=it[2]
		}

		def data=[]
		data.add(['In-Station',instation])
		data.add(['Out-Station',outstation])
		
		result.add(data)

		sql.close()

		log.debug("clorIndividualData:"+result)		
		return result
		//return [[[1,25],[2,15],[3,13]]]
		//return [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]]
		//return [dataP,dataM,dataC,dataB]
	}
	
	def eventSummary(String clorid) {
		def sql = new Sql(dataSource)
		
		def query="select q.id,q.name,date_format(q.event,'%d %b') occ,type,phone,email from (select i.id,isum.name,i.dob event,'Birthday' type,isum.phone,isum.email,clorid from individual i, individual_summary isum where i.id=isum.indid and month(i.dob)=month(curdate()) and clorid="+clorid	
		query += " union "		
		query += "select i.id,isum.name,i.marriage_anniversary event,'MarriageAnniversary' type,isum.phone,isum.email,clorid from individual i, individual_summary isum where i.id=isum.indid and month(i.marriage_anniversary)=month(curdate()) and clorid="+clorid	+" ) q order by occ"
		
		
		def queryResults = sql.rows(query)

		sql.close()

		log.debug("eventSummary:"+query)		
		log.debug("eventSummary:"+queryResults)		
		return queryResults
	}
	
	def sheet(Map params) {
		def results=[]
		if(!params.eventid) {
			def indRoles = IndividualRole.createCriteria().list(){
					if(params.ids)
						role{'in'('id',params.ids.tokenize(',').collect{new Long(it)})}
					if(params.names)
						role{'in'('name',params.names.tokenize(',').collect{it})}
					eq('status','VALID')
					individual{order('initiatedName') order('legalName')}
				}
			indRoles.each{ir->
				results.add(ir.individual)
			}
		}
		if(params.eventid) {
			def eps = EventParticipant.createCriteria().list(){
						event{eq('id',new Long(params.eventid))}
						individual{order('initiatedName') order('legalName')}
					}
			eps.each{ep->
				results.add(ep.individual)
			}
		}
		//log.debug("results->"+results)
		return results
	}

	def indrolesInPairs(Map params) {
		def pairs=[], pair=[]
		def indRoles = IndividualRole.createCriteria().list(){
				role{eq('id',new Long(params.id))}
				eq('status','VALID')
				individual{order('initiatedName') order('legalName')}
			}
		def seen = []
		indRoles.each{ir->
			//check if this person is already processed
			if(!(seen.contains(ir.individual.id))) {
				pair = findHusbandOrWifeRelationship(ir.individual)
				if(pair.size()==0)
					pair = [ir.individual]
				pair.each{
					seen.add(it.id)
					}
				pairs.add(pair)
				}
		}
		log.debug("seen->"+seen)
		return pairs
	}
	
	def findRelationship(Individual individual, String relationName, Boolean primary) {
		Relationship.createCriteria().get(){
					if(primary)
						eq('individual1',individual)
					else
						eq('individual2',individual)
					eq('status','ACTIVE')						
					relation{eq('name',relationName)}						
				}
	}

	def findHusbandOrWifeRelationship(Individual ind) {
		log.debug("findHusbandOrWifeRelationship:"+ind)
		def rship,pair=[]
		//1. ind is primary, find wife or husband
		rship = findRelationship(ind,'Wife',true)
		if(rship)
			pair = [ind,rship.individual2]
		else {
			rship = findRelationship(ind,'Husband',true)
			if(rship)
				pair = [ind,rship.individual2]
		}
		//2. ind is secondary, find husband or wife
		if(pair.size()==0) {
			rship = findRelationship(ind,'Husband',false)
			if(rship)
				pair = [rship.individual1,ind]
			else {
				rship = findRelationship(ind,'Wife',false)
				if(rship)
					pair = [rship.individual1,ind]
			}
		}
		log.debug("findHusbandOrWifeRelationship Got:"+pair)
		return pair
	}

}
