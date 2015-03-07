package ics

class SchemeMember {

    static constraints = {

    scheme()
    member(unique:['scheme'])
    centre(nullable:true)
    secondcentre(nullable:true)
    externalName(nullable:true)
    counsumerNumber(nullable:true)
	status()
    comments(size:1..4000)
    recentCommunication(size:1..4000)
    startComments(size:1..4000)
    stopComments(size:1..4000)
    giftchannelDescription(size:1..4000)
	startDate()
	stopDate(nullable:true)
    profileCompleteDate(nullable:true)
    recentResumeDate(nullable:true)
    futureStartDate(nullable:true)
    committedFrequency(nullable:true)
    committedAmount(nullable:true)
    actualCurrentAmount(nullable:true)
    percentageDeductionUpper(nullable:true)
    percentageDeductionLower(nullable:true)
    percentageDeductionSecondCentreUpper(nullable:true)
    percentageDeductionSecondCentreLower(nullable:true)
    membershipLevel(nullable:true)
    committedMode(nullable:true)
    committedModeDetails(nullable:true)
    bankName(nullable:true)
    addressTheConcern(nullable:true)
    accountNumber(nullable:true)    
	giftchannel(nullable:true)
    giftPrefferedAddress(nullable:true)
    giftPrefferedLanguage(nullable:true)
    prefferedEmailType(nullable:true)
    prefferedContactType(nullable:true)
    currentCity(nullable:true)
    batchyear(nullable:true) // can be used to store the batch of passing of a member from college.
    toBeCommunicated(nullable:true)
    toBeSMS(nullable:true)
	star(nullable:true)
    dateCreated()
    creator()
    lastUpdated()
    updator()

    }
    
    Individual member
    String externalName
    String counsumerNumber
    Scheme scheme
    Centre centre
    Centre secondcentre // some member might be giving to two centres ,so for handling that
    Integer percentageDeductionSecondCentreUpper=0 // this fields used for deducting the  amount  for this scheme for second centre
    Integer percentageDeductionSecondCentreLower=1 // if both values are 50 / 100 ,it means  amount * (50/100) will be deducted from final  amount for second centre

    String status	//ACTIVE,INACTIVE,RESUMED,SUSPENDED,PROSPECT, NOTINTERESTED, IRREGULAR
    String recentCommunication=""
    String addressTheConcern
    String comments=""
    Date startDate
    Date stopDate
    Date recentResumeDate
    Date futureStartDate
    String startComments=""
    String stopComments=""
    String committedFrequency	//MONTHLY,QUARTERLY,HALFYEARLY,YEARLY
    Integer committedAmount
    Integer actualCurrentAmount
    Integer percentageDeductionUpper=0 // this fields used for deducting the  amount not for this scheme ,by default percentage is 0/1 means 0% percent
    Integer percentageDeductionLower=1 // if both values are 50 / 100 ,it means  amount * (50/100) will be deducted from full  amount

    String membershipLevel
    String committedMode
    String committedModeDetails
	String bankName  // will be used if applicable 
	String accountNumber
    String giftchannelDescription=""
    String giftchannel
    String giftPrefferedAddress
    Language giftPrefferedLanguage
    String prefferedEmailType
    String prefferedContactType
    Boolean ismobilenumberWorking = false
    Boolean isemailIWorking = false
    Boolean isProfileComplete = false
    Date profileCompleteDate
    Boolean isModileHaveDND = false
    City currentCity

    String batchyear
    String toBeCommunicated="No"
    String toBeSMS="No"

    Integer star = 0 //in one year ,per month how much donation given, if 1K per month then 1 star ,if 5k per month then 5 star given to member

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [member:Individual, scheme:Scheme]

    String toString() {
    	scheme.toString()+" : "+member.toString()
    	  }
     
}
