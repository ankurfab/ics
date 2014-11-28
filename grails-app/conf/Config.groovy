import grails.plugins.springsecurity.SecurityConfigType

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.config.locations = [
   "classpath:${appName}-config.groovy",
   "file:${userHome}/.grails/${appName}-config.groovy"]

if (System.properties["${appName}.config.location"]) {
   grails.config.locations << "file:" +
        System.properties["${appName}.config.location"]
}

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text-plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      pdf: 'application/pdf',
                      rtf: 'application/rtf',
                      excel: 'application/vnd.ms-excel',
                      ods: 'application/vnd.oasis.opendocument.spreadsheet',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

grails.resources.modules = {
    jqmobile {
        resource url:'/js/jquery.mobile-1.4.2.min.js'
        resource url: '/css/jquery.mobile-1.4.2.min.css'
    }

    jqui {
        //resource url:'/js/jquery-ui-1.8.18.custom.min.js'
        //resource url: '/css/redmond/jquery-ui-1.8.23.custom.css'
        //resource url:'/js/jquery-ui-1.9.1.custom.min.js'
        //resource url: '/css/redmond/jquery-ui-1.9.1.custom.min.css'
        resource url:'/js/jquery-ui-1.8.23.custom.min.js'
        resource url: '/css/redmond/jquery-ui-1.8.23.custom.css'
    }

    dateTimePicker {
        dependsOn 'jqui'
        resource url: '/js/jquery-ui-timepicker-addon.js'
	resource url:'/css/jquery-ui-timepicker-addon.css'
    }


    fullCalendar {
        dependsOn 'jqui'
        resource url:'/js/fullcalendar.min.js'
        resource url:'/css/fullcalendar.css'
        resource url:'/css/calendar.css'
    }

    qtip {
        dependsOn 'jqui'
        resource url: '/js/jquery.qtip.min.js'
        resource url: '/css/jquery.qtip.min.css'
    }

    grid {
        dependsOn 'jqui'
        resource url: '/js/grid.locale-en.js'
        resource url: '/js/jquery.jqGrid.min.js'
        resource url: '/css/ui.jqgrid.css'
    }

    jqplot {
	resource url: '/js/jquery.jqplot.min.js'
	resource url: '/js/jqplot.pieRenderer.js'
	resource url: '/js/jqplot.barRenderer.js'
	resource url: '/js/jqplot.categoryAxisRenderer.js'
	resource url: '/js/jqplot.canvasTextRenderer.js'
	resource url: '/js/jqplot.canvasAxisTickRenderer.js'
	resource url: '/js/jqplot.cursor.min.js'
	resource url: '/js/plugins/jqplot.meterGaugeRenderer.min.js'
        resource url: '/css/jquery.jqplot.css'
        resource url: '/css/examples.min.css'
	resource url: '/js/example.min.js'
    }
    
    newjqplot {
	resource url: '/js/jquery.jqplot.min.js'
	resource url: '/js/jqplot.plugins/jqplot.barRenderer.min.js'
	resource url: '/js/jqplot.plugins/jqplot.categoryAxisRenderer.min.js'
	resource url: '/js/jqplot.plugins/jqplot.pieRenderer.min.js'
	resource url: '/js/jqplot.plugins/jqplot.pointLabels.min.js'
	resource url: '/js/jqplot.plugins/jqplot.dateAxisRenderer.min.js'
	resource url: '/js/jqplot.plugins/jqplot.json2.min.js'
  resource url: '/css/jquery.jqplot.min.css'
  resource url: '/js/jqplot.canvasTextRenderer.min.js'
  resource url: '/js/jqplot.canvasAxisTickRenderer.min.js'
    }

    panel {
        resource url: '/js/jquery.jgrowl_minimized.js'
        resource url: '/js/jquery.jqEasyPanel.min.js'
        resource url: '/js/jquery.slidePanel.min.js'
    }

    wizard {
        resource url:'/css/smart_wizard_vertical.css'
        //resource url:'/js/jquery.smartWizard-2.0.min.js' jquery.smartWizard
        resource url:'/js/jquery.smartWizard.js' 
    }

    printarea {
        resource url:'/css/PrintArea.css'
        resource url:'/js/jquery.PrintArea.js' 
    }

    ajaxform {
        resource url:'/js/jquery.form.min.js' 
    }

    dataTable {
        resource url:'/css/datatable/jquery.dataTables.min.css'
        resource url:'/js/datatable/jquery.dataTables.min.js' 
        resource url:'/css/datatable/dataTables.tableTools.min.css'
        resource url:'/js/datatable/dataTables.tableTools.min.js' 
    }

    jqval {
        resource url:'/js/jquery.validate.min.js' 
        resource url:'/js/additional-methods.min.js' 
    }

    timeTo {
        resource url:'/css/timeTo.css'
        resource url:'/js/jquery.timeTo.min.js' 
    }


}


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
//grails.views.default.codec = "html" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
        grails.plugins.springsecurity.active = true
        jasper.dir.reports = '/reports'
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
        jasper.dir.reports = '/reports'
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}
    
    //debug  'org.hibernate.SQL'
    
    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
           
    environments {
    	development {
    		debug 'grails.app.domain', 'grails.app.controllers','grails.app.services'
    	}
    	production {
    		debug 'grails.app.domain', 'grails.app.controllers','grails.app.services'
    	}
    }
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.krishna.IcsUser'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.krishna.IcsUserIcsRole'
grails.plugins.springsecurity.authority.className = 'com.krishna.IcsRole'

grails.plugins.springsecurity.useSecurityEventListener = true
grails.plugins.springsecurity.onInteractiveAuthenticationSuccessEvent = { e, appCtx ->
// handle InteractiveAuthenticationSuccessEvent
def ssservice = appCtx.springSecurityService
def hkservice = appCtx.housekeepingService
hkservice.setSessionParams()


}

grails.plugins.springsecurity.onAbstractAuthenticationFailureEvent = { e, appCtx ->
// handle AbstractAuthenticationFailureEvent
}
grails.plugins.springsecurity.onAuthenticationSuccessEvent = { e, appCtx ->
// handle AuthenticationSuccessEvent
}
grails.plugins.springsecurity.onAuthenticationSwitchUserEvent = { e, appCtx ->
// handle AuthenticationSwitchUserEvent
hkservice.setSessionParams()
}
grails.plugins.springsecurity.onAuthorizationEvent = { e, appCtx ->
// handle AuthorizationEvent
}

grails.plugins.springsecurity.rejectIfNoRule = true
grails.plugins.springsecurity.securityConfigType = SecurityConfigType.Requestmap
grails.plugins.springsecurity.requestMap.className = 'ics.Requestmap' 

//grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/'

/*grails.plugins.springsecurity.failureHandler.exceptionMappings = [
'org.springframework.security.authentication.LockedException':'/user/accountLocked',
'org.springframework.security.authentication.DisabledException':'/user/accountDisabled',
'org.springframework.security.authentication.AccountExpiredException':'/user/accountExpired',
'org.springframework.security.authentication.CredentialsExpiredException':'/login/passwordExpired'
]*/

grails.plugins.springsecurity.failureHandler.exceptionMappings = [
'org.springframework.security.authentication.CredentialsExpiredException':'/helper/forceChangePassword'
]

grails.plugins.springsecurity.errors.login.locked = "None shall pass."

    environments {
        production {
		grails.plugins.springsecurity.secureChannel.definition = [
			'/': 'REQUIRES_INSECURE_CHANNEL',
			'/**': 'REQUIRES_SECURE_CHANNEL'
			]
        }
    }

bruteforcedefender {
    time = 5
    allowedNumberOfAttempts = 3
}    

environments {
    development {
    	comms.sms = false
    	comms.email = false
    }
    production {
    	comms.sms = true
    	comms.email = true
    }
}


photos.location = "web-app/thumbs/"
// Added by the JQuery Validation UI plugin:
jqueryValidationUi {
	errorClass = 'error'
	validClass = 'valid'
	onsubmit = true
	renderErrorsOnTop = false
	
	qTip {
		packed = true
	  classes = 'ui-tooltip-red ui-tooltip-shadow ui-tooltip-rounded'  
	}
	
	/*
	  Grails constraints to JQuery Validation rules mapping for client side validation.
	  Constraint not found in the ConstraintsMap will trigger remote AJAX validation.
	*/
	StringConstraintsMap = [
		blank:'required', // inverse: blank=false, required=true
		creditCard:'creditcard',
		email:'email',
		inList:'inList',
		minSize:'minlength',
		maxSize:'maxlength',
		size:'rangelength',
		matches:'matches',
		notEqual:'notEqual',
		url:'url',
		nullable:'required',
		unique:'unique',
		validator:'validator'
	]
	
	// Long, Integer, Short, Float, Double, BigInteger, BigDecimal
	NumberConstraintsMap = [
		min:'min',
		max:'max',
		range:'range',
		notEqual:'notEqual',
		nullable:'required',
		inList:'inList',
		unique:'unique',
		validator:'validator'
	]
	
	CollectionConstraintsMap = [
		minSize:'minlength',
		maxSize:'maxlength',
		size:'rangelength',
		nullable:'required',
		validator:'validator'
	]
	
	DateConstraintsMap = [
		min:'minDate',
		max:'maxDate',
		range:'rangeDate',
		notEqual:'notEqual',
		nullable:'required',
		inList:'inList',
		unique:'unique',
		validator:'validator'
	]
	
	ObjectConstraintsMap = [
		nullable:'required',
		validator:'validator'
	]
	
	CustomConstraintsMap = [
		phone:'true', // International phone number validation
		phoneUS:'true',
		alphanumeric:'true',
		letterswithbasicpunc:'true',
		lettersonly:'true'
	]	
}


// Added by the Grails Mandrill plugin:
mandrill {
	apiKey = "pHfIVPG0VPOaGNA2Tqp8sA"
	// insert proxy values if needed
	//proxy {
	//    host = ""
	// The port Value has to be an integer ;)
	//    port = ""
	//}
}

