package ics

class MbProfile {

    static constraints = {
        candidate()
        initiatedBy()
        familyAddress(nullable: true)
        companyAddress(nullable: true)
        prefCentre(nullable: true)
        profileStatus(nullable: true)
        matchMakingStatus(nullable: true)
        workflowStatus(nullable: true)
        category(nullable: true)
        severity(nullable: true)
        priority(nullable: true)
        photo(nullable: true, maxSize: 512000 /* 500K */)
        photoType(nullable: true)
        originPreference(nullable: true)
        castePreference(nullable: true)
        qualPreference(nullable: true)
        devPreference(nullable: true)
        otherPreference(nullable: true)
        manglik(nullable: true)
        extraMaritalAffair(nullable: true)
        nativePlace(nullable: true)
        nativeState(nullable: true)
        depLifelong(nullable: true)
        devotionalCulture(nullable: true)
        flexibleLangknown(nullable: true)
        horoscopeToBeMatched(nullable: true)
        keenDevProfile(nullable: true)
        parentsChanting(nullable: true)
        parentsInfo(nullable: true)
        parentsInitiation(nullable: true)
        parentsSearch(nullable: true)
        parentsSpMaster(nullable: true)
        personalInfo(nullable: true)
        physicalMental(nullable: true)
        prefAgeDiff(nullable: true)
        prefCandIncome(nullable: true)
        prefCaste(nullable: true)
        prefCategory(nullable: true)
        prefChanting(nullable: true)
        prefHeight(nullable: true)
        prefLangKnown(nullable: true)
        prefLooks(nullable: true)
        prefManglik(nullable: true)
        prefNationality(nullable: true)
        prefOrigin(nullable: true)
        prefSpMaster(nullable: true)
        prefVarna(nullable: true)
        prefeducationCategory(nullable: true)
        prefqualification(nullable: true)
        prefsubCaste(nullable: true)
        primdepMB(nullable: true)
        profileoutsideISKCON(nullable: true)
        regotherMB(nullable: true)
        yourFamily(nullable: true)
        candCounsellor(nullable: true)
        candCounsellorAshram(nullable: true)
        referrer(nullable: true)
        referrerCenter(nullable: true)
        referrerContact(nullable: true)
        referrerEmail(nullable: true)
        referrerRelation(nullable: true)
        houseIs(nullable: true)
        houseArea(nullable: true)
        otherProperty(nullable: true)
        otherIncome(nullable: true)
        fatherIncome(nullable: true)
        eduCat(nullable: true)
        eduQual(nullable: true)
        occupationStatus(nullable: true)
        companyName(nullable: true)
        designation(nullable: true)
        frequencyOfTempleVisits(nullable: true)
        likesInKc(nullable: true)
        dislikesInKc(nullable: true)
        introductionYear(nullable: true)
        regulatedSince(nullable: true)
        regDetails(nullable: true)
        chantingSince(nullable: true)
        chantingSixteenSince(nullable: true)
        numberOfRounds(nullable: true)
        spiritualMaster(nullable: true)
        firstInitiation(nullable: true)
        secondInitiation(nullable: true)
        services(nullable: true)
        interests(nullable: true)
        remarks(nullable: true)
        introductionCentre(nullable: true)
        currentlyVisiting(nullable: true)
        regularSince(nullable: true)
        financialDiff(nullable: true)
        otherExpectations(nullable: true)
        fatherName(nullable: true)
        fatherEducation(nullable: true)
        fatherOccupation(nullable: true)
        motherName(nullable: true)
        motherEducation(nullable: true)
        motherOccupation(nullable: true)
        brother1Name(nullable: true)
        brother1Education(nullable: true)
        brother1Occupation(nullable: true)
        brother2Name(nullable: true)
        brother2Education(nullable: true)
        brother2Occupation(nullable: true)
        brother3Name(nullable: true)
        brother3Education(nullable: true)
        brother3Occupation(nullable: true)
        sister1Name(nullable: true)
        sister1Education(nullable: true)
        sister1Occupation(nullable: true)
        sister2Name(nullable: true)
        sister2Education(nullable: true)
        sister2Occupation(nullable: true)
        sister3Name(nullable: true)
        sister3Education(nullable: true)
        sister3Occupation(nullable: true)
    }

    static mapping = {
        prefCentre ignoreNotFound: true
        companyAddress ignoreNotFound: true
    }

    Individual candidate
    Individual initiatedBy  //removed assigned to as was not getting populated.

    String profileStatus
    String matchMakingStatus
    String workflowStatus

    String category    //for future use...severity,priority should be properly used
    String severity    //external commitment for eg having a counsellor..Level 1,2..n
    String priority    //internal surrender Level1,2,3...

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
    String fatherName
    String fatherEducation
    String fatherOccupation
    String motherName
    String motherEducation
    String motherOccupation
    String brother1Name
    String brother1Education
    String brother1Occupation
    String brother2Name
    String brother2Education
    String brother2Occupation
    String brother3Name
    String brother3Education
    String brother3Occupation
    String sister1Name
    String sister1Education
    String sister1Occupation
    String sister2Name
    String sister2Education
    String sister2Occupation
    String sister3Name
    String sister3Education
    String sister3Occupation

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
    Boolean regulated    //following 4 regulative principles
    Boolean teacoffee    //yes means consuming
    Boolean intoxication    //yes means consuming
    Boolean oniongarlic    //yes means consuming
    Boolean nonveg    //yes means consuming
    Boolean gambling    //yes means consuming
    String regDetails    //more info about not following regulative principles
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

    static hasMany = [matches: MbProfileMatch]
    static mappedBy = [matches: "candidate"]


}