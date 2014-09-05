package ics

class AccessLog {

    static constraints = {
    	logoutTime(nullable:true)
    	ipaddr(nullable:true)
    }
    String loginid
    String ipaddr

    Date loginTime
    Date logoutTime
    
        String toString() {
            return loginid+" ("+ipaddr+")"+"Login Time: "+(loginTime.toString()?:'') +" Logout time:"+(logoutTime.toString()?:'')
    	  }

}
