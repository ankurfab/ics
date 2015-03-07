
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.upload.show" default="Upload DonationRecord" /></title>

    </head>
    <body>
     <r:require module="jqui" />
     <r:require module="grid" />
            <script>
            $(document).ready(function() {
            $( "#resolvediv" ).dialog({
            height: 540,
            width:800,
            modal: true,
            autoOpen:false
            });
            });

            var paymentdetailId;
            function openresolveBox(name,consumerNumber,id){
                $("#resolvediv" ).dialog("open");
                $("#externalnametoresolve").val(name);
                $("#consumernumbertoresolve").val(consumerNumber);
                $("#externalnametoedit").val(name);
                paymentdetailId = id;
                 $("#individual_list").trigger("reloadGrid");
            }


            </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
            </sec:ifAnyGranted>
         
            
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.show" default="Processing DonationRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <div id="information" class="value" style="float:left;padding:10px 10px;margin:10px 10px;border:1px solid;">
                Red : There is error in Record, It will not be processed. Could not found Individual as per ECS mandate <br>
                Green: Record is resolved, Upload Again.<br>
                Yellow:Record with same Transaction Id found. Correct the File.<br>
                Blue: Record of Donations given by the Individual for the Scheme in Same Month<br>
            </div>
            <g:form>
            <div class="dialog">
                    <table>
                    <thead>
                        <tr>
                        <g:sortableColumn property="donatedBy" title="Member" titleKey="donationRecord.donatedBy" />

                        <g:sortableColumn property="donationDate" title="Donation Date" titleKey="donationRecord.donationDate" />
                        
                        <g:sortableColumn property="amount" title="Amount" titleKey="donationRecord.amount" />

                        <g:if test="${usepercentagededuction == true}">
                                <th><g:message code="donationRecord.usepercentagededuction" default="Precentage Deduction" /></th>
                                <th><g:message code="donationRecord.amountafterdeduction" default="Amount after Deduction" /></th>
                        </g:if>
                        
                        <th><g:message code="donationRecord.mode" default="Mode" /></th>
                        
                        <g:sortableColumn property="details" title="Details" titleKey="donationRecord.details" />

                        <g:sortableColumn property="transactionId" title="TransactionID" titleKey="donationRecord.transactionId" />
                        
                        <th><g:message code="donationRecord.reference" default="Referance" /></th>

                        <th><g:message code="donationRecord.memberdetails" default="Member Details" /></th>

                        </tr>
                    </thead>
                        <tbody>
                         <g:each in="${recordlist}" status="i" var="record">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'} ${record.alreadyExist==null?'':'yellow'}">
                            <td><g:link controller="schemeMember" action="show" params="['id':record?.schemeMember?.id]" target="_blank">${fieldValue(bean: record, field: "donatedBy")}</g:link></td>
                            <td>${fieldValue(bean: record, field: "donationDate")}</td>
                            <td>${fieldValue(bean: record, field: "amount")}</td>
                            <g:if test="${usepercentagededuction == true}">
                                <td>${record.usepercentagededuction}</td>
                                <td>${record.amountafterdeduction}</td>
                            </g:if>
                            <g:if test="${record?.mode== null}">
                                <td class="red">This mode is not existing,please create</td>
                            </g:if>
                            <g:else>
                                <td>${fieldValue(bean: record, field: "mode")}</td>
                            </g:else>
                            
                            <g:if test="${record?.donatedBy== null}">
                                <td id="paymentdetail${i}" class="red" onclick="openresolveBox('${record.donorName?.encodeAsHTML()}','${record.consumberNumber?.encodeAsHTML()}','paymentdetail${i}')">
                                    ${fieldValue(bean: record, field: "paymentDetails")}
                                    <g:hiddenField name="donorname" value="${record.donorName?.encodeAsHTML()}"/> 
                                    <g:hiddenField name="consumernumber" value="${record.consumberNumber?.encodeAsHTML()}"/> 
                                </td>

                            </g:if>
                            <g:else>
                                <td>
                                    ${fieldValue(bean: record, field: "paymentDetails")}                                    
                                </td>
                            </g:else>                            
                            <td>${fieldValue(bean: record, field: "transactionId")}</td>

                            <td>${fieldValue(bean: record, field: "reference")}</td>

                            <td>${fieldValue(bean: record, field: "memberdetails")}</td>
                            
                        </tr>
                        <g:if test="${record.samemonthdonations != null}">
                                 <g:each in="${record.samemonthdonations}" status="j" var="monthrecord">
                                <tr class="blue">
                                    <td>${fieldValue(bean: monthrecord, field: "donatedBy")}</td>
                                    <td>${fieldValue(bean: monthrecord, field: "donationDate")}</td>
                                    <td>${fieldValue(bean: monthrecord, field: "amount")}</td>
                                     <g:if test="${usepercentagededuction == true}">
                                     <td></td>
                                     <td></td>
                                     </g:if>
                                     <td>${fieldValue(bean: monthrecord, field: "mode")}</td>
                                      <td>
                                            ${fieldValue(bean: monthrecord, field: "paymentDetails")}                                    
                                      </td>                                                                
                                    <td>${fieldValue(bean: monthrecord, field: "transactionId")}</td>
                                    <td>${fieldValue(bean: monthrecord, field: "reference")}</td>
                                    
                                </tr>
                                </g:each>
                        </g:if>
                        </g:each>
                       
                    </tbody>
                    </table>
            </div>
            
             <div class="buttons"> 

                <g:if test="${duplicaterecordfound != null && errorflag == null}">
                 <span class="button"><g:actionSubmit class="edit" action="savefiledata" value="${message(code: 'dispalyfiledata', 'default': 'Upload Only Unique Data')}" onclick="return confirm('${message(code: 'upload.confirm', 'default': 'Are you sure to Upload?')}');" /></span>
               
                </g:if>
                <g:elseif test="${errorflag == null}">                  
                    <span class="button"><g:actionSubmit class="edit" action="savefiledata" value="${message(code: 'dispalyfiledata', 'default': 'Upload Data')}" onclick="return confirm('${message(code: 'upload.confirm', 'default': 'Are you sure to Upload?')}');" /></span>
               
                </g:elseif>
                <g:else>
                    <span class="button red">Please correct the Data and upload AGAIN</span>
                </g:else>
            </div>
        </g:form>
        </div>
         <div id="resolvediv" title="Resolve Member">
        <p>Resolve Members by Their external Names.</p>
        <g:form>
             

                <div>
                    <table>
                        <tbody>
                            <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.name" default="External Name" />:</label>
                                            </td>
                                            <td valign="top" class="value">
                                                
                                                <g:textField name="externalnametoresolve" id="externalnametoresolve" width="250px" readonly="true"/>
                                               
                                            </td>
                              </tr>
                               <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.consumer" default="Consumer Number/Donor Id" />:</label>
                                            </td>
                                            <td valign="top" class="value">
                                                
                                                <g:textField name="consumernumbertoresolve" id="consumernumbertoresolve" width="250px" readonly="true"/>
                                               
                                            </td>
                              </tr>
                                <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="name"><g:message code="schememember.name" default="Search" />:</label>
                                            </td>
                                            <td valign="top" class="value">

                                                <g:textField name="externalnametoedit" id="externalnametoedit" width="250px"/>
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
                                  postData:{selectedCenter:'0',sname:function(){return $("#externalnametoedit").val();}},
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
                                
                                if(id) {
                                     var extname = $("#externalnametoresolve").val();
                                     var cnumber = $("#consumernumbertoresolve").val();
                                        var url = "${createLink(controller:'schemeMember',action:'setExternalName')}"+"?schemememberid="+id+"&externalname="+extname+"&consumernumber="+cnumber
                                        $.post(url, {}, function(data) {
                                            $("#"+paymentdetailId).removeClass('red');
                                            $("#"+paymentdetailId).addClass('green');
                                            alert(data);
                                            }); 
                                }
                                else
                                    alert("Please select rows!!");
                            });

                            $("#externalnametoedit").keydown(function(event){

                                if ( event.keyCode === $.ui.keyCode.ENTER){
                                    $("#individual_list").trigger("reloadGrid");
                                }
                            });

                            });
                            </script>
                    
                </div>

        </g:form>
        </div>
    </body>
</html>
