<%@ page import="ics.*" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
</head>
<body>
<div>
    <h1 class="pageHead">Marriage Biodata of :  ${profile.candidate.legalName}</h1>
    <g:set var="candAddr" value="${ics.Address.findByIndividualAndCategory(profile.candidate,'PresentAddress')}"/>
</div>
<div>
    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 10px 0 0 10px"> Personal Information: </h3>
    <div class="inforow">
        <p>Legal Name : </p>
        <p>${profile?.candidate?.legalName}</p>
    </div>
    <div class="inforow">
        <p>Initiated Name : </p>
        <p>${profile?.candidate?.initiatedName ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Gender : </p>
        <p>${profile?.candidate?.isMale? 'MALE' : 'FEMALE'}</p>
    </div>
    <div class="inforow">
        <p>Date of Birth : </p>
        <p>${profile?.candidate?.dob?.format('dd / MM / yyyy')}</p>
    </div>
    <div class="inforow">
        <p>Place of Birth : </p>
        <p>${profile?.candidate?.pob ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Time of Birth : </p>
        <p>${profile?.candidate?.dob?.format('HH : mm : ss')}</p>
    </div>
    <div class="inforow">
        <p>ISKCON Centre : </p>
        <p>${profile?.candidate?.iskconCentre ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Counselor : </p>
        <p>${profile?.candCounsellor ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Counselor is a : </p>
        <p>${profile?.candCounsellorAshram ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Nationality : </p>
        <p>${profile?.candidate?.nationality ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Currently settled in : </p>
        <p>${profile?.currentCountry ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>State Of Birth : </p>
        <p>${profile?.candidate?.origin ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Primary Cultural Background : </p>
        <p>${profile?.culturalInfluence ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Category : </p>
        <p>${profile?.scstCategory ?: 'Open'}</p>
    </div>
    <div class="inforow">
        <p>Caste : </p>
        <p>${profile?.candidate?.caste ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Sub-Caste : </p>
        <p>${profile?.candidate?.subCaste ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Varna : </p>
        <p>${profile?.candidate?.varna ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Height : </p>
        <p>${(int)Math.floor((profile?.candidate?.height?: 2)/12)}${'"'+ (profile?.candidate?.height?: 0)%12 + "'"}</p>
    </div>
    <div class="inforow">
        <p>Weight : </p>
        <p>${profile?.weight + " Kg" ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Mother Tongue : </p>
        <p>${profile?.candidate?.motherTongue ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Languages Known : </p>
        <p>${org.springframework.util.StringUtils.commaDelimitedListToStringArray(profile?.languagesKnown).toList() ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Income (per annum) : </p>
        <p>${profile?.candidate?.income ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Horospcope to be matched : </p>
        <p>${profile?.horoscopeToBeMatched ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Manglik : </p>
        <p>${profile?.manglik ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Marital Status : </p>
        <p>${profile?.maritalStatus ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Present Address : </p>
        <p>${candAddr?.addressLine1}<br>${candAddr?.city}<br>${candAddr?.state?.name} - ${candAddr?.pincode}
            <br>( This residence is : ${profile?.residenceType} and is ${profile?.areaCurrHouse} sq.ft in area.)
        </p>
    </div>
    %{--<div class="inforow">
        <p>Contact Number : </p>
        <p>${VoiceContact.findByCategoryAndIndividual('CellPhone', profile?.candidate)?.number ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Email Address : </p>
        <p>${EmailContact.findByCategoryAndIndividual('Personal', profile?.candidate)?.emailAddress ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Other Personal Info : </p>
        <p>${profile?.personalInfo ?: '-'}</p>
    </div>--}%

    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 10px 0 0 10px"> Professional Information: </h3>
    <div class="inforow">
        <p>Education Category : </p>
        <p>${profile?.eduCat ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Qualifications : </p>
        <p>${profile?.eduQual ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Occupation Status : </p>
        <p>${profile?.occupationStatus ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Organisation Name : </p>
        <p>${profile?.companyName ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Designation : </p>
        <p>${profile?.designation ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Company Address : </p>
        <p>${profile?.companyAddress?.addressLine1}<br>${profile?.companyAddress?.city}<br>${profile?.companyAddress?.state?.name} - ${profile?.companyAddress?.pincode}</p>
    </div>

    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 10px 0 0 10px"> Family Information: </h3>
    <div class="inforow">
        <p>Native Place : </p>
        <p>${profile?.nativePlace ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Native(State) : </p>
        <p>${profile?.nativeState ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Present Address of family : </p>
        <p>${profile?.familyAddress?.addressLine1}<br>${profile?.familyAddress?.city}<br>${profile?.familyAddress?.state?.name}-${profile?.familyAddress?.pincode}
            <br>( This Residence is : ${profile?.houseIs} )
        </p>
    </div>
    <div class="inforow">
        <p>Area of House(in sq ft) : </p>
        <p>${profile?.houseArea ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Father : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Father'))[0]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    <div class="inforow">
        <p>Mother : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.legalName}">
    <div class="inforow">
        <p>Brother : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.legalName}">
    <div class="inforow">
        <p>Brother : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.legalName}">
    <div class="inforow">
        <p>Brother : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.legalName}">
    <div class="inforow">
        <p>Sister : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.legalName}">
    <div class="inforow">
        <p>Sister : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.legalName}">
    <div class="inforow">
        <p>Sister : </p>
        <p>${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.legalName}
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.initiatedName}">
                ( ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.initiatedName} )
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.education}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.education}
            </g:if>
            <g:if test="${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.profession}">
                , ${Relationship.findAllByIndividual2AndRelation(profile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.profession}
            </g:if>
        </p>
    </div>
    </g:if>
    <div class="inforow">
        <p>Brought up in Devotee Family : </p>
        <p>${profile?.yourFamily ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Parents Favourable : </p>
        <p>${profile?.parentsInfo ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Parents Chanting : </p>
        <p>${profile?.parentsChanting ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Parents Initiation : </p>
        <p>${profile?.parentsInitiation}
        <g:if test="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(profile?.parentsSpMaster).toList()}">
             By : ${org.springframework.util.StringUtils.commaDelimitedListToStringArray(profile?.parentsSpMaster).toList()}
        </g:if>
        </p>
    </div>
    <div class="inforow">
        <p>Father's Income(per annum) : </p>
        <p>${profile?.fatherIncome ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Number of Family members at home : </p>
        <p>${profile?.noFamilyMembers ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Other Family Members Income : </p>
        <p>${profile?.otherIncome ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Details of any other family members : </p>
        <p>${profile?.otherFamilyMember ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Details of any other property with family : </p>
        <p>${profile?.otherProperty ?: '-'}</p>
    </div>

    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 10px 0 0 10px"> Devotional Information: </h3>
    <div class="inforow">
        <p>Introduced in : </p>
        <p>${profile?.introductionCentre ?: ''} in the year ${profile?.introductionYear}</p>
    </div>
    <div class="inforow">
        <p>Center Connected to : </p>
        <p>${profile?.currentlyVisiting ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Visiting temple : </p>
        <p>${profile?.frequencyOfTempleVisits ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Regularly associating with devotees since : </p>
        <p>${profile?.regularSince ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Chanting since(year) : </p>
        <p>${profile?.chantingSince ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Number of rounds chanting currently : </p>
        <p>${profile?.numberOfRounds ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Chanting 16 rounds since(year) : </p>
        <p>${profile?.chantingSixteenSince ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Aspiring from/ Initiated by : </p>
        <p>${profile?.spiritualMaster ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>First Initiation : </p>
        <p>${profile?.firstInitiation?.format('dd / MM / yyyy') ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Second Initiation : </p>
        <p>${profile?.secondInitiation?.format('dd / MM / yyyy') ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Following 4 Regulative principles : </p>
        <p>${profile?.regulated ? 'Yes':'No'}</p>
    </div>
    <g:if test="${profile?.regulated}">
        <div class="inforow">
            <p>Following four Regs since (year) : </p>
            <p>${profile?.regulatedSince ?: '-'}</p>
        </div>
    </g:if>
    <g:else>
        <div class="inforow">
            <p>Takes Tea/Coffee : </p>
            <p>${profile?.teacoffee ? 'Yes':'No'}</p>
        </div>
        <div class="inforow">
            <p>Takes Onion/Garlic : </p>
            <p>${profile?.oniongarlic ? 'Yes':'No'}</p>
        </div>
        <div class="inforow">
            <p>Takes Nov-Veg (Meat/Eggs etc) : </p>
            <p>${profile?.nonveg ? 'Yes':'No'}</p>
        </div>
        <div class="inforow">
            <p>Takes intoxication (Smoking,Drinking etc) : </p>
            <p>${profile?.intoxication ? 'Yes':'No'}</p>
        </div>
        <div class="inforow">
            <p>Does Gambling / participates in lottery) : </p>
            <p>${profile?.gambling ? 'Yes':'No'}</p>
        </div>
        <div class="inforow">
            <p>Details about regualtive principles : </p>
            <p>${profile?.regDetails ?: '-'}</p>
        </div>
    </g:else>
    <div class="inforow">
        <p>Likes in Krishna Consciousness : </p>
        <p>${profile?.likesInKc ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Dislikes in Krishna Consciousness : </p>
        <p>${profile?.dislikesInKc ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Services Rendered : </p>
        <p>${profile?.services ?: '-'}</p>
    </div>

    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 10px 0 0 10px"> Other Miscellaneous Information: </h3>
    <div class="inforow">
        <p>Main Interests : </p>
        <p>${profile?.interests ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Other Information (Personal) : </p>
        <p>${profile?.personalInfo ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Other Information (Devotional) : </p>
        <p>${profile?.remarks ?: '-'}</p>
    </div>
</div>
<div style="clear: both"></div>
<div>
    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 20px 0 20px 10px"> Photos </h3>
    <div style="width: 30%;float: left;margin-left: 15%">
        <img
             src="${createLink(action: 'showImage', params: ['imgType': 'closePrim', entity: 'mbProfile', entityId: profile?.id])}"/>
        <div style="text-align: center"><b>Passport size (Primary)</b></div>
    </div>
    <div style="width: 30%;float: left;margin-left: 15%">
        <img
             src="${createLink(action: 'showImage', params: ['imgType': 'closeSec', entity: 'mbProfile', entityId: profile?.id])}"/>
        <div style="text-align: center"><b>Passport size (Secondary)</b></div>
    </div>
    <div style="width: 30%;float: left;margin-left: 15%">
        <img
             src="${createLink(action: 'showImage', params: ['imgType': 'fullPrim', entity: 'mbProfile', entityId: profile?.id])}"/>
        <div style="text-align: center"><b>Full Profile (Primary)</b></div>
    </div>
    <div style="width: 30%;float: left;margin-left: 15%">
        <img
             src="${createLink(action: 'showImage', params: ['imgType': 'fullSec', entity: 'mbProfile', entityId: profile?.id])}"/>
        <div style="text-align: center"><b>Full Profile (Secondary)</b></div>
    </div>
</div>
</body>
</html>