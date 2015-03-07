package ics

import com.krishna.*

class Individual {
static searchable = { only = ['*Name','businessRemarks','remarks'] }
    static constraints = {

	title(nullable:true)
        legalName(maxSize:127)
        initiatedName(nullable:true,maxSize:127)
        sanyasName(nullable:true,maxSize:127)
	dob(nullable:true)
    iskconCentre(nullable:true)
	raashi(nullable:true)
	gotra(nullable:true)
	nakshatra(nullable:true)
	isMale(nullable:true)
	isWellWisher(nullable:true)
	category(nullable:true)
	status(nullable:true)
	remarks(nullable:true)
	ashram(nullable:true)
	varna(nullable:true)
	profession(nullable:true)
	companyName(nullable:true)
	designation(nullable:true)
	businessRemarks(nullable:true)
	motherTongue(nullable:true)
	literatureLanguagePreference(nullable:true)
	communicationsPreference(nullable:true)
	languagePreference(nullable:true)
	picFileURL(nullable:true)
	isLifeMember(nullable:true)
	isDonor(nullable:true) 
	membershipNo(nullable:true)
	membershipPlace(nullable:true)
	marriageAnniversary(nullable:true)
	panNo(nullable:true)
	firstInitiation(nullable:true)
	firstInitiationPlace(nullable:true)
	secondInitiation(nullable:true)
	secondInitiationPlace(nullable:true)
	sanyasInitiation(nullable:true)
	loginid(nullable:true,unique:true)
	bloodGroup(nullable:true)
	education(nullable:true)
	nvccDonarCode(nullable:true)
	nvccId(nullable:true)
	nvccName(nullable:true)
	nvccIskconRef(nullable:true)
	nvccFamilyId(nullable:true)
	nvccRelation(nullable:true)
	    avatar(nullable:true, maxSize: 102400 /* 100K */)
	    avatarType(nullable:true)
	introductionDate(nullable:true)
	sixteenRoundsDate(nullable:true)
	chantingSinceDate(nullable:true)
	voiceDate(nullable:true)
	numRounds(nullable:true)
	firstInitiationStatus(nullable:true)
	joinAshram(nullable:true)
	religion(nullable:true)
	eduCat(nullable:true)
	eduQual(nullable:true)
	merits(nullable:true)
	skills(nullable:true)
    	clean(nullable:true)
    	externalRef(nullable:true)
    	externalName(nullable:true)
    	icsid(nullable:true)
    	type(nullable:true)
    	introductionMethod(nullable:true)
	    frequencyOfTempleVisits(nullable:true)
	    likesInKc(nullable:true)
	    dislikesInKc(nullable:true)
	    regulatedSince(nullable:true)
	    regDetails(nullable:true)
	    pob(nullable:true)
	    otherLanguages(nullable:true)
	    origin(nullable:true)
	    caste(nullable:true)
		subCaste(nullable:true)
	    egSurnames(nullable:true)
	    income(nullable:true)
	    height(nullable:true)
	    houseDescription(nullable:true)
	    nationality(nullable:true)
	    description(size:0..2500,blank:true,nullable:true)
	    centre(nullable:true)
	
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()

    }
    String nationality

    String legalName
    String initiatedName
    String sanyasName
    Date dob
    String pob	//place of birth
    boolean isMale = true
    String iskconCentre
    String category
    String status
    String ashram
    String varna
    String profession
    String companyName
    String nvccDonarCode
    String nvccId
    String nvccName
    String nvccIskconRef
    String nvccFamilyId
    String nvccRelation
    Title title
    String designation
    String motherTongue
    String raashi
    String gotra
    String nakshatra
    String literatureLanguagePreference
    String communicationsPreference
    String languagePreference
    String picFileURL
    boolean isWellWisher = true
    boolean isLifeMember = false
    boolean isDonor = false 
    String membershipNo
    String membershipPlace
    String businessRemarks
    String remarks
    Date marriageAnniversary
    String panNo
    Date firstInitiation
    String firstInitiationPlace
    Date secondInitiation
    String secondInitiationPlace
    Date sanyasInitiation
    String loginid
    String bloodGroup
    String education
    Date introductionDate
    String introductionMethod
    Date sixteenRoundsDate
    Date chantingSinceDate
    Date voiceDate
    Integer numRounds
    String firstInitiationStatus
    Date joinAshram
    String religion
    String eduCat
    String eduQual
    String merits
    String skills
    byte[] avatar
    String avatarType
    Boolean clean
    String externalRef
    String externalName
    Integer icsid
    String type
    String description
    Centre centre

    //devotional
    String frequencyOfTempleVisits
    String likesInKc
    String dislikesInKc
    boolean regulated	//following 4 regulative principles
    Date regulatedSince
    boolean teacoffee	//yes means consuming
    boolean intoxication	//yes means consuming
    boolean oniongarlic	//yes means consuming
    boolean nonveg	//yes means consuming
    boolean gambling	//yes means consuming
    String regDetails	//more info about not following regulative principles
    
    //personal
    String otherLanguages
    String origin
    String caste
    String subCaste
    String egSurnames
    String income	//pa
    Integer height	//inches
    boolean ownHouse	//false would mean staying rented house
    String houseDescription
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator


    static hasMany = [address:Address, emailContact:EmailContact, voiceContact:VoiceContact, otheContact:OtherContact, events:EventParticipant, individualRoles:IndividualRole, donations:Donation, fundCollections:Donation, fundsReceived:Donation, followupsWith:Followup, followupsBy:Followup, giftIssuedBy:GiftIssued, giftIssuedTo:GiftIssued, relative1:Relationship, relative2:Relationship, objectives:Objective, objectivesAssigned:Objective]

    static mappedBy = [donations:"donatedBy", fundCollections:"collectedBy", fundsReceived:"receivedBy", followupsWith:"followupWith", followupsBy:"followupBy", giftIssuedBy:"issuedBy",giftIssuedTo:"issuedTo", relative1:"individual1",relative2:"individual2",objectives:"assignedTo",objectivesAssigned:"assignedBy" ]

    static belongsTo = Role

	static mapping = {
		donations sort:'donationDate'
		fundCollections sort:'fundReceiptDate'
	}


    
    String toString() {
    		/* Assuming sanyas name = initiated name = legal name*/
    		if (sanyasName)
    		  return sanyasName
    		else if (initiatedName)
    			return initiatedName
    		else
    			return legalName
	  }
}
