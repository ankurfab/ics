
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="reminders.list" default="Action List" /></title>
	<r:require module="grid" />
    <r:require module="export"/>    
        <export:resource />
        <style>
        td{vertical-align:top;}
        </style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            
            <span class="menuButton"><g:link class="list" controller="schemeMember" action="list"><g:message code="schememMembers.list" default="Scheme Members List" /></g:link></span>                
        </div>
        <div class="body">
            <h1><g:message code="reminders.list" default="Executive Action List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
		  <div>
        
    <table>
    <tbody bgcolor="lavender">
    <tr>
      <td>
        <g:link class="list" controller="giftRecord" action="updateGiftRecordCentres"><g:message code="giftRecord.list" default="Update Gift Record Centres" /></g:link>
      </td>
    </tr>
    <tr></tr>
     <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="updateToBeCommunicatedOfMembers"><g:message code="schemeMember.update" default="Update SchemeMembers with No For To Be Communicated" /></g:link>
      </td>
    </tr>
    <tr></tr>
    <tr>
      <td>
      </td>
    </tr>
    <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="checkECSMandateFromCommitment"><g:message code="schemeMember.update" default="Check Consumer Number of SchemeMembers With ECS Mandate From Commitment" /></g:link>
      </td>
    </tr>
    <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="syncdonation">Sync Donation Records from Donations (For Cash /NEFT / Cheque etc.)</g:link>
      </td>
    </tr>

    <tr>
      <td>
        <g:link class="list" controller="donationRecord" action="updateDonationRecordWithEmptyCenterBySchemeMemberCenter">Update Donation Record Centers (which are not set) From Primary center of Scheme Member</g:link>
      </td>
    </tr>

    <tr>
      <td>
       Update Donation Record Centers (whose center is not set and don't belong to any scheme member) From a Center , (choose default center)

         <g:form action="updateDonationRecordWithDefaultCenter">
            <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id"  />
            <span class="button"><input type="submit" class="save" value="Update"  /></span>
         </g:form>
      </td>
    </tr>

    <tr>
      <td>
        <g:link class="list" controller="donationRecord" action="findDonationRecordsHavingNoSchemeMember">Find Those Individuals who have donation record but does not have scheme membership</g:link>
      </td>
    </tr>

    <tr>
      <td>
        <g:link class="list" controller="donationRecord" action="updateSchemeMembersCommitmentMode">Update Scheme members Commitment mode based on their last payment type</g:link>
      </td>
    </tr>

    <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="updateSchemeMembersStatus">Update Scheme members Status based on below condition</g:link> <br/>
        Active ,-all members having commitment and ecs mandate not null and active commitment are marked active for that scheme<br/>
        Iregular --all such members ,which commitment mode is not ECS , and number of donation given in previous one year is less then 10 are marked irregular.<br/>
        In-active --those not marked as prospect and suspended and not given any donation or the last donation given by them is more than 1 year old then mark them in-active<br/> 
        or if there donation frequency is yearly or half yearly then mark them irregular , but not given more than 2 years then mark them also in-active<br/>
      </td>
    </tr>

     <tr>
      <td>
        <g:link class="list" controller="schemeMember" action="updateSchemeMembersStars">Update Scheme members Stars based on per month amount given in last one year</g:link>
      </td>
    </tr>


    </tbody>
    </table>
    
		</div>
        </div>
        


        
    </body>
</html>
