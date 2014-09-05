
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <title><g:message code="Issue ReceiptBook" /></title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>
    <body>
    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    	<script type="text/javascript">
            $(document).ready(function()
            {
        	$("#issueDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
            })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="Issue ReceiptBook" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${receiptBookIssuedInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptBookIssuedInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            

            <g:form name="IssueRB" action="save" method="post" onsubmit="return validate();">
                <div class="dialog">
                    <table>
                        <tbody>

<!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook">Receipt Book Category</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                    <g:select name="receiptBook.category" from="${category}" noSelection="['null': '--Select--']"
                                    onchange="${remoteFunction(
				                controller:'receiptBook', 
				                action:'ajaxGetReceiptBooks', 
				                params:'\'category=\' + escape(this.value)', 
				                onSuccess :'updateRB(data)')}"
				                
                                    />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook">Receipt Book From</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                    <g:select name="receiptBook.id" from="" optionKey="id" value="${receiptBookIssuedInstance?.receiptBook?.id}"  />
                                </td>
                            </tr>
                            
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook">Receipt Book From</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                    <g:textField name="receiptBook" value="" />
                                </td>
                            </tr>-->                            

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook">Receipt Book(s)</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                    <g:select multiple="multiple" name="id" from="${ics.ReceiptBook.findAllByStatus('Blank')}" optionKey="id" size="10"/>
                                </td>
                            </tr>
                            
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBook">Number of Books</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                    <g:textField name="numBooks" value="1" />
                                </td>
                            </tr>-->

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issuedTo"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'issuedTo', 'errors')}">
                                    <g:hiddenField name="issuedTo.id" value="" />
				   <div style="width: 300px">
					<gui:autoComplete
						id="acIssuedTo"
						width="100px"
						controller="individual"
						action="findCollectorsAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'

					/>
					</div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Councellor</label>
                                </td>
                                <td valign="top" class="value">
				   <div style="width: 300px">
					<gui:autoComplete
						id="acCouncellor"
						width="200px"
						controller="individual"
						action="findDepCouncellorAsJSON"
						dependsOn="[
								label:'individualid',
								value:'acIssuedTo',
								useId:true
						]"
						useShadow="true"
					/>
				  </div>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="issueDate"><g:message code="receiptBookIssued.issueDate.label" default="Issue Date" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'issueDate', 'errors')}">
                                    <g:textField name="issueDate" precision="day" value="${receiptBookIssuedInstance?.issueDate?:new Date().format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="receiptBookIssued.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${receiptBookIssuedInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Issue" /></span>
                </div>
            </g:form>
        </div>
	<script language="javascript"> 
		function validate() {  
		
			var rbArray = new Array();
			var i, j, x, selIndex, rbToIssue="";
			var rbIssueDate;
			var todaydt = new Date();
			var today_month, today_dt;
		
						
			/*if (document.getElementById('numBooks').value=="")
			{
				alert("Please provide Number of Books!!");
				document.getElementById('numBooks').focus();
				return false;
			}
			else
			{
				if(document.getElementById('numBooks').value > document.getElementById('receiptBook.id').length)
				{
					alert(document.getElementById('numBooks').value+" Receipt Books cannot be issued!! \nOnly "+document.getElementById('receiptBook.id').length+" Receipt Books available for the selected category.");
					document.getElementById('numBooks').focus();
					return false;
				}
			}*/

			if (document.getElementById("acIssuedTo").value=='')
			{
				alert("Please provide Name of Devotee to whom Receipt Book is Issued!!");
				document.getElementById('acIssuedTo').focus();
				return false;
			}

			if (document.getElementById("issueDate").value=='')
			{
				alert("Please provide Issue Date!!");
				document.getElementById('issueDate').focus();
				return false;
			}
			
			rbIssueDate	= (document.getElementById("issueDate").value);
			
			today_month = (todaydt.getMonth()*1)+1;
			today_dt = todaydt.getDate()+"-"+today_month+"-"+todaydt.getFullYear();
			
			if (rbIssueDate>today_dt)
			{
				alert("Issue Date cannot be a future date!!");
				document.getElementById('issueDate').focus();
				return false;
			}
			
			selIndex = document.getElementById('receiptBook.id').selectedIndex;
			 for (x=0, j=0;x<=IssueRB."receiptBook.id".length;x++,j++)
			 {	
			 	if(IssueRB."receiptBook.id"[x].selected)
			 	{
			 		rbArray[j] = InvForm.SelBranch[x].value;
			 		rbToIssue = rbToIssue + "\n" + rbArray[j];
			 		alert(rbArray[j]);
			 	}
			 }
			 
			
			/*alert(document.getElementById('receiptBook.id').value);
			for(i=selIndex, j=0; i<(selIndex + document.getElementById('numBooks').value), j<document.getElementById('numBooks').value; i++,j++)
			{
				rbArray[j] = document.getElementById('receiptBook.id').options[i].text;
				rbToIssue = rbToIssue + "\n" + rbArray;
			}*/
			//rbToIssue = rbToIssue.substring(1, rbToIssue.length);
			
			//return true;
			if (confirm("The following Receipt Book(s) will be issued: \n\n"+rbToIssue+" \n\nProceed?\n"))
				return true;
			else
				return false;
				
		}
	</script>
	


    </body>
</html>
