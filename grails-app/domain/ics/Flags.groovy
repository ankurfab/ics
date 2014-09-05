package ics

class Flags {

    static constraints = {
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
	    folk(nullable:true)
	    printLabelFlag(nullable:true)
	    schemeid(nullable:true)
	    nomineeName(nullable:true)
	    nameOnWall(nullable:true)
	    address(nullable:true)
	    telephoneNo(nullable:true)
	    mobileNo(nullable:true)
	    email(nullable:true)
	    panno(nullable:true)
	    photo(nullable:true)
	    sevakType(nullable:true)
	    formSign(nullable:true)
	    formstatus(nullable:true)
	    comments(nullable:true)
	    addressComments(nullable:true)
	    mobileComments(nullable:true)
	    emailComments(nullable:true)
	    telComments(nullable:true)
	    amount(nullable:true)
    }
    
    int individualid
    boolean folk
    boolean printLabelFlag
    int schemeid
    String nomineeName
    String nameOnWall
    boolean isFormComplete
    String comments
    boolean wallName
    boolean address
    String addressComments
    boolean telephoneNo
    String telComments
    boolean mobileNo
    String mobileComments
    boolean email
    String emailComments
    boolean panno
    boolean photo
    boolean sevakType
    boolean formSign
    String formstatus
    BigDecimal amount
    

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

	static mapping = {
		individualid index:'individualid_Idx'
		formstatus index:'formstatus_Idx'
	}

}
