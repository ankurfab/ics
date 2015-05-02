
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.edit" default="Edit SchemeMember" /></title>
    </head>
    <body>
    <r:require module="jqui" />
        <script type="text/javascript">
         $(document).ready(function()
            {
                $("#startDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                $("#stopDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                 $("#recentResumeDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                 $("#futureStartDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
            })
        </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="schemeMember.list" default="SchemeMember List" /></g:link></span>
            
        </div>
        <div class="body">
            <h1><g:message code="schemeMember.edit" default="Edit SchemeMember" /></h1>           

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${schemeMemberInstance}">
            <div class="errors">
                <g:renderErrors bean="${schemeMemberInstance}" as="list" />
            </div>
            </g:hasErrors>
             <div id="extradetails" style="padding:10px 10px;margin:10px 50px;border:1px solid;">
            Individual Details
            <hr>
            VOICE CONTACTS: ${schemeMemberInstance?.member?.voiceContact} <br><br>
            EMAIL CONTACTS: ${schemeMemberInstance?.member?.emailContact} <br><br>
            ADDRESS: ${schemeMemberInstance?.member?.address} <br><br>
            </div>

            <g:form method="post" >
                <g:hiddenField name="id" value="${schemeMemberInstance?.id}" />
                <g:hiddenField name="version" value="${schemeMemberInstance?.version}" />
                
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                     <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                    </sec:ifAnyGranted>
            </div>

                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="schemeMember.scheme" default="Scheme" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'scheme', 'errors')}">
                                        ${schemeMemberInstance?.scheme?.encodeAsHTML()}
                                        <g:hiddenField name="scheme.id" value="${schemeMemberInstance?.scheme?.id}"  />                                        
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="member"><g:message code="schemeMember.member" default="Member" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'member', 'errors')}">
                                   ${schemeMemberInstance?.member?.encodeAsHTML()}
                                    <g:hiddenField name="member.id" value="${schemeMemberInstance?.member?.id}"  />

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="schemeMember.externalName" default="External Name(by Bank or ECS Agency)" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'externalName', 'errors')}">
                                    <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                        <g:textField name="externalName"  value="${schemeMemberInstance?.externalName}"  />
                                    </sec:ifAnyGranted>
                                    <sec:ifAnyGranted roles="ROLE_DONATION_COORDINATOR">
                                        ${schemeMemberInstance?.externalName?.encodeAsHTML()}
                                        <g:hiddenField name="externalName" value="${schemeMemberInstance?.externalName}"  />                                        
                                    </sec:ifAnyGranted>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="schemeMember.tobecommu" default="To Be Communicated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'toBeCommunicated', 'errors')}">
                                    <g:select name="toBeCommunicated" from="${['No','Yes']}" keys="${['No','Yes']}" value="${fieldValue(bean: schemeMemberInstance, field: 'toBeCommunicated')}"  />
                                    
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="schemeMember.tobesms" default="To Be sent SMS" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'toBeSMS', 'errors')}">
                                    <g:select name="toBeSMS" from="${['No','Yes']}" keys="${['No','Yes']}" value="${fieldValue(bean: schemeMemberInstance, field: 'toBeSMS')}"  />
                                    
                                </td>
                            </tr>

                            <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="counsumerNumber"><g:message code="schemeMember.counsumerNumber" default="Counsumer Number(From Bank/ECS Agency)" />:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'counsumerNumber', 'errors')}">                                        
                                     <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                        <g:textField name="counsumerNumber" value="${fieldValue(bean: schemeMemberInstance, field: 'counsumerNumber')}" />
                                    </sec:ifAnyGranted>
                                    <sec:ifAnyGranted roles="ROLE_DONATION_COORDINATOR">
                                        ${schemeMemberInstance?.counsumerNumber?.encodeAsHTML()}
                                        <g:hiddenField name="counsumerNumber" value="${schemeMemberInstance?.counsumerNumber}"  />                                        
                                    </sec:ifAnyGranted>

                                    </td>
                                 </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="schemeMember.centre" default="Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'centre', 'errors')}">
                                    <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                        <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${schemeMemberInstance?.centre?.id}"  />
                                    </sec:ifAnyGranted>
                                    <sec:ifAnyGranted roles="ROLE_DONATION_COORDINATOR">
                                        ${schemeMemberInstance?.centre?.encodeAsHTML()}
                                        <g:hiddenField name="centre.id" value="${schemeMemberInstance?.centre?.id}"  />                                        
                                    </sec:ifAnyGranted>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="schemeMember.secondcentre" default="Second Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'secondcentre', 'errors')}">
                                    <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                        <g:select name="secondcentre.id" from="${ics.Centre.list()}" optionKey="id" value="${schemeMemberInstance?.secondcentre?.id}"  noSelection="['null': '']"/>
                                    </sec:ifAnyGranted>
                                    <sec:ifAnyGranted roles="ROLE_DONATION_COORDINATOR">
                                        ${schemeMemberInstance?.secondcentre?.encodeAsHTML()}
                                        <g:hiddenField name="secondcentre.id" value="${schemeMemberInstance?.secondcentre?.id}"  />                                        
                                    </sec:ifAnyGranted>
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startDate"><g:message code="schemeMember.batchyear" default="Batch Year ( 2007 etc.)" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'batchyear', 'errors')}">
                                    <g:textField name="batchyear" value="${schemeMemberInstance?.batchyear?.encodeAsHTML()}"/>    
                                </td>
                            </tr>
                            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ecspercentagededuction"><g:message code="schemeMember.percentagedeductionsecondcentre" default="Donation Deduction for Second Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'percentageDeductionSecondCentreUpper', 'errors')}">

                                    <g:textField name="percentageDeductionSecondCentreUpper" value="${fieldValue(bean: schemeMemberInstance, field: 'percentageDeductionSecondCentreUpper')}" />

                                    <label for="percentageDeductionLower"><g:message code="schemeMember.percentageDeductionLower" default="Out of" />:</label>

                                    <g:textField name="percentageDeductionSecondCentreLower" value="${fieldValue(bean: schemeMemberInstance, field: 'percentageDeductionSecondCentreLower')}" />

                                    Example: 30 out 100 ,means if someone gives 1000 to this scheme ,then 300  will be deducted for second centre 
                                </td>                             
                            </tr>
                                        
                            </sec:ifAnyGranted>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="schemeMember.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'status', 'errors')}">
                                	<g:select name="status" from="${['ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" keys="${['ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" value="${fieldValue(bean: schemeMemberInstance, field: 'status')}"  />
                                    
                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="recentCommunication"><g:message code="schemeMember.recentCommunication" default="Recent Communication" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'recentCommunication', 'errors')}">
                                    <g:textArea name="recentCommunication" class="smalltextarea" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'recentCommunication')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressTheConcern"><g:message code="schemeMember.addressTheConcern" default="Address any Concern" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'addressTheConcern', 'errors')}">
                                    <g:select name="addressTheConcern" from="${['NONE','LOW','MEDIUM','HIGH']}" keys="${['NONE','LOW','MEDIUM','HIGH']}" value="${fieldValue(bean: schemeMemberInstance, field: 'addressTheConcern')}"  />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="schemeMember.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startComments"><g:message code="schemeMember.startComments" default="Start Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'startComments', 'errors')}">
                                    <g:textArea  class="smalltextarea" name="startComments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'startComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="stopComments"><g:message code="schemeMember.stopComments" default="Stop Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'stopComments', 'errors')}">
                                    <g:textArea class="smalltextarea" name="stopComments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'stopComments')}" />

                                </td>
                            </tr>
                        
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startDate"><g:message code="schemeMember.startDate" default="Start Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'startDate', 'errors')}">
                                    <g:textField name="startDate" value="${schemeMemberInstance?.startDate?.format('dd-MM-yyyy')}"/>    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="stopDate"><g:message code="schemeMember.stopDate" default="Stop Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'stopDate', 'errors')}">
                                    <g:textField name="stopDate" value="${schemeMemberInstance?.stopDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="recentResumeDate"><g:message code="schemeMember.recentResumeDate" default="Recent Resume Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'recentResumeDate', 'errors')}">
                                    <g:textField name="recentResumeDate" value="${schemeMemberInstance?.recentResumeDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="futureStartDate"><g:message code="schemeMember.futureStartDate" default="Future Start Date " />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'futureStartDate', 'errors')}">
                                    <g:textField name="futureStartDate" value="${schemeMemberInstance?.futureStartDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedFrequency"><g:message code="schemeMember.committedFrequency" default="Committed Frequency" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedFrequency', 'errors')}">
                                    <g:select name="committedFrequency" from="${['MONTHLY','QUARTERLY','HALFYEARLY','YEARLY']}" keys="${['MONTHLY','QUARTERLY','HALFYEARLY','YEARLY']}" value="${fieldValue(bean: schemeMemberInstance, field: 'committedFrequency')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedAmount"><g:message code="schemeMember.committedAmount" default="Committed Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedAmount', 'errors')}">
                                    <g:textField name="committedAmount" value="${fieldValue(bean: schemeMemberInstance, field: 'committedAmount')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="actualCurrentAmount"><g:message code="schemeMember.actualCurrentAmount" default="Actual Current Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'actualCurrentAmount', 'errors')}">
                                    <g:textField name="actualCurrentAmount" value="${fieldValue(bean: schemeMemberInstance, field: 'actualCurrentAmount')}" />

                                </td>
                            </tr>
                            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ecspercentagededuction"><g:message code="schemeMember.ecspercentagededuction" default="Donation Deduction is" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'percentageDeductionUpper', 'errors')}">
                                    <g:textField name="percentageDeductionUpper" value="${fieldValue(bean: schemeMemberInstance, field: 'percentageDeductionUpper')}" />
                                    <label for="percentageDeductionLower"><g:message code="schemeMember.percentageDeductionLower" default="Out of" />:</label>
                                    <g:textField name="percentageDeductionLower" value="${fieldValue(bean: schemeMemberInstance, field: 'percentageDeductionLower')}" />
                                    Example: 30 out 100 ,means if someone gives 1000 ,then 300  will be deducted ,only 700 considered for donation       
                                </td>                       
                            </tr>
                                        
                            </sec:ifAnyGranted>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="membershipLevel"><g:message code="schemeMember.membershipLevel" default="MemberShip Level" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'membershipLevel', 'errors')}">
                                     <g:select name="membershipLevel" from="${['','BRONZE1','BRONZE2','SILVER1','SILVER2','GOLD','PLATINUM','DIAMOND']}" keys="${['','BRONZE1','BRONZE2','SILVER1','SILVER2','GOLD','PLATINUM','DIAMOND']}" value="${fieldValue(bean: schemeMemberInstance, field: 'membershipLevel')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedMode"><g:message code="schemeMember.committedMode" default="Committed Mode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedMode', 'errors')}">
                                    <g:select name="committedMode" from="${['','ECS','E-PAYMENT','CASH','PDC']}" keys="${['','ECS','E-PAYMENT','CASH','PDC']}" value="${fieldValue(bean: schemeMemberInstance, field: 'committedMode')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedModeDetails"><g:message code="schemeMember.committedModeDetails" default="Committed Mode Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedModeDetails', 'errors')}">
                                    <g:textField name="committedModeDetails" value="${fieldValue(bean: schemeMemberInstance, field: 'committedModeDetails')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankName"><g:message code="schemeMember.bankName" default="Bank Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'bankName', 'errors')}">
                                    <g:textField name="bankName" value="${fieldValue(bean: schemeMemberInstance, field: 'bankName')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountNumber"><g:message code="schemeMember.bankName" default="Account Number" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'accountNumber', 'errors')}">
                                    <g:textField name="accountNumber" value="${fieldValue(bean: schemeMemberInstance, field: 'accountNumber')}" />

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftchanneldiscription"><g:message code="schemeMember.giftchannel" default="Gift Channel Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'giftchannelDescription', 'errors')}">
                                    <g:textArea name="giftchannelDescription" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'giftchannelDescription')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftchannel"><g:message code="schemeMember.giftchannel" default="Gift Channel" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'giftchannel', 'errors')}">                                    
                                     <g:select name="giftchannel" from="${['','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" keys="${['','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" value="${fieldValue(bean: schemeMemberInstance, field: 'giftchannel')}"  />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftperfferedAddress"><g:message code="schemeMember.giftprefferedAddress" default="Gift Preffered Address" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'giftPrefferedAddress', 'errors')}">                                    
                                     <g:select name="giftPrefferedAddress" from="${['','Correspondence','Permanent','Company','Location','Other']}"value="${fieldValue(bean: schemeMemberInstance, field: 'giftPrefferedAddress')}"  />

                                </td>
                            </tr>
                            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftPrefferedLanguage"><g:message code="schemeMember.giftPrefferedLanguage" default="Gift Preffered Language" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'giftPrefferedLanguage', 'errors')}">                                    
                                     <g:select name="giftPrefferedLanguage.id" from="${ics.Language.list()}" optionKey="id" value="${schemeMemberInstance?.giftPrefferedLanguage?.id}" class="many-to-one"  noSelection="['': '']" />

                                </td>
                            </tr>
                                        
                            </sec:ifAnyGranted>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailprefferedType"><g:message code="schemeMember.emailprefferedType" default="Email Preffered Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'prefferedEmailType', 'errors')}">                                    
                                     <g:select name="prefferedEmailType" from="${['','Personal','Official','Other']}"value="${fieldValue(bean: schemeMemberInstance, field: 'prefferedEmailType')}"  />

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactprefferedType"><g:message code="schemeMember.contactprefferedType" default="Contact Number Preffered Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'prefferedContactType', 'errors')}">                                    
                                     <g:select name="prefferedContactType" from="${['','CellPhone','HomePhone','CompanyPhone','Contact','Other']}" value="${fieldValue(bean: schemeMemberInstance, field: 'prefferedContactType')}"  />

                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ismobilenumberWorking"><g:message code="schemeMember.ismobilenumberWorking" default="Is Mobile Number Working" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'ismobilenumberWorking', 'errors')}">                                    
                                     <g:checkBox name="ismobilenumberWorking" value="${schemeMemberInstance?.ismobilenumberWorking}" />
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isModileHaveDND"><g:message code="schemeMember.isModileHaveDND" default="Mobile Number have DND enabled" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'isModileHaveDND', 'errors')}">                                    
                                     <g:checkBox name="isModileHaveDND" value="${schemeMemberInstance?.isModileHaveDND}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isemailIWorking"><g:message code="schemeMember.isemailIWorking" default="Is Email ID Working" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'isemailIWorking', 'errors')}">                                    
                                     <g:checkBox name="isemailIWorking" value="${schemeMemberInstance?.isemailIWorking}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isProfileComplete"><g:message code="schemeMember.isProfileComplete" default="Is Scheme Member Profile Complete" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'isProfileComplete', 'errors')}">  
                                    <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">                                  
                                        <g:checkBox name="isProfileComplete" value="${schemeMemberInstance?.isProfileComplete}"
                                            checked="${schemeMemberInstance?.isProfileComplete}" />
                                     </sec:ifAnyGranted>
                                     <sec:ifAnyGranted roles="ROLE_DONATION_COORDINATOR">
                                        <g:formatBoolean boolean="${schemeMemberInstance?.isProfileComplete}" true="Yes" false="No"/>   
                                    </sec:ifAnyGranted>
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentCity"><g:message code="schemeMember.currentCity" default="Current City" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'currentCity', 'errors')}">                                    
                                     <g:select name="currentCity.id" from="${ics.City.list(sort:'name')}" optionKey="id" value="${schemeMemberInstance?.currentCity?.id}"  />

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="schemeMember.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'dateCreated', 'errors')}">
                                    ${schemeMemberInstance?.dateCreated}
                                    <g:hiddenField name="dateCreated" value="${schemeMemberInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="schemeMember.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'creator', 'errors')}">
                                    ${fieldValue(bean: schemeMemberInstance, field: 'creator')}
                                    <g:hiddenField name="creator" value="${fieldValue(bean: schemeMemberInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="schemeMember.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'lastUpdated', 'errors')}">
                                    ${schemeMemberInstance?.lastUpdated}
                                    <g:hiddenField name="lastUpdated" value="${schemeMemberInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="schemeMember.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'updator', 'errors')}">
                                ${fieldValue(bean: schemeMemberInstance, field: 'updator')}
                                    <g:hiddenField name="updator" value="${fieldValue(bean: schemeMemberInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                     <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                    </sec:ifAnyGranted>
                </div>
            </g:form>
        </div>
    </body>
</html>
