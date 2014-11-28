
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.show" default="Show SchemeMember" /></title>
        <r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="schemeMember.list" default="SchemeMember List" /></g:link></span>
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
            	<span class="menuButton"><g:link class="create" controller="donationRecord" action="create" target="_blank" params="['donatedBy.id': schemeMemberInstance?.member?.id,'centre.id':schemeMemberInstance?.centre?.id,'scheme.id':schemeMemberInstance?.scheme?.id]">DonationRecord</g:link></span>
            	<span class="menuButton"><g:link class="create" controller="giftRecord" action="create" target="_blank" params="['giftedTo.id': schemeMemberInstance?.member?.id]">GiftRecord</g:link></span>
            </sec:ifAnyGranted>
            
        </div>
        <div class="body">
            <h1><g:message code="schemeMember.show" default="Show SchemeMember" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div id="extradetails" style="padding:10px 10px;margin:10px 50px;border:1px solid;">
            Individual Details
            <hr>
            VOICE CONTACTS: ${schemeMemberInstance?.member?.voiceContact} <br><br>
            EMAIL CONTACTS: ${schemeMemberInstance?.member?.emailContact} <br><br>
            ADDRESS: ${schemeMemberInstance?.member?.address} <br><br>
            </div>
            <g:if test="${schemeMemberInstance?.isProfileComplete==true}">
            <div id="profilecompletedetails" style="padding:10px 10px;margin:10px 50px;border:1px solid;text-align:center;background-color:#33CC66">
                Member Profile is Complete, Keep members details updated always. 
                <g:if test="${schemeMemberInstance?.profileCompleteDate != null}">
                Marked Complete on ${schemeMemberInstance?.profileCompleteDate.format("dd MMMM YYYY")}
                </g:if>
            </div>
            </g:if>
            <g:else>
                <div id="profilecompletedetails" style="padding:10px 10px;margin:10px 50px;border:1px solid;text-align:center;background-color:#FFCCCC">
                Member Profile is NOT Complete, Please Make sure to get Profile Complete.
            </div>
            </g:else>
            <g:form style="float:left">
                <g:hiddenField name="id" value="${schemeMemberInstance?.id}" />
                <div class="dialog">
                    <table style="width: 550px;">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.scheme" default="Scheme" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.scheme?.encodeAsHTML()}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.member" default="Member" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" target="_blank" action="show" params="['id':schemeMemberInstance?.member?.id,'profile':'true','detailed':'true']">${schemeMemberInstance?.member?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.externalName" default="External Name" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.externalName?.encodeAsHTML()}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.externalName" default="To Be Communicated" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.toBeCommunicated?.encodeAsHTML()}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.counsumerNumber" default="Consumer Number" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.counsumerNumber?.encodeAsHTML()}</td>
                                
                            </tr>
                            
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.centre?.encodeAsHTML()}</td>
                                
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.secondcentre" default="Second Centre" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.secondcentre?.encodeAsHTML()}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.externalName" default="College Year Batch" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.batchyear?.encodeAsHTML()}</td>
                                
                            </tr>
                            
                            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.percentageDeductionSecondCentre" default="Donation Deduction for Second Centre" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "percentageDeductionSecondCentreUpper")}
                                <g:message code="schemeMember.percentageDeduction" default="Out of " />
                                ${fieldValue(bean: schemeMemberInstance, field: "percentageDeductionSecondCentreLower")}
                                </td>
                                
                            </tr>
                            </sec:ifAnyGranted>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "status")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.recentCommunication" default="Recent Communication" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "recentCommunication")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.addressTheConcern" default="Address Any Concern" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "addressTheConcern")}</td>
                                
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value"><div style="width:300px"> ${fieldValue(bean: schemeMemberInstance, field: "comments")}</div></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.startComments" default="Start Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "startComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.stopComments" default="Stop Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "stopComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.startDate" default="Start Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${schemeMemberInstance?.startDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.stopDate" default="Stop Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${schemeMemberInstance?.stopDate}" /></td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.recentResumeDate" default="Recent Resume Date" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "recentResumeDate")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.futureStartDate" default="Future Start Date" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "futureStartDate")}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.committedFrequency" default="Committed Frequency" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "committedFrequency")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.committedAmount" default="Committed Amount" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "committedAmount")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.actualCurrentAmount" default="Actual Current Amount per month" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "actualCurrentAmount")}</td>
                                
                            </tr>
                            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.percentageDeduction" default="Donation Deduction is" />:</td>                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "percentageDeductionUpper")}
                                <g:message code="schemeMember.percentageDeduction" default="Out of " />
                                ${fieldValue(bean: schemeMemberInstance, field: "percentageDeductionLower")}
                                </td>
                                
                            </tr>
                            </sec:ifAnyGranted>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.membershipLevel" default="Membership Level" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "membershipLevel")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.committedMode" default="Committed Mode" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "committedMode")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.committedModeDetails" default="Committed Mode Details" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "committedModeDetails")}</td>
                                
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.giftchannel" default="Gift Channel Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "giftchannelDescription")}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.giftchannel" default="Gift Channel" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "giftchannel")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.giftprefferedAddress" default="Gift Preffered Address" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "giftPrefferedAddress")}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.giftPrefferedLanguage" default="Gift Preffered Language" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.giftPrefferedLanguage?.encodeAsHTML()}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.emailprefferedType" default="Email Preffered Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "prefferedEmailType")}</td>
                                
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.contactprefferedType" default="Contact Number Preffered Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "prefferedContactType")}</td>
                                
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.ismobilenumberWorking" default="Is Mobile Number Working" />:</td>
                                
                                <td valign="top" class="value">
                                    <g:formatBoolean boolean="${schemeMemberInstance?.ismobilenumberWorking}" true="Yes" false="No"/>                                                                        
                                </td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.isModileHaveDND" default="Mobile Number have DND enabled" />:</td>
                                
                                <td valign="top" class="value">
                                    <g:formatBoolean boolean="${schemeMemberInstance?.isModileHaveDND}" true="Yes" false="No"/>                                                                        
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.isemailIWorking" default="Is Email ID Working" />:</td>
                                
                                <td valign="top" class="value">
                                    <g:formatBoolean boolean="${schemeMemberInstance?.isemailIWorking}" true="Yes" false="No"/>                                                                            
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.isProfileComplete" default="Is Scheme Member Profile Complete" />:</td>
                                
                                <td valign="top" class="value">
                                    <g:formatBoolean boolean="${schemeMemberInstance?.isProfileComplete}" true="Yes" false="No"/>                                    
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.currentCity" default="Current City" />:</td>
                                
                                <td valign="top" class="value">${schemeMemberInstance?.currentCity?.encodeAsHTML()}</td>
                                
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${schemeMemberInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${schemeMemberInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="schemeMember.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: schemeMemberInstance, field: "updator")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                         <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>                    
                    </sec:ifAnyGranted>
                </div>
            </g:form>
       
       <div>
        <script type="text/javascript">
          jQuery(document).ready(function () {
            jQuery("#donationsummary_list").jqGrid({
              url:'${createLink(controller:'helper',action:'donationRecordSummaryForSchemeMember')}',
              datatype: "json",
              postData:{id:${fieldValue(bean: schemeMemberInstance, field: "id")}},
              colNames:['donationDate','amount','mode','centre','paymentDetails','id'],
              colModel:[
            {name:'donationDate',search:false},
            {name:'amount',formatter:'showlink',search:false,
            formatoptions:{baseLinkUrl:'${createLink(controller:'donationRecord',action:'show')}',target:'_blank'}
            },
            {name:'mode',search:false},
            {name:'centre',search:false},
            {name:'paymentDetails',search:false},           
            {name:'id',hidden:true}
             ],
            rowNum:12,
            rowList:[12,24,36],
            pager: '#donationsummary_list_pager',
            viewrecords: true,
            gridview: true,
            sortname: 'amount',
            sortorder: "asc",
            width: 500,
            height: "100%",
            caption:"Donation List"
            });
            $("#donationsummary_list").jqGrid('filterToolbar',{autosearch:true});
            $("#donationsummary_list").jqGrid('navGrid',"#vehicle_list_pager",{edit:false,add:false,del:false,search:false});
            $("#donationsummary_list").jqGrid('inlineNav',"#vehicle_list_pager");
            
            });

</script>
   


        <div id="donationsummary" style="float:right;padding:10px 10px;margin:30px 50px;">           
                <div>
                <!-- table tag will hold our grid -->
                <table id="donationsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                <!-- pager will hold our paginator -->
                <div id="donationsummary_list_pager" class="scroll" style="text-align:center;"></div>
                </div>
            </div>

     <script type="text/javascript">
          jQuery(document).ready(function () {
            jQuery("#giftsummary_list").jqGrid({
              url:'${createLink(controller:'helper',action:'GiftRecordSummaryForSchemeMember')}',
              datatype: "json",
              postData:{id:${fieldValue(bean: schemeMemberInstance, field: "id")}},
              colNames:['scheme','giftDate','giftName','comments','id'],
              colModel:[
            {name:'scheme',search:false},
            {name:'giftDate',search:false},
            {name:'giftName',formatter:'showlink',search:false,
            formatoptions:{baseLinkUrl:'${createLink(controller:'giftRecord',action:'show')}',target:'_blank'}
            },
            {name:'comments',search:false},            
            {name:'id',hidden:true}
             ],
            rowNum:4,
            rowList:[4,8,12],
            pager: '#giftsummary_list_pager',
            viewrecords: true,
            gridview: true,
            sortname: 'giftDate',
            sortorder: "asc",
            width: 500,
            height: "100%",
            caption:"Gift List"
            });
            $("#giftsummary_list").jqGrid('filterToolbar',{autosearch:true});
            $("giftsummary_list").jqGrid('navGrid',"#vehicle_list_pager",{edit:false,add:false,del:false,search:false});
            $("#giftsummary_list").jqGrid('inlineNav',"#vehicle_list_pager");
            
            });

</script>
            <div id="giftsummary" style="float:right;padding:10px 10px;margin:30px 50px;">           
                <div>
                <!-- table tag will hold our grid -->
                <table id="giftsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                <!-- pager will hold our paginator -->
                <div id="giftsummary_list_pager" class="scroll" style="text-align:center;"></div>
                </div>
            </div>
        </div>
     </div>
    </body>
</html>
