
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.show" default="Show DonationRecord" /></title>

    </head>
    <body>
     <r:require module="jqui" />

     <r:require module="grid" />
            <script>
            $(document).ready(function() {

            $( "#commenteditdiv" ).dialog({
            height: 340,
            width:500,
            modal: true,
            autoOpen:false
            });

            $("#commentsvalue").click(function(){
                $( "#commenteditdiv" ).dialog("open");
            });
            });

             $(document).ready(function() {
            $( "#resolvediv" ).dialog({
            height: 540,
            width:800,
            modal: true,
            autoOpen:false
            });
            });
             var donationRecordId ;
             function openresolveBox(name,individualId,recordId){
             
                $("#resolvediv" ).dialog("open");
                $("#donorname").val(name);
                $("#individualId").val(individualId);
                $("#donornametoedit").val(name);
                donationRecordId = recordId;
                 $("#individual_list").trigger("reloadGrid");
            }

            </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
                <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
                <span class="menuButton"><g:link class="list" action="print" id="${donationRecordInstance?.id}">Print</g:link></span>
            </sec:ifAnyGranted>
         
            
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.show" default="Show DonationRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${donationRecordInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.donatedBy" default="Donated By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${donationRecordInstance?.donatedBy?.id}">${donationRecordInstance?.donatedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.donationDate" default="Donation Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${donationRecordInstance?.donationDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.amount" default="Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${donationRecordInstance?.amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.scheme" default="Scheme" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="scheme" action="show" id="${donationRecordInstance?.scheme?.id}">${donationRecordInstance?.scheme?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="centre" action="show" id="${donationRecordInstance?.centre?.id}">${donationRecordInstance?.centre?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.reference" default="Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "reference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value" id="commentsvalue">${fieldValue(bean: donationRecordInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.mode" default="Mode" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="paymentMode" action="show" id="${donationRecordInstance?.mode?.id}">${donationRecordInstance?.mode?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.paymentDetails" default="Payment Details" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "paymentDetails")}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.transactionId" default="Transaction Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "transactionId")}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.rbno" default="Receipt Book No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "rbno")}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.rno" default="Receipt No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "rno")}</td>
                                
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.receiptReceivedStatus" default="Receipt Received Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "receiptReceivedStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${donationRecordInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${donationRecordInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="donationRecord.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: donationRecordInstance, field: "updator")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            <g:if test="${donationRecordInstance?.receiptReceivedStatus == null || donationRecordInstance?.receiptReceivedStatus =='NOTGENERATED'}">
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                    <span class="button"><g:actionSubmit class="edit"  value="${message(code: 'move', 'default': 'Move To Another Member')}" onclick="openresolveBox('${donationRecordInstance?.donatedBy?.encodeAsHTML()}','${donationRecordInstance?.donatedBy?.id}','${donationRecordInstance?.id}');return false;" /></span>

                </div>
            </sec:ifAnyGranted>
            </g:if>
            <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
            <g:if test="${donationRecordInstance?.receiptReceivedStatus =='NOTGENERATED'}">
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:if>
            </sec:ifAnyGranted>
            </g:form>
        </div>
        <div id="commenteditdiv" title="Enter Comments">
        <p>Enter Donation Record Comments here.</p>
        <g:form>
             <g:hiddenField name="id" value="${donationRecordInstance?.id}" />

                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="comments"><g:message code="donationRecord.comments" default="Comments" />:</label>
                                            </td>
                                            <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'comments', 'errors')}">
                                                
                                                <g:textArea name="updatedcomments" rows="2" cols="80" value="${fieldValue(bean: donationRecordInstance, field: 'comments')}" />
                                            </td>
                                        </tr>
                        </tbody>
                    </table>
                    <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updatecomments" value="${message(code: 'update', 'default': 'Update')}" /></span>                   
                </div>
                </div>

        </g:form>
        </div>
        
        <div id="resolvediv" title="Resolve Member">
        <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
        <p>Resolve Members by Their external Names.</p>
        <g:form>
             

                <div>
                    <table>
                        <tbody>
                            <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.name" default="Donor Name" />:</label>
                                            </td>
                                            <td valign="top" class="value">
                                                
                                                <g:textField name="donorname" id="donorname" width="250px" readonly="true"/>
                                               
                                            </td>
                              </tr>
                               <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.consumer" default="Donor Individual Id" />:</label>
                                            </td>
                                            <td valign="top" class="value">
                                                
                                                <g:textField name="individualId" id="individualId" width="250px" readonly="true"/>
                                               
                                            </td>
                              </tr>
                                <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.name" default="Search" />:</label>
                                            </td>
                                            <td valign="top" class="value">

                                                <g:textField name="donornametoedit" id="donornametoedit" width="250px"/>
                                            </td>
                              </tr>
                        </tbody>
                        </table>
                            <table id="individual_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                            <!-- pager will hold our paginator -->
                            <div id="individual_list_pager" class="scroll" style="text-align:center;"></div>

                            <input class="menuButton" type="BUTTON" id="resolveBtn" value="Resolve" />

                            <script type="text/javascript">     
                              $(document).ready(function () {
                                jQuery("#individual_list").jqGrid({
                                  url:'${createLink(controller:'schemeMember',action:'jq_allschemeMember_by_externalname')}',
                                  postData:{selectedCenter:'0',sname:function(){return $("#donornametoedit").val();}},
                                  datatype: "json",
                                 colNames:['Scheme','Member', 'externalName','counsumerNumber', 'Status','Comments','center','id'],
                                  colModel:[
                                {name:'scheme',search:false},
                                {name:'member',search:true,formatter:'showlink',
                                formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
                                },
                                {name:'externalName',search:false},
                                {name:'counsumerNumber',search:false},
                                {name:'status',search:false},
                                {name:'comments',search:false},
                                {name:'center',search:false},
                                
                                {name:'id',hidden:true}
                                 ],
                                rowNum:10,
                                rowList:[10,20,30,40,50,100,150,200],
                                pager: '#individual_list_pager',
                                viewrecords: true,
                                gridview: true,
                                sortorder: "asc",
                                width: 750,
                                height: "100%",
                                multiselect: false,
                                caption:"Individual List"
                                });
                               $("#individual_list").jqGrid('filterToolbar',{autosearch:true});
                               $("#individual_list").jqGrid('navGrid',"#individual_list_pager",
                                {edit:false,add:false,del:false,search:false}
                                );
                            $( "#resolveBtn" )
                            .button()
                            .click(function() {
                                var id = jQuery("#individual_list").jqGrid('getGridParam','selrow');
                                // this id is new selected scheme member id
                                if(id) {
                                       var url = "${createLink(controller:'donationRecord',action:'setNewIndividualIdForRecord')}"+"?newchemememberid="+id+"&donationrecordid="+donationRecordId;
                                        $.post(url, {}, function(data) {                                            
                                            alert(data);
                                            location.reload();
                                            }); 
                                }
                                else
                                    alert("Please select rows!!");
                            });

                            $("#donornametoedit").keydown(function(event){

                                if ( event.keyCode === $.ui.keyCode.ENTER){
                                    $("#individual_list").trigger("reloadGrid");
                                }
                            });

                            });
                            </script>
                    
                </div>

        </g:form>
         </sec:ifAnyGranted>
        </div>
       
    </body>
</html>
