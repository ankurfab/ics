package ics

class EventRegistration {
   
     static constraints = {
		name blank:false, nullable:false
		connectedIskconCenter blank:true, nullable:true
		contactNumber blank:true, nullable:true, phone:true
		alternateContactNumber blank:true, nullable:true, phone:true
		event nullable:false
		country nullable:true
		individual nullable:true
		arrivalDate blank:false, nullable:false
		departureDate blank:false, nullable:false
		verificationStatus blank:false, nullable:false
		arrivalTransportMode blank: true, nullable: true
		departureTransportMode blank: true, nullable: true
		regCode blank: true, nullable:true
		verificationComments blank: true, nullable:true
		accommodationAllotmentStatus blank: true, nullable:true
		isAccommodationRequired  blank: false, nullable:false

		guestType blank:true, nullable:true
		otherGuestType blank:true, nullable:true
		email blank:true, nullable:true, email:true
		isGroupLeader blank:true, nullable:true
		numberofPrabhujis blank:true, nullable:true
		numberofMatajis blank:true, nullable:true
		numberofChildren blank:true, nullable:true
		numberofBrahmacharis blank:true, nullable:true
		isVolunteersAvailable blank:true, nullable:true
		numPrjiVolunteer blank:true, nullable:true
		numMatajiVolunteer blank:true, nullable:true
		numBrahmacharisVolunteer blank:true, nullable:true
		isVipDevotee blank:true, nullable:true
		specialInstructions blank:true, nullable:true
		arrivalTravelingDetails blank:true, nullable:true
		arrivalTrainPickUpPoint blank:true, nullable:true
		arrivalTrainNumber blank:true, nullable:true
		arrivalTrainName blank:true, nullable:true
		arrivalBusNumber blank:true, nullable:true
		arrivalBusStation blank:true, nullable:true
		pickUpRequired blank:true, nullable:true
		arrivalFlightPickUpPoint blank:true, nullable:true
		arrivalFlightNumber blank:true, nullable:true
		arrivalFlightCarrier blank:true, nullable:true
		departureTravelingDetails blank:true, nullable:true
		departureTrainDropPoint blank:true, nullable:true
		departureTrainNumber blank:true, nullable:true
		departureTrainName blank:true, nullable:true
		departureBusNumber blank:true, nullable:true
		departureBusStation blank:true, nullable:true
		dropRequired blank:true, nullable:true
		departureFlightDropPoint blank:true, nullable:true
		departureFlightNumber blank:true, nullable:true
		departureFlightCarrier blank:true, nullable:true
			
		isTravelingPrasadRequired blank:true, nullable:true
		noofBreakfasts blank:true, nullable:true
		noofLunches blank:true, nullable:true
		noofDinners blank:true, nullable:true
		
		arrivalPoint blank:true, nullable:true
		arrivalNumber blank:true, nullable:true
		arrivalName blank:true, nullable:true

		departurePoint blank:true, nullable:true
		departureNumber blank:true, nullable:true
		departureName blank:true, nullable:true
		
		status blank:true, nullable:true
		volunteerStatus blank:true, nullable:true
		
		address blank:true, nullable:true
		comments blank:true, nullable:true

		    //addeded for assessment
		    assessment nullable:true
		    dob nullable:true
		    year blank:true, nullable:true
		    language blank:true, nullable:true
		    idproofType blank:true, nullable:true
		    idProofId blank:true, nullable:true
		    paymentReference blank:true, nullable:true
		    addressPincode blank:true, nullable:true
		    centerLocation blank:true, nullable:true

		dateCreated()
		creator()
		lastUpdated()
		updator()
    }
    

    static belongsTo = [event:Event, country:Country, individual:Individual]
    
    String	regCode	
    String	name  
    String	connectedIskconCenter
    String	contactNumber
    String	alternateContactNumber
    String	email
    boolean	isAccommodationRequired
    String	otherGuestType
    String 	address
    String comments
    
    //addeded for assessment
    Boolean isMale = true
    Assessment assessment
    Date dob
    String year
    String language
    String idproofType
    String idProofId
    PaymentReference paymentReference
    String addressPincode
    String centerLocation

    GuestType		guestType
    VerificationStatus	verificationStatus
    AccommodationAllotmentStatus accommodationAllotmentStatus
    String	verificationComments
        
    //For Group Leaders
    boolean	isGroupLeader 
    int		numberofPrabhujis
    int		numberofMatajis
    int		numberofChildren
    int		numberofBrahmacharis
    boolean	isVolunteersAvailable
    int 	numPrjiVolunteer
    int 	numMatajiVolunteer
    int		numBrahmacharisVolunteer
    
    
    //For VIP
    boolean	isVipDevotee
    String	specialInstructions
	
    // Arrival 
    String	arrivalTravelingDetails
    RailwayStations	arrivalTrainPickUpPoint
    String	arrivalTrainNumber
    String	arrivalTrainName
    String	arrivalBusNumber
    String	arrivalBusStation
    boolean	pickUpRequired
    Airports	arrivalFlightPickUpPoint
    String	arrivalFlightNumber
    String	arrivalFlightCarrier
    Date	arrivalDate
    TransportMode	arrivalTransportMode
    String arrivalPoint
    String arrivalNumber
    String arrivalName
    
    //Depature
    String	departureTravelingDetails
    RailwayStations	departureTrainDropPoint
    String	departureTrainNumber
    String	departureTrainName
    String	departureBusNumber
    String	departureBusStation
    boolean	dropRequired
    Airports	departureFlightDropPoint
    String	departureFlightNumber
    String	departureFlightCarrier
    Date	departureDate
    TransportMode	departureTransportMode
    String departurePoint
    String departureNumber
    String departureName
        
    boolean	isTravelingPrasadRequired
    int		noofBreakfasts
    int		noofLunches
    int		noofDinners
    
    String status
    String volunteerStatus

    //Tracking 
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [accommodationAllotment:AccommodationAllotment,giftIssued:GiftIssued]
       
}
