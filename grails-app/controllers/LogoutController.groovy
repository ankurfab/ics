import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class LogoutController {

	def springSecurityService
	
	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
		// TODO  put any pre-logout code here
		//record logout
		try{
		def accessLogs = ics.AccessLog.findAllByLoginid(springSecurityService.principal.username,[max:1,sort:'id',order:'desc'])
		if(accessLogs && accessLogs[0]) {
			accessLogs[0].logoutTime = new Date()
			if(!accessLogs[0].save())
				accessLogs[0].errors.allErrors.each {
								println it
						}
		}
		}
		catch(Exception e){
			log.debug("Some error occurred while updating acess log .. "+e)
		}
		
		
		session.invalidate()
		if(params.logoutUri)
			redirect uri:params.logoutUri
		else
			redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
	}
}
