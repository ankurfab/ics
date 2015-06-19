package ics

class MbProfile {

    static constraints = {
	candidate()
	photo(nullable:true, maxSize: 512000 /* 500K */)
	initiatedBy(nullable: true)
	assignedTo(nullable: true)
	profileStatus(nullable: true, maxSize: 20)
	matchMakingStatus(nullable: true, maxSize: 20)
	workflowStatus(nullable: true, maxSize: 20)
	category(nullable: true, maxSize: 20)
	severity(nullable: true, maxSize: 20)
	priority(nullable: true, maxSize: 20)
	photoType(nullable: true, maxSize: 20)
	scstCategory(nullable: true, maxSize: 30)
	nativePlace(nullable: true, maxSize: 40)
	nativeState(nullable: true, maxSize: 40)
	familyAddress(nullable: true)
	candCounsellor(nullable: true, maxSize: 127)
	candCounsellorAshram(nullable: true, maxSize: 15)
	referrer(nullable: true, maxSize: 127)
	referrerCenter(nullable: true, maxSize: 40)
	referrerContact(nullable: true, maxSize: 20)
	referrerEmail(nullable: true, maxSize: 50)
	referrerRelation(nullable: true, maxSize: 30)
	manglik(nullable: true,maxSize: 20)
	horoscopeToBeMatched(nullable: true, maxSize: 10)
	houseIs(nullable: true, maxSize: 10)
	houseArea(nullable: true)
	otherProperty(nullable: true)
	fatherIncome(nullable: true,maxSize: 30)
	otherIncome(nullable: true, maxSize: 30)
	parentsChanting(nullable: true, maxSize: 30)
	parentsInitiation(nullable: true, maxSize: 30)
	parentsSpMaster(nullable: true, maxSize: 127)
	yourFamily(nullable: true, maxSize: 20)
	parentsInfo(nullable: true,maxSize: 15)
	eduCat(nullable: true,maxSize: 30)
	eduQual(nullable: true,maxSize: 30)
	occupationStatus(nullable: true,maxSize: 40)
	companyName(nullable: true,maxSize: 60)
	designation(nullable: true,maxSize: 30)
	companyAddress(nullable: true)
	introductionYear(nullable: true)
	introductionCentre(nullable: true,maxSize: 30)
	currentlyVisiting(nullable: true,maxSize: 30)
	regularSince(nullable: true)
	frequencyOfTempleVisits(nullable: true,maxSize: 30)
	likesInKc(nullable: true)
	dislikesInKc(nullable: true)
	regulated(nullable: true)
	teacoffee(nullable: true)
	intoxication(nullable: true)
	oniongarlic(nullable: true)
	nonveg(nullable: true)
	gambling(nullable: true)
	regDetails(nullable: true)
	regulatedSince(nullable: true)
	chantingSince(nullable: true)
	numberOfRounds(nullable: true)
	chantingSixteenSince(nullable: true)
	spiritualMaster(nullable: true,maxSize: 127)
	firstInitiation(nullable: true)
	secondInitiation(nullable: true)
	services(nullable: true)
	interests(nullable: true)
	remarks(nullable: true)
	prefChanting(nullable: true,maxSize: 100)
	flexibleChanting(nullable: true)
	prefSpMaster(nullable: true,maxSize: 500)
	flexibleSpMaster(nullable: true)
	otherPreference(nullable: true)
	prefCentre(nullable: true,maxSize: 40)
	flexibleCentre(nullable: true)
	prefNationality(nullable: true, maxSize: 40)
	flexibleNationality(nullable: true)
	prefVarna(nullable: true,maxSize: 60)
	flexibleVarna(nullable: true)
	prefCategory(nullable: true,maxSize: 100)
	flexibleCategory(nullable: true)
	prefCaste(nullable: true,maxSize: 100)
	flexibleCaste(nullable: true)
	prefsubCaste(nullable: true,maxSize: 100)
	flexibleSubcaste(nullable: true)
	prefeducationCategory(nullable: true,maxSize: 100)
	flexibleEducationCat(nullable: true)
	prefqualification(nullable: true,maxSize: 100)
	flexibleQualifications(nullable: true)
	prefAgeDiff(nullable: true,maxSize: 40)
	flexibleAgediff(nullable: true)
	prefHeight(nullable: true,maxSize: 40)
	flexibleHeight(nullable: true)
	prefLooks(nullable: true,maxSize: 100)
	flexibleLooks(nullable: true)
	prefCandIncome(nullable: true,maxSize: 40)
	flexibleCandidateIncome(nullable: true)
	prefLangKnown(nullable: true,maxSize: 500)
	flexibleLangknown(nullable: true)
	prefManglik(nullable: true,maxSize: 60)
	flexibleManglik(nullable: true)
    prefCulturalInfluence(nullable: true,maxSize: 500)
    flexibleCulturalInfluence(nullable: true)
	settleAbroadWorkingWife(nullable: true, maxSize: 10)
	keenDevProfile(nullable: true,maxSize: 80)
	primdepMB(nullable: true,maxSize: 60)
	regotherMB(nullable: true,maxSize: 60)
	parentsSearch(nullable: true,maxSize: 60)
	profileoutsideISKCON(nullable: true)
	financialDiff(nullable: true)
	physicalMental(nullable: true)
	depLifelong(nullable: true)
	personalInfo(nullable: true,maxSize: 500)
    otherExpectations(nullable:true,maxSize: 500)
    noFamilyMembers(nullable: true)
    otherFamilyMember(nullable: true)
    languagesKnown(nullable: true,maxSize: 80)
    maritalStatus(nullable:true,maxSize: 20)
    devotionalCulture(nullable: true)
    weight(nullable: true)
    culturalInfluence(nullable: true,maxSize: 40)
    residenceType(nullable: true,maxSize: 20)
    currentCountry(nullable: true,maxSize: 10)
    areaCurrHouse(nullable: true,maxSize: 6)
    flexibleCurrentCountry(nullable: true)
    prefCurrentCountry(nullable: true,maxSize: 10)
    }

    static mapping={
        prefCentre ignoreNotFound:true
        companyAddress ignoreNotFound: true
    }
    
    Individual candidate
    Individual initiatedBy  //removed assigned to as was not getting populated.
    Individual assignedTo

    String profileStatus
    String matchMakingStatus
    String workflowStatus

    String category	//for future use...severity,priority should be properly used
    String severity	//external commitment for eg having a counsellor..Level 1,2..n
    String priority	//internal surrender Level1,2,3...
    
    byte[] photo
    String photoType
    
    String nativePlace
    String nativeState
    Address familyAddress

    //step1 fields
    String candCounsellor
    String candCounsellorAshram
    String referrer
    String referrerCenter
    String referrerContact
    String referrerEmail
    String referrerRelation
    String manglik
    String horoscopeToBeMatched
    String scstCategory
    String languagesKnown
    String maritalStatus
    Short weight
    
    //step2 fields
    String houseIs
    Short houseArea
    String otherProperty
    String fatherIncome
    String otherIncome
    String parentsChanting
    String parentsInitiation
    String parentsSpMaster
    String yourFamily
    String parentsInfo
    Integer noFamilyMembers
    String otherFamilyMember

    //step 3 fields
    String eduCat
    String eduQual
    String occupationStatus
    String companyName
    String designation
    Address companyAddress

    //step 4 fields
    Integer introductionYear
    String introductionCentre
    String currentlyVisiting
    Integer regularSince
    String frequencyOfTempleVisits
    String likesInKc
    String dislikesInKc
    Boolean regulated	//following 4 regulative principles
    Boolean teacoffee	//yes means consuming
    Boolean intoxication	//yes means consuming
    Boolean oniongarlic	//yes means consuming
    Boolean nonveg	//yes means consuming
    Boolean gambling	//yes means consuming
    String regDetails	//more info about not following regulative principles
    Integer regulatedSince
    Integer chantingSince
    Integer numberOfRounds
    Integer chantingSixteenSince
    String spiritualMaster
    Date firstInitiation      //make them date type fields in db not date time
    Date secondInitiation     //make them date type fields in db not date time
    String services
    String interests
    String remarks
    //Expectations from prospects*/

    String devotionalCulture
    String prefChanting
    Boolean flexibleChanting
    String prefSpMaster
    Boolean flexibleSpMaster
    String otherPreference
    String prefCentre
    Boolean flexibleCentre
    String prefNationality
    Boolean flexibleNationality
    String prefVarna
    Boolean flexibleVarna
    String prefCategory
    Boolean flexibleCategory
    String prefCaste
    Boolean flexibleCaste
    String prefsubCaste
    Boolean flexibleSubcaste
    String prefeducationCategory
    Boolean flexibleEducationCat
    String prefqualification
    Boolean flexibleQualifications
    String prefAgeDiff
    Boolean flexibleAgediff
    String prefHeight
    Boolean flexibleHeight
    String prefLooks
    String prefCurrentCountry
    Boolean flexibleCurrentCountry
    Boolean flexibleLooks
    String prefCandIncome
    Boolean flexibleCandidateIncome
    String prefLangKnown
    Boolean flexibleLangknown
    String prefManglik
    Boolean flexibleManglik
    String prefCulturalInfluence
    Boolean flexibleCulturalInfluence
    String settleAbroadWorkingWife
    String keenDevProfile
    String primdepMB
    String regotherMB
    String parentsSearch
    String profileoutsideISKCON
    String financialDiff
    String physicalMental
    String depLifelong
    String personalInfo
    String otherExpectations
    String culturalInfluence
    String residenceType
    String currentCountry
    Integer areaCurrHouse
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [matches:MbProfileMatch]
    static mappedBy = [matches:"candidate"]
    
}
