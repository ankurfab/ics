package ics

class DenominationController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(!params.sort)
        	params.sort = "id"
        if(!params.order)
        	params.order = "desc"
        println '-----------Denomination list-----------'
        println 'params='+Denomination.list(params)
        println 'total='+Denomination.count()
        def denominationList = []
        def denominations = []

        for(int i=0; i<Denomination.count(); i++)
        {
        	//denominationList[i] = (Denomination.list(params)[i])
        	//println 'denominationList[i]='+denominationList[i]
        	for(int j=0;j<Denomination.list(params).size();j++)
        	{
        		denominations[j] = Denomination.list(params)[j].toString().split(";")
        		println 'denominations[j]='+denominations[j]
        	}
        }
        //println '----denominationList='+denominationList
        println 'denominations='+denominations
        /*for(int k=0; k<denominations.size(); k++)
        	denominationList[k] = denominations[k].toString().split(":")
        println '----denominationList='+denominationList.toString().split(":")*/
        [denominationInstanceList: Denomination.list(params), denominationInstanceTotal: Denomination.count(), denominations: denominations]
    }

    def create = {
        def denominationInstance
        //Only 1 denomination per day per person
        def col = Individual.get(session.individualid)
        if(col)
        	{
        	def now = new Date()
        	now.clearTime()
        	println now
        	denominationInstance = Denomination.findByCollectionDateAndCollectedBy(now,col)
        	}
        if(!denominationInstance)
        	{
        	denominationInstance = new Denomination()
        	denominationInstance.properties = params
        	return [denominationInstance: denominationInstance]
        	}
        else
        	redirect(action: "edit", id: denominationInstance.id)
    }

    def merge = {
        if(!session.individualid)
        	{
		    flash.message = "User not associated with any individual!!"
		    redirect(action: "list")
		    return
        	}
        def collector = Individual.get(session.individualid)
        def denominationInstanceList = Denomination.findAllByStatusAndCollectedByNotEqual("HANDEDOVER",collector)
        if(!(denominationInstanceList?.size()>1))
        	{
		    flash.message = "Minimum 2 denominations are required in HANDEDOVER status for merging!!"
		    redirect(action: "list")
		    return
        	}
        def now = new Date()
        now.clearTime()
        def denominationInstance = new Denomination()
        denominationInstance.collectedBy = collector
        denominationInstance.collectionDate = now
        denominationInstance.status = 'TAKENOVER'
        denominationInstance.creator = springSecurityService.principal.username
        denominationInstance.updator = 'system'
        denominationInstance.fiftyPaiseCoinQty = 0
	denominationInstance.oneRupeeCoinQty = 0
	denominationInstance.twoRupeeCoinQty = 0
	denominationInstance.fiveRupeeCoinQty = 0
	denominationInstance.tenRupeeCoinQty = 0
	denominationInstance.oneRupeeNoteQty = 0
	denominationInstance.twoRupeeNoteQty = 0
	denominationInstance.fiveRupeeNoteQty = 0
	denominationInstance.tenRupeeNoteQty = 0
	denominationInstance.twentyRupeeNoteQty = 0
	denominationInstance.fiftyRupeeNoteQty = 0
	denominationInstance.hundredRupeeNoteQty = 0
	denominationInstance.fiveHundredRupeeNoteQty = 0
	denominationInstance.oneThousandRupeeNoteQty = 0
	denominationInstance.comments = ""
	denominationInstance.save(flush: true)
	
        denominationInstanceList.each { i->
        	denominationInstance.fiftyPaiseCoinQty	 += i.fiftyPaiseCoinQty
		denominationInstance.oneRupeeCoinQty	 += i.oneRupeeCoinQty
		denominationInstance.twoRupeeCoinQty	 += i.twoRupeeCoinQty
		denominationInstance.fiveRupeeCoinQty	 += i.fiveRupeeCoinQty
		denominationInstance.tenRupeeCoinQty	 += i.tenRupeeCoinQty
		denominationInstance.oneRupeeNoteQty	 += i.oneRupeeNoteQty
		denominationInstance.twoRupeeNoteQty	 += i.twoRupeeNoteQty
		denominationInstance.fiveRupeeNoteQty	 += i.fiveRupeeNoteQty
		denominationInstance.tenRupeeNoteQty	 += i.tenRupeeNoteQty
		denominationInstance.twentyRupeeNoteQty	 += i.twentyRupeeNoteQty
		denominationInstance.fiftyRupeeNoteQty	 += i.fiftyRupeeNoteQty
		denominationInstance.hundredRupeeNoteQty	 += i.hundredRupeeNoteQty
		denominationInstance.fiveHundredRupeeNoteQty	 += i.fiveHundredRupeeNoteQty
		denominationInstance.oneThousandRupeeNoteQty	 += i.oneThousandRupeeNoteQty
		if(i.comments)
			denominationInstance.comments += i.id + ":" + i.comments + "\n"
		i.status='MERGED'
		i.updator = 'system'
		i.ackRef = denominationInstance.id
		i.save()
        }
        if (denominationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'denomination.label', default: 'Denomination'), denominationInstance.id])}" + "!! You may modify the denominations now!"
            render(view: "edit", model: [denominationInstance: denominationInstance])
        }
        else {
            flash.message = "Some error occured while merging the pending denomninations!!"
            redirect(action: "list")
        }
    }

    def save = {
	if (springSecurityService.isLoggedIn()) {
		params.creator=springSecurityService.principal.username
	}
	else
		params.creator=""
	params.updator=params.creator
	
	def now = new Date()
	now.clearTime()
        def denominationInstance = new Denomination(params)
        denominationInstance.collectionDate = now
        denominationInstance.status = 'PENDING'
        if (denominationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'denomination.label', default: 'Denomination'), denominationInstance.id])}"
            redirect(action: "show", id: denominationInstance.id)
        }
        else {
            render(view: "create", model: [denominationInstance: denominationInstance])
        }
    }

    def show = {
        def denominationInstance = Denomination.get(params.id)
        if (!denominationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'denomination.label', default: 'Denomination'), params.id])}"
            redirect(action: "list")
        }
        else {
            [denominationInstance: denominationInstance]
        }
    }

    def edit = {
        //def denominationInstance = Denomination.get(params.id)
        //Only self created pending denominations can be edited
        def col = Individual.get(session.individualid)
        def denominationInstance
        def msg = ""
        if (col) {
            denominationInstance = Denomination.findByIdAndCollectedBy(params.id,col)
            if(denominationInstance?.status!='PENDING')
            	{
            	denominationInstance = null
            	msg = "Only one(1) denomination can be handedover daily!!"
            	}
        }
        
        if (!col || !denominationInstance) {
            flash.message = msg?:"Only self created pending denominations can be edited!!"
            redirect(action: "list")
        }
        else {
            return [denominationInstance: denominationInstance]
        }
    }

    def takeover = {
        //Only other created pending denominations can be taken over
        def denominationInstance = Denomination.get(params.id)
        if(denominationInstance?.status!='PENDING' || denominationInstance?.collectedBy?.id==session.individualid)
        {
                flash.message = "Only other created pending denominations can be taken over!!"
                redirect(action: "show", id: params.id)
        }
        else {
            return [denominationInstance: denominationInstance]
        }
    }

    def deposit = {
        //Only TAKENOVER denominations can be submitted to AccountsOffice!!
        def denominationInstance = Denomination.get(params.id)
        //if(denominationInstance?.status!='HANDEDOVER')
        if(denominationInstance?.status!='TAKENOVER')
        {
                flash.message = "Only TAKENOVER denominations can be submitted to AccountsOffice!!"
                redirect(action: "show", id: params.id)
        }
        else {
            return [denominationInstance: denominationInstance]
        }
    }

    def update = {
        def denominationInstance = Denomination.get(params.id)
        if (denominationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (denominationInstance.version > version) {
                    
                    denominationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'denomination.label', default: 'Denomination')] as Object[], "Another user has updated this Denomination while you were editing")
                    render(view: "edit", model: [denominationInstance: denominationInstance])
                    return
                }
            }
            if (params.status=="SUBMITTED" && !params.ackRef) {
                    denominationInstance.errors.rejectValue("ackRef", "ack", [] as Object[], "Please specify Ack Reference !!")
                    render(view: "deposit", model: [denominationInstance: denominationInstance])
                    return
            }
	if (springSecurityService.isLoggedIn()) {
		params.updator=springSecurityService.principal.username
	}
	else
		params.updator="unknown"

            denominationInstance.properties = params
            if(params.newcomments)
            	denominationInstance.comments = (denominationInstance.comments?:"") + "\n"+params.newcomments
            //if(denominationInstance.status=="HANDEDOVER")
            if(denominationInstance.status=="TAKENOVER")
            	{
            	denominationInstance.ackBy = Individual.get(session.individualid)
            	denominationInstance.ackDate = new Date()
            	}
            if (!denominationInstance.hasErrors() && denominationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'denomination.label', default: 'Denomination'), denominationInstance.id])}"
                redirect(action: "show", id: denominationInstance.id)
            }
            else {
                render(view: "edit", model: [denominationInstance: denominationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'denomination.label', default: 'Denomination'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def denominationInstance = Denomination.get(params.id)
        //Only self created pending denominations can be deleted
        if(!(denominationInstance?.status=='PENDING' && denominationInstance?.collectedBy?.id==session.individualid))
        {
                flash.message = "Only self created pending denominations can be deleted"
                redirect(action: "show", id: params.id)
                return
        }

        if (denominationInstance) {
            try {
                denominationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'denomination.label', default: 'Denomination'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'denomination.label', default: 'Denomination'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'denomination.label', default: 'Denomination'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def search = {
	if(params.sColDate)
		params.sColDate = Date.parse('dd-MM-yyyy', params.sColDate)
	if(params.sAckDate)
		params.sAckDate = Date.parse('dd-MM-yyyy', params.sAckDate)


	    def criteria = Denomination.createCriteria()
	    def denominationList = criteria {
			and {
				if (params.sComments)
			    		like("comments", "%"+params.sComments+"%")
				if (params.sStatus)
			    		like("status", "%"+params.sStatus+"%")
				if (params.sAckRef)
			    		like("ackRef", "%"+params.sAckRef+"%")
				if (params.sColDate)
			    		eq("collectionDate", params.sColDate)
				if (params.sAckDate)
			    		eq("ackDate", params.sAckDate)
				if (params.sColName)
					{
					collectedBy {
						or
							{
							like("legalName", "%"+params.sColName+"%")
							like("initiatedName", "%"+params.sColName+"%")
							}
					    }
					}
				if (params.sAckName)
					{
					ackBy {
						or
							{
							like("legalName", "%"+params.sAckName+"%")
							like("initiatedName", "%"+params.sAckName+"%")
							}
					    }
					}
				}
       		 	}
                render(view: "list", model: [denominationInstanceList: denominationList, search: true])
    }
    
}
