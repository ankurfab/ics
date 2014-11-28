package ics

class Farmer {

    static constraints = {
	firstName()
	middleName()
	lastName()
	address(nullable:true,blank:true)
	village()
	taluka()
	district()
	post(nullable:true)
	postVillage(nullable:true)
	pincode(nullable:true,blank:true)
	dob()
	education(nullable:true,blank:true)
	occupation(nullable:true,blank:true)
	caste(nullable:true,blank:true)
	mobileNo()
	adharcardNo(nullable:true,blank:true)
	panCardNo(nullable:true,blank:true)
	shareHolder()
	shareAmount(nullable:true)
	shareCertificateNo(nullable:true,blank:true)
	areaOfIrrigatedLand()
	areaOfNonIrrigatedLand()
	areaOfTotalLand()
	dairy()
	numDesiCows(nullable:true)
	numHybridCows(nullable:true)
	anyOtherBusiness()
	otherBusinessDetails(nullable:true,blank:true)
	irrigationFacility()
	irrigationType  inList: ["None","Well", "Bore-Well", "Canal", "Lift"]
	microIrrigationType  inList: ["None","Drip", "Sprinkler","Both"]
	areaUnderDrip(nullable:true)
	areaUnderSprinkler(nullable:true)
	areaOfOrganicLand(nullable:true)
	areaOfInorganicLand(nullable:true)
	farmingProcess  inList: ["None","Organic", "Non-Organic","Both"]
	panCardSubmitted()
	electionCardSubmitted()
	lightBillSubmitted()
	dakhlaSubmitted()
	rationCardSubmitted()
	comments(nullable:true,blank:true)
	category(nullable:true,blank:true)
	receiptBookNo(nullable:true,blank:true)
	receiptNo(nullable:true,blank:true)
	folioNo(nullable:true,blank:true)
	    avatar(nullable:true, maxSize: 102400 /* 100K */)
	    avatarType(nullable:true)
    }
    
	String	firstName
	String	middleName
	String	lastName
	String	address
	Village	village
	Taluka	taluka
	District	district
	String	post	//post office is in which village
	Village	postVillage	//post office is in which village
	String	pincode
	Date	dob
	String	education
	String	occupation
	String	caste
	String	mobileNo
	String	adharcardNo
	String	panCardNo
	Boolean	shareHolder
	BigDecimal	shareAmount
	String	shareCertificateNo
	BigDecimal	areaOfIrrigatedLand
	BigDecimal	areaOfNonIrrigatedLand
	BigDecimal	areaOfTotalLand
	BigDecimal	areaOfOrganicLand
	BigDecimal	areaOfInorganicLand
	Boolean	dairy
	Integer	numDesiCows
	Integer	numHybridCows
	Boolean	anyOtherBusiness
	String	otherBusinessDetails
	Boolean	irrigationFacility
	String	irrigationType
	String	microIrrigationType
	BigDecimal	areaUnderDrip
	BigDecimal	areaUnderSprinkler
	String	farmingProcess
	Boolean	panCardSubmitted
	Boolean	electionCardSubmitted
	Boolean	lightBillSubmitted
	Boolean	dakhlaSubmitted
	Boolean	rationCardSubmitted
	Boolean	sevenTwelveFormSubmitted
	String comments
	String category	//general, village coordinator, mouthpiece, vip
	String receiptBookNo
	String receiptNo
	String folioNo

	    byte[] avatar
	    String avatarType


    static hasMany = [crops:FarmerCrop, shareCertificates: ShareCertificate]

    String toString() {
        return (firstName?:'') +" "+ (middleName?:'') +" "+ (lastName?:'')
	  }
    
}
