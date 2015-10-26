<%@ page import="ics.*" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
</head>
<body>
<div>
    <h1 class="pageHead">Marriage Biodata(Limited Profile) of :  ${profile.candidate.legalName}</h1>
    <g:set var="candAddr" value="${ics.Address.findByIndividualAndCategory(profile.candidate,'PresentAddress')}"/>
</div>
<div>
    <div class="inforow">
        <p>Legal Name : </p>
        <p>${profile?.candidate?.legalName}</p>
    </div>
    <div class="inforow">
        <p>Initiated Name : </p>
        <p>${profile?.candidate?.initiatedName ?: '-'}</p>
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
        <p>Mother Tongue : </p>
        <p>${profile?.candidate?.motherTongue ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Income (per annum) : </p>
        <p>${profile?.candidate?.income ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Manglik : </p>
        <p>${profile?.manglik ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Education Category : </p>
        <p>${profile?.eduCat ?: '-'}</p>
    </div>
    <div class="inforow">
        <p>Qualifications : </p>
        <p>${profile?.eduQual ?: '-'}</p>
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
        <p>Following 4 Regulative principles : </p>
        <p>${profile?.regulated ? 'Yes':'No'}</p>
    </div>

</div>
<div style="clear: both"></div>
<div>
    <h3 style="font-family: sans-serif;text-decoration: underline;margin: 20px 0 20px 10px"> Photo </h3>
    <div style="width: 15%;float: left;margin-left: 15%">
        <img id="fvimage" name="fvimage" class="avatar" style="width: 100%;height: auto"
             src="${createLink(action: 'showImage', params: ['imgType': 'closePrim', entity: 'mbProfile', entityId: profile?.id])}"/>
        <div style="text-align: center"><b>Passport size Photo</b></div>
    </div>
</div>
</body>
</html>