package ics

class IndividualSummary {

    static constraints = {
	indid(nullable:true)
	name(nullable:true)
	phone(nullable:true,size:0..2000)
	email(nullable:true,size:0..2000)
	address(nullable:true,size:0..5000)
	familyid(nullable:true)
	familyof(nullable:true)
	cultid(nullable:true)
	cultivator(nullable:true)
	clorid(nullable:true)
	counsellor(nullable:true)
	guruid(nullable:true)
	guru(nullable:true)
	numphones(nullable:true)
	numemails(nullable:true)
	numaddresses(nullable:true)
	numep(nullable:true)
	numer(nullable:true)
	numes(nullable:true)
	bookstaken(nullable:true)
	booksdist(nullable:true)
	donation(nullable:true)
	collection(nullable:true)
	numepCurrent(nullable:true)
	numerCurrent(nullable:true)
	numesCurrent(nullable:true)
	bookstakenCurrent(nullable:true)
	booksdistCurrent(nullable:true)
	donationCurrent(nullable:true)
	collectionCurrent(nullable:true)
	numepPrevious(nullable:true)
	numerPrevious(nullable:true)
	numesPrevious(nullable:true)
	bookstakenPrevious(nullable:true)
	booksdistPrevious(nullable:true)
	donationPrevious(nullable:true)
	collectionPrevious(nullable:true)
	refreshDate(nullable:true)    
    }
    
    Long indid
    String name
    String phone
    String email
    String address
    Long familyid
    String familyof
    Long cultid
    String cultivator
    Long clorid
    String counsellor
    Long guruid
    String guru
    Integer numphones
    Integer numemails
    Integer numaddresses
    
    //overall
    Integer numep	//number of events participating
    Integer numer	//number of events registered
    Integer numes	//number of eventseva allotted
    BigDecimal bookstaken
    BigDecimal booksdist
    BigDecimal donation
    BigDecimal collection

    //current period
    Integer numepCurrent	//number of events participating
    Integer numerCurrent	//number of events registered
    Integer numesCurrent	//number of eventseva allotted
    BigDecimal bookstakenCurrent
    BigDecimal booksdistCurrent
    BigDecimal donationCurrent
    BigDecimal collectionCurrent

    //previous period
    Integer numepPrevious	//number of events participating
    Integer numerPrevious	//number of events registered
    Integer numesPrevious	//number of eventseva allotted
    BigDecimal bookstakenPrevious
    BigDecimal booksdistPrevious
    BigDecimal donationPrevious
    BigDecimal collectionPrevious
    
    Date refreshDate
    
	static mapping = {
		indid index:'Idx_indid'
		name index:'Idx_name'
		counsellor index:'Idx_counsellor'
		cultivator index:'Idx_cultivator'
		guru index:'Idx_guru'
		clorid index:'Idx_clorid'
		clorid index:'Idx_cultid'
		clorid index:'Idx_guruid'
	}
    
}
