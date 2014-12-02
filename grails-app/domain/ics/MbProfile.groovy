package ics

class MbProfile {

    static constraints = {
	    candidate()
	    photo(nullable:true, maxSize: 512000 /* 500K */)
	initiatedBy(nullable: true)
	profileStatus(nullable: true)
	matchMakingStatus(nullable: true)
	workflowStatus(nullable: true)
	category(nullable: true)
	severity(nullable: true)
	priority(nullable: true)
	photoType(nullable: true)
	scstCategory(nullable: true)
	nativePlace(nullable: true)
	nativeState(nullable: true)
	extraMaritalAffair(nullable: true)
	familyAddress(nullable: true)
	candCounsellor(nullable: true)
	candCounsellorAshram(nullable: true)
	referrer(nullable: true)
	referrerCenter(nullable: true)
	referrerContact(nullable: true)
	referrerEmail(nullable: true)
	referrerRelation(nullable: true)
	manglik(nullable: true)
	horoscopeToBeMatched(nullable: true)
	houseIs(nullable: true)
	houseArea(nullable: true)
	otherProperty(nullable: true)
	fatherIncome(nullable: true)
	otherIncome(nullable: true)
	parentsChanting(nullable: true)
	parentsInitiation(nullable: true)
	parentsSpMaster(nullable: true)
	yourFamily(nullable: true)
	parentsInfo(nullable: true)
	eduCat(nullable: true)
	eduQual(nullable: true)
	occupationStatus(nullable: true)
	companyName(nullable: true)
	designation(nullable: true)
	companyAddress(nullable: true)
	introductionYear(nullable: true)
	introductionCentre(nullable: true)
	currentlyVisiting(nullable: true)
	regularSince(nullable: true)
	frequencyOfTempleVisits(nullable: true)
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
	spiritualMaster(nullable: true)
	firstInitiation(nullable: true)
	secondInitiation(nullable: true)
	services(nullable: true)
	interests(nullable: true)
	remarks(nullable: true)
	originPreference(nullable: true)
	castePreference(nullable: true)
	qualPreference(nullable: true)
	devPreference(nullable: true)
	devotionalCulture(nullable: true)
	prefChanting(nullable: true)
	flexibleChanting(nullable: true)
	prefSpMaster(nullable: true)
	flexibleSpMaster(nullable: true)
	otherPreference(nullable: true)
	prefCentre(nullable: true)
	flexibleCentre(nullable: true)
	prefNationality(nullable: true)
	flexibleNationality(nullable: true)
	prefOrigin(nullable: true)
	flexibleOrigin(nullable: true)
	prefVarna(nullable: true)
	flexibleVarna(nullable: true)
	prefCategory(nullable: true)
	flexibleCategory(nullable: true)
	prefCaste(nullable: true)
	flexibleCaste(nullable: true)
	prefsubCaste(nullable: true)
	flexibleSubcaste(nullable: true)
	prefeducationCategory(nullable: true)
	flexibleEducationCat(nullable: true)
	prefqualification(nullable: true)
	flexibleQualifications(nullable: true)
	prefAgeDiff(nullable: true)
	flexibleAgediff(nullable: true)
	prefHeight(nullable: true)
	flexibleHeight(nullable: true)
	prefLooks(nullable: true)
	flexibleLooks(nullable: true)
	prefCandIncome(nullable: true)
	flexibleCandidateIncome(nullable: true)
	prefLangKnown(nullable: true)
	flexibleLangknown(nullable: true)
	prefManglik(nullable: true)
	flexibleManglik(nullable: true)
	settleAbroadWorkingWife(nullable: true)
	keenDevProfile(nullable: true)
	primdepMB(nullable: true)
	regotherMB(nullable: true)
	parentsSearch(nullable: true)
	profileoutsideISKCON(nullable: true)
	financialDiff(nullable: true)
	physicalMental(nullable: true)
	depLifelong(nullable: true)
	personalInfo(nullable: true)
    otherExpectations(nullable:true)
    noFamilyMembers(nullable: true)
    otherFamilyMember(nullable: true)
    languagesKnown(nullable: true)
    }

    static mapping={
        prefCentre ignoreNotFound:true
        companyAddress ignoreNotFound: true
    }
    
    Individual candidate
    Individual initiatedBy  //removed assigned to as was not getting populated.

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
    Boolean extraMaritalAffair
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
    
    //step2 fields
    String houseIs
    Integer houseArea
    Boolean otherProperty
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

    String originPreference
    String castePreference
    String qualPreference
    String devPreference
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
    String prefOrigin
    Boolean flexibleOrigin
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
    Boolean flexibleLooks
    String prefCandIncome
    Boolean flexibleCandidateIncome
    String prefLangKnown
    Boolean flexibleLangknown
    String prefManglik
    Boolean flexibleManglik
    Boolean settleAbroadWorkingWife
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


    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static hasMany = [matches:MbProfileMatch]
    static mappedBy = [matches:"candidate"]
    
}
