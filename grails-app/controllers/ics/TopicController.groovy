package ics

import grails.converters.JSON

class TopicController {

    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10,  100)
        [topicInstanceList: Topic.list(params), topicInstanceTotal: Topic.count()]
    }

    def create = {
        def topicInstance = new Topic()
        topicInstance.properties = params
        return [topicInstance: topicInstance]
    }

    def save = {
        def topicInstance = new Topic(params)
        if (!topicInstance.hasErrors() && topicInstance.save()) {
            flash.message = "topic.created"
            flash.args = [topicInstance.id]
            flash.defaultMessage = "Topic ${topicInstance.id} created"
            redirect(action: "show", id: topicInstance.id)
        }
        else {
            render(view: "create", model: [topicInstance: topicInstance])
        }
    }

    def show = {
        def topicInstance = Topic.get(params.id)
        if (!topicInstance) {
            flash.message = "topic.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Topic not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [topicInstance: topicInstance]
        }
    }

    def edit = {
        def topicInstance = Topic.get(params.id)
        if (!topicInstance) {
            flash.message = "topic.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Topic not found with id ${params.id}"
            redirect(action: "list")
        }
        else {
            return [topicInstance: topicInstance]
        }
    }

    def update = {
        def topicInstance = Topic.get(params.id)
        if (topicInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (topicInstance.version > version) {
                    
                    topicInstance.errors.rejectValue("version", "topic.optimistic.locking.failure", "Another user has updated this Topic while you were editing")
                    render(view: "edit", model: [topicInstance: topicInstance])
                    return
                }
            }
            topicInstance.properties = params
            if (!topicInstance.hasErrors() && topicInstance.save()) {
                flash.message = "topic.updated"
                flash.args = [params.id]
                flash.defaultMessage = "Topic ${params.id} updated"
                redirect(action: "show", id: topicInstance.id)
            }
            else {
                render(view: "edit", model: [topicInstance: topicInstance])
            }
        }
        else {
            flash.message = "topic.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Topic not found with id ${params.id}"
            redirect(action: "edit", id: params.id)
        }
    }

    def delete = {
        def topicInstance = Topic.get(params.id)
        if (topicInstance) {
            try {
                topicInstance.delete()
                flash.message = "topic.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Topic ${params.id} deleted"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "topic.not.deleted"
                flash.args = [params.id]
                flash.defaultMessage = "Topic ${params.id} could not be deleted"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "topic.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Topic not found with id ${params.id}"
            redirect(action: "list")
        }
    }

    def jq_topic_list = {
      def sortIndex = params.sidx ?: 'name'
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def result = Topic.createCriteria().list(max:maxRows, offset:rowOffset) {
		if (params.name)
			ilike('name',params.name)

		if (params.frequency)
				eq('frequency',params.frequency)

		if (params.viaSMS)
			eq('viaSMS',new Boolean(params.viaSMS))

		if (params.viaEmail)
			eq('viaEmail',new Boolean(params.viaEmail))

		if (params.viaPost)
			eq('viaPost',new Boolean(params.viaPost))

		if (params.comments)
			ilike('comments',params.comments)

		if (params.status)
				eq('frequency',params.status)

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    it.name,
            	    it.frequency,
            	    it.viaSMS,
            	    it.viaEmail,
            	    it.viaPost,
            	    it.comments,
            	    it.status,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_topic = {
	      log.debug('In jq_topic_edit:'+params)
	      def topic = null
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add topic sent				
		  topic = new Topic(params)
		  if (! topic.hasErrors() && topic.save()) {
		    message = "Topic Saved.."
		    id = topic.id
		    state = "OK"
		  } else {
		    topic.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save Topic"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check topic exists
			  topic  = Topic.get(it)
			  if (topic) {
			    // delete topic
			    if(!topic.delete())
			    	{
				    topic.errors.allErrors.each {
					log.debug("In jq_topic_edit: error in deleting topic:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the topic by its ID
		  topic = Topic.get(params.id)
		  if (topic) {
		    // set the properties according to passed in parameters
		    topic.properties = params
		    if (! topic.hasErrors() && topic.save()) {
		      message = "Topic  ${topic.id} Updated"
		      id = topic.id
		      state = "OK"
		    } else {
			    topic.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update Topic"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }

    def jq_topicSubscription_list = {
      def sortIndex = params.sidx ?: 'id'
      def sortOrder  = params.sord ?: 'desc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

	def topicInstance = null
	if(params.topicid)
		topicInstance=Topic.get(params.topicid)
		
	def result = TopicSubscription.createCriteria().list(max:maxRows, offset:rowOffset) {
		if(topicInstance)
			eq('topic',topicInstance)

		if (params.name)
			{
				or{
					person{ilike('name',params.name)}
					or{
					individual{ilike('legalName',params.name)}
					individual{ilike('initiatedName',params.name)}
					}
				}
			}

		if (params.topic)
			topic{ilike('name',params.topic)}

		if (params.language)
			eq('language',params.language)

		if (params.viaSMS)
			eq('viaSMS',new Boolean(params.viaSMS))

		if (params.viaEmail)
			eq('viaEmail',new Boolean(params.viaEmail))

		if (params.viaPost)
			eq('viaPost',new Boolean(params.viaPost))

		order(sortIndex, sortOrder)

	}
      
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)

      def jsonCells = result.collect {
            [cell: [
            	    (it.person?.toString()?:it.individual?.toString()),
            	    it.topic.name,
            	    it.language,
            	    it.viaSMS,
            	    it.viaEmail,
            	    it.viaPost,
                ], id: it.id]
        }
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
        }

	def jq_edit_topicSubscription = {
	      def subscription = null
	      def message = ""
	      def state = "FAIL"
	      def id

		def topic = null
		if(params.topicid)
			topic=Topic.get(params.topicid)

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  // add subscription sent		  
		  subscription = new TopicSubscription(params)
		  if (! subscription.hasErrors() && subscription.save()) {
		    message = "TopicSubscription Saved.."
		    id = subscription.id
		    state = "OK"
		  } else {
		    subscription.errors.allErrors.each {
			log.debug(it)
			}
		    message = "Could Not Save TopicSubscription"
		  }
		  break;
		case 'del':
		  	def idList = params.id.tokenize(',')
		  	idList.each
		  	{
			  // check subscription exists
			  subscription  = TopicSubscription.get(it)
			  if (subscription) {
			    // delete subscription
			    if(!subscription.delete())
			    	{
				    subscription.errors.allErrors.each {
					log.debug("In jq_subscription_edit: error in deleting subscription:"+ it)
					}
			    	}
			    else {
				    message = "Deleted!!"
				    state = "OK"
			    }
			  }
		  	}
		  break;
		 default :
		  // edit action
		  // first retrieve the subscription by its ID
		  subscription = TopicSubscription.get(params.id)
		  if (subscription) {
		    // set the properties according to passed in parameters
		    subscription.properties = params
			  subscription.updator = springSecurityService.principal.username
		    if (! subscription.hasErrors() && subscription.save()) {
		      message = "TopicSubscription  ${subscription.regNum} Updated"
		      id = subscription.id
		      state = "OK"
		    } else {
			    subscription.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update TopicSubscription"
		    }
		  }
		  break;
 	 }

	      def response = [message:message,state:state,id:id]

	      render response as JSON
	    }
	    
	def saveSubscription() {
		log.debug("Inside saveSubscription with params : "+params)
		def person = Person.get(params.personid)
		def topicids = params.list('topic.id')
		def subscription,oldsubscription
		topicids.each{
			log.debug("topicid:"+it)
			//@TODO: first check if already exists
			subscription = new TopicSubscription(person:person, 'topic.id':it, language:params.language)
			if(!subscription.save())
			    subscription.errors.allErrors.each {
				println it
				}
			
		}
	      def response = [message:"OK",state:"SUCCESS",id:params.personid]

	      render response as JSON
	}

}
