import com.krishna.*
import ics.*

class BootStrap {

    def init = { servletContext ->
    	TimeZone.setDefault(TimeZone.getTimeZone("GMT+5:30"))//for India
    	def inst
    	def rootRole
    	if(IcsRole.count()==0)
    		{
		rootRole = new IcsRole(authority:'ROLE_ADMIN')
		rootRole.save()

		inst = new IcsRole(authority:'ROLE_USER')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DUMMY')
		inst.save()

		inst = new IcsRole(authority:'ROLE_NVCC_ADMIN')
		inst.save()

		inst = new IcsRole(authority:'ROLE_LOAN_USER')
		inst.save()

		inst = new IcsRole(authority:'ROLE_BACKOFFICE')
		inst.save()

		inst = new IcsRole(authority:'ROLE_PATRONCARE')
		inst.save()

		inst = new IcsRole(authority:'ROLE_COUNSELLOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VOICE_ADMIN')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DATA_CLEAN')
		inst.save()

		inst = new IcsRole(authority:'ROLE_PATRONCARE_USER')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VIP_REGISTRATION')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VIP_ACCOMMODATION')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VIP_TRANSPORTATION')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VIP_PRASADAM')
		inst.save()

		inst = new IcsRole(authority:'ROLE_EVENTADMIN')
		inst.save()

		inst = new IcsRole(authority:'ROLE_ACCOMMODATION_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_COUNSELLOR_GROUP')
		inst.save()

		inst = new IcsRole(authority:'ROLE_EVENTPARTICIPANT')
		inst.save()

		inst = new IcsRole(authority:'ROLE_KITCHEN_ADMIN')
		inst.save()

		inst = new IcsRole(authority:'ROLE_PRASADAM_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_REGISTRATION_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_TMC')
		inst.save()

		inst = new IcsRole(authority:'ROLE_TRANSPORTATION_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VIP_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_VOLUNTEER_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_RVTO_COUNSELOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DONATION_HOD')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DONATION_EXECUTIVE')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DONATION_COORDINATOR')
		inst.save()

		inst = new IcsRole(authority:'ROLE_DONATION_GIFT_INCHARGE')
		inst.save()
    		}
    	if(IcsUser.count()==0)
    		{
		//create root user
    		def rootUser = new IcsUser(username:'icsadmin',password:'harekrishna',enabled:true,accountExpired:false,accountLocked:false,passwordExpired:false)
		rootUser.save()    		

    		if(!rootRole)
			rootRole = IcsRole.findByAuthority('ROLE_ADMIN')
		//assign the role
		inst = new IcsUserIcsRole(icsUser:rootUser,icsRole:rootRole)
		inst.save()
    		
    		}
    		
    }
    def destroy = {
    }
}
