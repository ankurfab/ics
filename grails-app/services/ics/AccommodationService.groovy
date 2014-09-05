package ics

import java.text.SimpleDateFormat

class AccommodationService {

    def springSecurityService

    def serviceMethod() {
    }
    
    def initializeChart(EventAccommodation acc) {
    	println "Inside initializeChart..."
    	if(!acc.chart)
    		{
    		println "creating chart.."
    		def chart = new Chart()
    		if(acc.isVipAccommodation)
    			chart.name = "VIPACCO_"+acc.id
    		else
    			chart.name = "ACCO_"+acc.id
    		chart.creator=chart.updator="system"
    		if(!chart.save(flush:true))
		     {
		     chart.errors.allErrors.each {
				 println chart.name+"chart error"+it
			    }
			return false
			}
    		acc.chart = chart
    		println "created chart.."+chart
    		if(!acc.save(flush:true)) {
		     acc.errors.allErrors.each {
				 println it
			    }
			chart.delete()
			return false
		}
		println "Chart created: "+acc.chart
		//now populate the chart
		populateChart(acc)
		return true
		}
    	return false
    }

    def addToChart(EventAccommodation acc) {
    	
    }
    
    def populateChart(EventAccommodation acc) {
    	def fromDate = acc.availableFromDate.clone()
    	def toDate = acc.availableTillDate.clone()
    	println "Inside populateChart: "+fromDate+" : "+toDate
    	int fromHour = fromDate.getAt(Calendar.HOUR_OF_DAY)
    	int toHour = toDate.getAt(Calendar.HOUR_OF_DAY)
    	int toMin = toDate.getAt(Calendar.MINUTE)
    	def endDate
    	if(toHour==0 && toMin==0)
    		{
    		endDate = toDate-1 //booking till midnight of previous day
    		toHour = 23
    		toMin = 59
    		}
    	else
    		endDate = toDate
    	
    	fromDate.clearTime()
    	toDate.clearTime()
    	def flag=true
    	int i=0
    	int start = fromHour
    	int end = 24
    	if(endDate.compareTo(fromDate)==0)
    		end=(toHour+1)
    	def ci
    	def nextDay = fromDate 
    	println "dates in populateChart: "+fromHour+" "+toHour+" "+toMin+" "+endDate+" "+fromDate+" "+toDate+" "+nextDay
    	while(nextDay.compareTo(endDate)<=0) {
		println endDate.toString() +" "+nextDay.toString()+" "+start+" "+end
		for(i=start;i<end;i++)
			{
			println "loop.. "+i+ " "+nextDay
			if (i>24)
				{
				println "ERROR"
				break
				}
			ci = new ChartItem()
			ci.chart = acc.chart
			ci.date = nextDay
			ci.slot = i
			ci.ia0 = acc.maxCapacity?:((acc.maxPrabhujis?:0)+(acc.maxMatajis?:0)+(acc.maxChildrens?:0)+(acc.maxBrahmacharis?:0))
			ci.ia1 = acc.maxPrabhujis?:0
			ci.ia2 = acc.maxMatajis?:0
			ci.ia3 = acc.maxChildrens?:0
			ci.ia4 = acc.maxBrahmacharis?:0
			ci.creator=ci.updator="system"
			if(!ci.save())
			     ci.errors.allErrors.each {
					 println it
				    }
			println ci
			}
		nextDay = nextDay+1
		start=0
		if(endDate.compareTo(nextDay)==0)
			end=(toHour+1)
		else
			end=24
		
    	}
    }
    
    def checkSlot(String vip,Date fromDate, int slot, int numR, int numP, int numM, int numC, int numB) {
    	log.debug("Inside checkSlot..")
    	def results = []
	def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	def srchDate = formatter.format(fromDate)
	def chrtnm = vip+'ACCO_%'
	//first get all the availability in the first hour
	def query1 = ChartItem.where{
			(chart.name==~chrtnm && date==fromDate && slot==slot && ia1>=numP && ia2>=numM && ia3>=numC  && ia4>=numB)
			sqlRestriction "date="+srchDate
		}
	def query2 = ChartItem.where{
			(chart.name==~chrtnm && date==fromDate &&  slot==slot && ia0>=numR )
			sqlRestriction "date="+srchDate
		}
	def startChartItems = []
	if(numR>0)
		startChartItems = query2.list()
	else
		startChartItems = query1.list()
	
	/*startChartItems.each{ sci->
		//now get availability duration
		def chart = sci.chart
		def chartItems = 
	}*/
	return startChartItems?.collect{it.chart}
    }

    def updateSlot(String vip,Date fromDate, int slot, int numR, int numP, int numM, int numC, int numB) {
    	log.debug("Inside updateSlot..")
    	def results = []
	def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	def srchDate = formatter.format(fromDate)
	def chrtnm = vip+'ACCO_%'
	//first get all the availability in the first hour
	def query1 = ChartItem.where{
			(chart.name==~chrtnm && date==fromDate && slot==slot && ia1>=numP && ia2>=numM && ia3>=numC  && ia4>=numB)
			sqlRestriction "date="+srchDate
		}
	def query2 = ChartItem.where{
			(chart.name==~chrtnm && date==fromDate &&  slot==slot && ia0>=numR )
			sqlRestriction "date="+srchDate
		}
	def startChartItems = []
	if(numR>0)
		startChartItems = query2.list()
	else
		startChartItems = query1.list()
	
	if(startChartItems?.size()>0)
		{
		def ci = startChartItems[0]
		if(numR>0)
			{
			ci.ia0 -= numR
			}
		else
			{
			ci.ia0 -= (numP+numM+numC+numB)
			ci.ia1 -= numP
			ci.ia2 -= numM
			ci.ia3 -= numC
			ci.ia4 -= numB
			}
		ci.save()
		return true
		}
	else
		throw new Exception("Slot taken!!")
    }

    def allocate(EventRegistration er, EventAccommodation acc, String vip, Date fromDate, Date toDate, int numR, int numP, int numM, int numC, int numB) {
    	println "Inside allocate: "+fromDate+" : "+toDate
    	
    	//set the nos correctly
    	if(numR>0)
    		{
    		numP=numM=numC=numB=0
    		}
    	else
    		numR = (numP+numM+numC+numB)
    		
    	def origFromDate = fromDate.clone()
    	def origToDate = toDate.clone()
    	
    	int fromHour = fromDate.getAt(Calendar.HOUR_OF_DAY)
    	int toHour = toDate.getAt(Calendar.HOUR_OF_DAY)
    	int toMin = toDate.getAt(Calendar.MINUTE)
    	def endDate
    	if(toHour==0 && toMin==0)
    		{
    		endDate = toDate-1 //booking till midnight of previous day
    		toHour = 23
    		toMin = 59
    		}
    	else
    		endDate = toDate
    	
    	fromDate.clearTime()
    	toDate.clearTime()
    	def flag=true
    	int i=0
    	int start = fromHour
    	int end = 24
    	if(endDate.compareTo(fromDate)==0)
    		end=(toHour+1)
    	def ci
    	def nextDay = fromDate 
    	println "dates in allocate: "+fromHour+" "+toHour+" "+toMin+" "+endDate+" "+fromDate+" "+toDate+" "+nextDay
    	while(nextDay.compareTo(endDate)<=0) {
		println endDate.toString() +" "+nextDay.toString()+" "+start+" "+end
		for(i=start;i<end;i++)
			{
			println "loop.. "+i+ " "+nextDay
			if (i>24)
				{
				println "ERROR"
				break
				}
			updateSlot(vip,nextDay, i, numR, numP, numM, numC, numB)
			}
		nextDay = nextDay+1
		start=0
		if(endDate.compareTo(nextDay)==0)
			end=(toHour+1)
		else
			end=24
		
    	}
    	def aa = new AccommodationAllotment()
    	aa.eventRegistration = er
    	aa.eventAccommodation = acc
	aa.numberAllotted = numR
	aa.numberofPrabhujisAllotted = numP
	aa.numberofMatajisAllotted = numM
	aa.numberofChildrenAllotted = numC
	aa.numberofBrahmacharisAllotted = numB
	aa.allottFrom = origFromDate
	aa.allottTill = origToDate
	aa.updator=aa.creator=springSecurityService.principal.username
	if(!aa.save())
		             aa.errors.allErrors.each {
					 println "AccommodationAllottment error"+it
				    }
	else
		{
		//update allocation status
		//todo: also mark complete if done
		er.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
		if(!er.save())
		             er.errors.allErrors.each {
					 println "AccommodationAllottment error in updating er"+it
				    }
		//update accommodation nos
		//todo: also mark complete if done
		acc.availableCapacity -= numR
		acc.availablePrabhujis -= numP
		acc.availableMatajis -= numM
		acc.availableChildrens -= numC
		acc.availableBrahmacharis -= numB
		if(!acc.save())
		             acc.errors.allErrors.each {
					 println "AccommodationAllottment error in updating acc"+it
				    }
		}
    }


    def suggest(String vip,Date fromDate, Date toDate, int numR, int numP, int numM, int numC, int numB) {
    	log.debug("Inside suggest..")
    	println "Inside suggest: "+fromDate+" : "+toDate
    	int fromHour = fromDate.getAt(Calendar.HOUR_OF_DAY)
    	int toHour = toDate.getAt(Calendar.HOUR_OF_DAY)
    	int toMin = toDate.getAt(Calendar.MINUTE)
    	def endDate
    	if(toHour==0 && toMin==0)
    		{
    		endDate = toDate-1 //booking till midnight of previous day
    		toHour = 23
    		toMin = 59
    		}
    	else
    		endDate = toDate
    	
    	fromDate.clearTime()
    	toDate.clearTime()
    	def flag=true
    	int i=0
    	int start = fromHour
    	int end = 24
    	if(endDate.compareTo(fromDate)==0)
    		end=(toHour+1)
    	def ci
    	def nextDay = fromDate 
    	println "dates in suggest: "+fromHour+" "+toHour+" "+toMin+" "+endDate+" "+fromDate+" "+toDate+" "+nextDay
    	Set chartSet = []
    	def chartList = []
    	while(nextDay.compareTo(endDate)<=0) {
		println endDate.toString() +" "+nextDay.toString()+" "+start+" "+end
		for(i=start;i<end;i++)
			{
			println "loop.. "+i+ " "+nextDay
			if (i>24)
				{
				println "ERROR"
				break
				}
			chartList = checkSlot(vip,nextDay, i, numR, numP, numM, numC, numB)
			log.debug("chartList: "+chartList)
			chartSet += chartList
			log.debug("chartSet: "+chartSet)
			}
		nextDay = nextDay+1
		start=0
		if(endDate.compareTo(nextDay)==0)
			end=(toHour+1)
		else
			end=24
		
    	}
	return chartSet
    }
    
    def search(String vip, int numP, int numM, int numC, int numB) {
    	def numR = numP+numM+numC+numB
    	def vipFlag = false
    	if(vip)
    		vipFlag = true
    	def availAcclist = EventAccommodation.findAllByIsVipAccommodationAndAvailableCapacityGreaterThanEquals(vipFlag,numR)
    	return availAcclist
    }

    def simpleallocate(String erid, String accid, String vip, int numP, int numM, int numC, int numB) {
    	//todo transaction handling
    	log.debug("Inside simpleallocate for erid:"+erid +" and accid:"+accid+" with counts:P"+numP+" M"+numM+" C"+numC+" B"+numB)
    	def er = EventRegistration.get(erid)
    	def acc = EventAccommodation.get(accid)
    	def status = "FAIL"
    	def message = ""
    	def vipFlag = false
    	if(vip)
    		vipFlag = true
    	
    	int numR = numP+numM+numC+numB
    	
    	if(numR>0 && acc.availableCapacity>=numR)
    		{
    		log.debug("Acco still available.."+erid+":"+accid)
    		def aa = AccommodationAllotment.findByEventRegistrationAndEventAccommodation(er,acc)
    		if(!aa)
    			aa = new AccommodationAllotment()
    			
    		aa.eventRegistration = er
    		aa.eventAccommodation = acc
    		aa.numberAllotted += numR
    		aa.numberofPrabhujisAllotted += numP
    		aa.numberofMatajisAllotted += numM
    		aa.numberofChildrenAllotted += numC
    		aa.numberofBrahmacharisAllotted += numB
    		aa.allottFrom = acc.availableFromDate
    		aa.allottTill = acc.availableTillDate
    		aa.updator = aa.creator = springSecurityService.principal.username
    		if(!aa.save())
		     	{
		     	log.debug("simpleallocate:Error in saving aa:"+erid+":"+accid)
		     	aa.errors.allErrors.each { println it   }
			}
		else
			{
			//update the counts in EventAcco
			acc.availableCapacity -= numR
			acc.availablePrabhujis += numP
			acc.availableMatajis += numM
			acc.availableChildrens += numC
			acc.availableBrahmacharis += numB
			if(!acc.save())
				{
		     		log.debug("simpleallocate:Error in saving acc:"+erid+":"+accid)
				acc.errors.allErrors.each { println it   }
				}
			else
				{
				//get the current allocations
				int numA=0
				int numPA=0
				int numMA=0
				int numCA=0
				int numBA=0
				def allotments = AccommodationAllotment.findAllByEventRegistration(er)
				allotments.each{
					numA += it.numberAllotted
					numPA += it.numberofPrabhujisAllotted
					numMA += it.numberofMatajisAllotted
					numCA += it.numberofChildrenAllotted
					numBA += it.numberofBrahmacharisAllotted
				}
				if(numA==(er.numberofPrabhujis+er.numberofMatajis+er.numberofChildren+er.numberofBrahmacharis))
					er.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE
				else
					er.accommodationAllotmentStatus = AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
				if(!er.save(flush:true))
		     			{
		     			log.debug("simpleallocate:Error in updating er:"+erid+":"+accid)
					     er.errors.allErrors.each {
							 println "AccommodationAllottment error in updating er"+it
						    }
					}
				else
					{
					status="OK"
					message="Accommodation alloted!"
					}
				}
			}
    		}
    	else
    		{
			status="FAIL"
			message="Accommodation not available for the specified capacity ("+numR+") !! Current capacity is "+acc.availableCapacity		
    		}
    	log.debug("In simpleallocate:"+erid+":"+accid+" returning status:"+status+" with message:"+message)
    	return [status: status, message: message]
    }
    
    def deleteAA(String id) {
    	log.debug("In deleteAA: "+id)
    	def aa = AccommodationAllotment.get(id)
    	if(!aa || aa.numberCheckedin>0)
    		return false
    	
    	log.debug("In deleteAA: erid:"+aa.eventRegistration?.id+" accid:"+aa.eventAccommodation?.id)
    	
    	//release the capacity 
    	aa.eventAccommodation.availableCapacity += aa.numberAllotted
    	aa.eventAccommodation.availablePrabhujis -= aa.numberofPrabhujisAllotted
    	aa.eventAccommodation.availableMatajis -= aa.numberofMatajisAllotted
    	aa.eventAccommodation.availableChildrens -= aa.numberofChildrenAllotted
    	aa.eventAccommodation.availableBrahmacharis -= aa.numberofBrahmacharisAllotted
	if(!aa.eventAccommodation.save())
		{
		log.debug("deleteAA:Error on saving ea")
		aa.eventAccommodation.errors.allErrors.each { println it   }
		return false
		}
	else
		{
		//change the registration status
		aa.eventRegistration.accommodationAllotmentStatus=AccommodationAllotmentStatus.ALLOTEMENT_IN_PROGRESS
		if(!aa.eventRegistration.save())
			{
			aa.eventRegistration.errors.allErrors.each { println it   }
			return false
			}
		//finally delete
		if(!aa.delete())
		{
		aa.errors.allErrors.each { println it   }
		return false
		}
		}
    	return true
    }

    def updateAA(Map params) {
    	log.debug("In updateAA: "+params)
    	def aa = AccommodationAllotment.get(params.id)
    	if(!aa)
    		return false
    	//adjust the nos for allotment/availablity
    	int numR = ((params.int('numberofPrabhujisAllotted')?:0)+(params.int('numberofMatajisAllotted')?:0)+(params.int('numberofChildrenAllotted')?:0)+(params.int('numberofBrahmacharisAllotted')?:0)) - aa.numberAllotted
    	log.debug("updateAA..numR: "+numR)
    	aa.eventAccommodation.availableCapacity -= numR
    	aa.eventAccommodation.availablePrabhujis += (params.int('numberofPrabhujisAllotted')-aa.numberofPrabhujisAllotted)
    	aa.eventAccommodation.availableMatajis += (params.int('numberofMatajisAllotted')-aa.numberofMatajisAllotted)
    	aa.eventAccommodation.availableChildrens += (params.int('numberofChildrenAllotted')-aa.numberofChildrenAllotted)
    	aa.eventAccommodation.availableBrahmacharis += (params.int('numberofBrahmacharisAllotted')-aa.numberofBrahmacharisAllotted)

    	//adjust the nos for checkins
    	int numC = ((params.int('numberofPrabhujisCheckedin')?:0)+(params.int('numberofMatajisCheckedin')?:0)+(params.int('numberofChildrenCheckedin')?:0)+(params.int('numberofBrahmacharisCheckedin')?:0)) - aa.numberCheckedin
    	log.debug("updateAA..numC: "+numC)
    	aa.eventAccommodation.totalCheckedin += numC
    	aa.eventAccommodation.totalPrjiCheckedin += (params.int('numberofPrabhujisCheckedin')-aa.numberofPrabhujisCheckedin)
    	aa.eventAccommodation.totalMatajiCheckedin += (params.int('numberofMatajisCheckedin')-aa.numberofMatajisCheckedin)
    	aa.eventAccommodation.totalChildrenCheckedin += (params.int('numberofChildrenCheckedin')-aa.numberofChildrenCheckedin)
    	aa.eventAccommodation.totalBrahmachariCheckedin += (params.int('numberofBrahmacharisCheckedin')-aa.numberofBrahmacharisCheckedin)


	if(!aa.eventAccommodation.save())
		{
		aa.eventAccommodation.errors.allErrors.each { println it   }
		return false
		}
	else 
		{
			aa.numberAllotted = (params.int('numberofPrabhujisAllotted')+params.int('numberofMatajisAllotted')+params.int('numberofChildrenAllotted')+params.int('numberofBrahmacharisAllotted'))
			aa.numberofPrabhujisAllotted = params.int('numberofPrabhujisAllotted')
			aa.numberofMatajisAllotted = params.int('numberofMatajisAllotted')
			aa.numberofChildrenAllotted = params.int('numberofChildrenAllotted')
			aa.numberofBrahmacharisAllotted = params.int('numberofBrahmacharisAllotted')
			
			aa.numberCheckedin = (params.int('numberofPrabhujisCheckedin')+params.int('numberofMatajisCheckedin')+params.int('numberofChildrenCheckedin')+params.int('numberofBrahmacharisCheckedin'))
			aa.numberofPrabhujisCheckedin = params.int('numberofPrabhujisCheckedin')
			aa.numberofMatajisCheckedin = params.int('numberofMatajisCheckedin')
			aa.numberofChildrenCheckedin = params.int('numberofChildrenCheckedin')
			aa.numberofBrahmacharisCheckedin = params.int('numberofBrahmacharisCheckedin')
			
			if(!aa.save())
			{
			aa.errors.allErrors.each { println it   }
			return false
			}
		}
    	return true
    }
    
    def free(String id) {
	def flag = false
	def accommodationAllotment = AccommodationAllotment.get(id)
	if(accommodationAllotment)
		{
			//first reduce the count in the accommodation
			def acco = accommodationAllotment.eventAccommodation
			acco.availableCapacity += accommodationAllotment.numberAllotted
			acco.availablePrabhujis -= accommodationAllotment.numberofPrabhujisAllotted
			acco.availableMatajis -= accommodationAllotment.numberofMatajisAllotted
			acco.availableChildrens -= accommodationAllotment.numberofChildrenAllotted
			acco.availableBrahmacharis -= accommodationAllotment.numberofBrahmacharisAllotted
			if(!acco.save(flush:true))
				{
				log.debug("In accoService.free: Error in updating counts")
				acco.errors.each { println it   }
				return false
				}
				
			//finally delete the accommodationAllotment
			if(!accommodationAllotment.delete(flush:true))
				{
				log.debug("In accoService.free: Error in deleting accommodationAllotment")
				accommodationAllotment.errors.each { println it   }
				return false
				}
			else
				return true
			
		}
	return flag

    }
    
    def getAllotedAccommodation(EventRegistration er) {
	    def places=""

	    def aa = AccommodationAllotment.findAllByEventRegistration(er)
	    aa.each{
		places += it.eventAccommodation?.toString() + " "+it.numberAllotted+"(P"+it.numberofPrabhujisAllotted+" M"+it.numberofMatajisAllotted+" C"+it.numberofChildrenAllotted+" B"+it.numberofBrahmacharisAllotted+"),"
		}
	    return places    
    }

    def getCheckedInAccommodation(EventRegistration er) {
	    def places=""

	    def aa = AccommodationAllotment.findBySubEventRegistration(er)
	    aa.each{
		places += it.eventAccommodation?.toString() + " "+it.numberCheckedin+"(P"+it.numberofPrabhujisCheckedin+" M"+it.numberofMatajisCheckedin+" C"+it.numberofChildrenCheckedin+" B"+it.numberofBrahmacharisCheckedin+"),"
		}
	    return places    
    }
}
