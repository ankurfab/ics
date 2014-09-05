package ics

class EventAccommodation {

    static constraints = {
 
    	name blank:false, nullable:false, unique: true
	comments blank:true, nullable:true
	address blank:true, nullable:true
	hostMobileNumber blank:true, nullable:true
        hostAlternateMobileNumber blank:true, nullable:true
	hostEmail nullable:true, email:true

	maxCapacity blank:false, nullable:false
	maxPrabhujis blank:true, nullable:true
	maxMatajis blank:true, nullable:true
	maxChildrens blank:true, nullable:true
	maxBrahmacharis blank:true, nullable:true
	availableCapacity nullable:true
	availablePrabhujis blank:true, nullable:true
	availableMatajis blank:true, nullable:true
	availableChildrens blank:true, nullable:true
	availableBrahmacharis blank:true, nullable:true
	availableFromDate blank:false, nullable:false
	availableTillDate blank:false, nullable:false
	dateofBooking blank:true, nullable:true

	accommodationInChargeName blank:true, nullable:true
	accommodationInChargeContactNumber blank:true, nullable:true
	isAccommodationContactSame blank:true, nullable:true
	accommodationContactNumber blank:true, nullable:true
	accommodationContactPerson blank:true, nullable:true
	event blank:false, nullable:false
	

	distanceFromNVCC blank:false, nullable:false
	negotiatedRate blank:true, nullable:true
	advanceGiven blank:true, nullable:true

	rankNearnesstoNVCC blank:true, nullable:true	
	rankEconomical blank:true, nullable:true
	rankSafety blank:true, nullable:true	 
	rankFacilities blank:true, nullable:true
	rankCleanlinessStandard blank:true, nullable:true
	rankOverall blank:false, nullable:false
	rankAttachedTNB blank:true, nullable:true
	rankElevator blank:true, nullable:true
	rankCooking blank:true, nullable:true
	    
	capacityofAllDormitories blank:true, nullable:true
	numberofToilets	blank:true, nullable:true
	numberofBathrooms blank:true, nullable:true
	numberofRooms blank:true, nullable:true
	isGeneratorBackUpAvailable blank:true, nullable:true
	numberofClothesLine blank:true, nullable:true
	numberofBuckets blank:true, nullable:true
	numberofRoomsWithAttachedTNB blank:true, nullable:true
	numberofRoomsWithoutTNB blank:true, nullable:true
	isCoockAvailableForGuest blank:true, nullable:true
	areThereChildrensBelow12Years blank:true, nullable:true
	isInternetFascilityAvailable blank:true, nullable:true
	isElevatorFascilityAvailable blank:true, nullable:true
	isCarFacilityAvailable blank:true, nullable:true
	isCookAvailableForGuest blank:true, nullable:true

	chart(nullable:true)
	
	status(nullable:true)

	dateCreated()
	lastUpdated()
	creator()
	updator()
    }
    
    
    String name
    String comments
    String address
    String hostMobileNumber
    String hostAlternateMobileNumber
    String hostEmail

    Integer maxCapacity
    Integer maxPrabhujis
    Integer maxMatajis
    Integer maxChildrens
    Integer maxBrahmacharis

    Integer availableCapacity	//vacant
    Integer availablePrabhujis	//alloted
    Integer availableMatajis	//alloted
    Integer availableChildrens	//alloted
    Integer availableBrahmacharis	//alloted
    Date availableFromDate
    Date availableTillDate
    Date dateofBooking

    int totalCheckedin=0
    int totalPrjiCheckedin=0
    int totalMatajiCheckedin=0
    int totalChildrenCheckedin=0
    int totalBrahmachariCheckedin=0
    
    String accommodationInChargeName
    String accommodationInChargeContactNumber
    Boolean isAccommodationContactSame
    String accommodationContactNumber
    String accommodationContactPerson
    Event event
    
    Integer distanceFromNVCC

    Float negotiatedRate
    Float advanceGiven

    Integer rankNearnesstoNVCC	
    Integer rankEconomical
    Integer rankSafety	
    Integer rankFacilities
    Integer rankCleanlinessStandard
    Integer rankOverall
    Integer rankAttachedTNB
    Integer rankElevator
    Integer rankCooking

    
    Integer capacityofAllDormitories
    Integer numberofToilets	
    Integer numberofBathrooms	
    Integer numberofRooms
    Boolean isGeneratorBackUpAvailable
    Integer numberofClothesLine
    Integer numberofBuckets
    Integer numberofRoomsWithAttachedTNB
    Integer numberofRoomsWithoutTNB
    Boolean isCoockAvailableForGuest
    Boolean areThereChildrensBelow12Years
    Boolean isInternetFascilityAvailable
    Boolean isElevatorFascilityAvailable
    Boolean isCarFacilityAvailable
    Boolean isCookAvailableForGuest

    Boolean isVipAccommodation
    
    Chart chart
    Boolean manualMode = false
    
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static belongsTo = [event:Event]

    static hasMany = [accommodationAllotment:AccommodationAllotment]
    
    String toString() {
	    return name
    }

}
