

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>New Advance Donation</title>

	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

    	<g:javascript library="jquery" />
    	<jqui:resources theme="ui-lightness" />
    </head>
    <body>

  
    	<br>
        <div class="body">
            <h1>Personal Details</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="create3" onsubmit="return validate();">
            	<g:hiddenField name="loanedBy" value="${loanedBy}" />
            	<g:hiddenField name="loanedById" value="${loanedById}" />
            	<g:hiddenField name="councellor" value="${councellor}" />
            	<g:hiddenField name="councellorId" value="${councellorId}" />
                <div class="dialog" style="width: 550px">
                    <table border="0" width="500px">
                        <tbody>
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="loanedBy">Advance Donation By</label>
                                </td>
                                <td valign="top" class="name">
                                    <g:link controller="individual" action="show" id="${loanedById}">${loanedBy}</g:link>
                                </td>
                        		
                        	</tr>
                            <tr>
                                <td width="15%" align="right">
                                    <label for="reference1">Witness</label>
                                </td>
                                <td width="85%">
									<g:if test="${councellor!='' && councellor!=null}">

											<g:link controller="individual" action="show" id="${councellorId}">${councellor}</g:link>

									</g:if>

									<g:if test="${councellor=='' || councellor==null}">

										   <div style="width: 300px">

												<gui:autoComplete
													id="acWitness1"
													width="200px"
													controller="individual"
													action="findCollectorsAsJSON"
													useShadow="true"
													queryDelay="0.5" minQueryLength='3'

												/>
											</div>

										</td>
									</g:if>
                        		
                        		</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reference2">Project Co-ordinator- Finance</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference2', 'errors')}">
                                    <g:select name="reference2.id" from="${ics.Individual.findByLegalName('Srigurucharan Das')}" optionKey="id" value="${loanInstance?.reference2?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fatherOrSpouse">Father/Spouse</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'fatherOrSpouse', 'errors')}">
                                    <g:textField name="fatherOrSpouse" value="${fieldValue(bean: loanInstance, field: 'fatherOrSpouse')}" size="40"/>
                                    <g:link controller="loan" action="create2" id="${loanedById}" params="[loanedBy:loanedBy, loanedById:loanedById, councellor:councellor, councellorId:councellorId, reference2_id:'22412', selection:'fatherOrSpouse']" target="_blank">Use Existing</g:link>
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nominee">Nominee</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'nominee', 'errors')}">
                                    <g:textField name="nominee" value="${fieldValue(bean: loanInstance, field: 'nominee')}" size="40"/>
                                    <g:link controller="loan" action="create2" id="${loanedById}" params="[loanedBy:loanedBy, loanedById:loanedById, councellor:councellor, councellorId:councellorId, reference2_id:'22412', selection:'nominee']" target="_blank">Use Existing</g:link>
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nomineeRelation">Relationship with Donor</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'nomineeRelation', 'errors')}">
                                    <g:textField name="nomineeRelation" value="${fieldValue(bean: loanInstance, field: 'nomineeRelation')}" />
                                    
                                </td>
                                
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="next1" class="save" value="Next Step (Payment Details)" /></span>
                </div>
            </g:form>
        
			
        </div>
        <script language="javascript">

		function validate()
		{
			
			if(document.getElementById("acWitness1"))
			{
				if(document.getElementById("acWitness1").value == '')
				{
					alert("Please enter Witness!");
					document.getElementById("acWitness1").focus();
					return false;
				}
			}
			if(document.getElementById("fatherOrSpouse").value == '')
			{
				alert("Please enter Father or Spouse!");
				document.getElementById("fatherOrSpouse").focus();
				return false;
			}
			if(document.getElementById("nominee").value == '')
			{
				alert("Please enter Nominee!");
				document.getElementById("nominee").focus();
				return false;
			}
			if(document.getElementById("nomineeRelation").value == '')
			{
				alert("Please enter Relationship with Donor!");
				document.getElementById("nomineeRelation").focus();
				return false;
			}
			return true;
        }
        
        </script>
    </body>
</html>
