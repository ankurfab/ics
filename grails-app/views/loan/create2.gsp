

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main_tabs" />
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

            <h1>Select Nominee</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="create1" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                        <g:hiddenField name="loanedBy" value="${loanedBy}" />
                        <g:hiddenField name="loanedById" value="${loanedById}" />
						<g:hiddenField name="councellor" value="${councellor}" />
						<g:hiddenField name="councellorId" value="${councellorId}" />
						<g:hiddenField name="reference2Id" value="${reference2Id}" />
						<g:hiddenField name="reference2" value="${reference2}" />
                        <g:hiddenField name="nomineeId" value="" />
                        <g:hiddenField name="selection" value="${selection}" />
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="loanedBy">Advance Donation By</label>
                                </td>
                                <td valign="top" class="name">
                                    <g:link controller="individual" action="show" id="${loanedById}">${loanedBy}</g:link>
                                </td>
                        		
                        	</tr>
                        	<tr>
                                <td valign="top" class="name">
                                    <label>Nominee</label>
                                </td>
                        	
                       			<g:set var="hasFamily" value="false" />
                                <td valign="top" class="name">
									
									<g:each in="${individualInstance?.relative2?}" var="r">
										<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
											<br><g:radio name="nominee" value="${r}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
											<g:set var="hasFamily" value="true" />
										</g:if>
									</g:each>
									
									
									<g:if test="${familyHead!='' && familyHead!=null}">
										<g:hiddenField name="familyHead" value="${familyHead}" />
										Family of ${familyHead}
										<br>
										<br><g:radio name="nominee" value="${familyHead}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${familyHead.id}">${familyHead?.encodeAsHTML()}</g:link>
										<g:each in="${familyHead?.relative2?}" var="r">
											<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
											
												<g:if test="${r.individual1.id.toInteger() == loanedById.toInteger()}">
													<br><g:radio name="nominee" value="${r}" disabled="true"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
												</g:if>
												<g:if test="${r.individual1.id.toInteger() != loanedById.toInteger()}">
													<br><g:radio name="nominee" value="${r}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
												</g:if>
												<g:set var="hasFamily" value="true" />
											</g:if>
										</g:each>
										
										
									</g:if>
									<g:hiddenField name="familyExists" value="${hasFamily}" />
									<br><g:link controller="relationship" action="create" params="['individual2.id': individualInstance?.id, family: true]">Add Family Member</g:link>
                                    
                                </td>
                               </tr>
                               <tr>
                               <td valign="top" class="name">
							                                       
                                </td>
                                <td valign="top" class="name">
									<g:set var="hasCultivator" value="false" />
									<g:each in="${individualInstance?.relative1?}" var="r">
										<g:if test="${r?.relation?.name == 'Cultivated by' && r.status == 'ACTIVE'}">
											<g:set var="hasCultivator" value="true" />
											<br><g:radio name="nominee" value="${r}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
										</g:if>
									</g:each>
									
										<g:if test="${hasCultivator=='false'}">
											<g:link controller="relationship" action="create" params="['individual1.id': individualInstance?.id, 'relationName' : 'Cultivated by']">Add ISKCON Representative</g:link>
										</g:if>
                                
                                </td>
                        	</tr>
                        	<tr>
                                <td valign="top" class="name">
                                    
                                </td>
                        		<td>
									
									<g:set var="isDisciple" value="false" />
									<g:set var="isCouncelle" value="false" />
									<g:each in="${individualInstance?.relative1?}" var="r">
										<g:if test="${r?.relation?.name == 'Disciple of' && r.status == 'ACTIVE'}">
											<g:set var="isDisciple" value="true" />
												<br><g:radio name="nominee" value="${r}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
										</g:if>
										<g:elseif test="${r?.relation?.name == 'Councellee of' && r.status == 'ACTIVE'}">
											<g:set var="isCouncelle" value="true" />
												<br><g:radio name="nominee" value="${r}" onClick="enterValue();"/> <g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link>
										</g:elseif>
									</g:each>
									
										<g:if test="${isDisciple == 'false'}">
											<g:link controller="relationship" action="create" params="['individual1.id': individualInstance?.id , 'relationName' : 'Disciple of']">Add Guru</g:link>
											<br><br>
										</g:if>
										<g:if test="${isCouncelle == 'false'}">
											<g:link controller="relationship" action="create" params="['individual1.id': individualInstance?.id, 'relationName' : 'Councellee of']">Add Councellor</g:link>
										</g:if>
                        		
                        		</td>
                        	</tr>
                        </tbody>
                    </table>
                </div>
                <!--<div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Enter" onclick="enterValue();"/></span>
                </div>-->
            </g:form>
        
			
        </div>
        <script language="javascript">
        function validate()
        {
			var nomineeRadioButtons = document.getElementsByName("nominee");
			
			if(document.getElementById("familyExists").value == "false")
			{
				alert("Please add Father or Spouse!");
				return false;
			}
			
			for(i=0; i< nomineeRadioButtons.length; i++)
			{
				if(nomineeRadioButtons[i].checked == true)
				{
					document.getElementById("nomineeId").value = nomineeRadioButtons[i].value;
					return true;
				}
			}
			if(document.getElementById("nomineeId").value == '')
			{
				alert("Please select a Nominee!");
				return false;
			}
        }
        
        function enterValue()
        {
        	//alert(document.getElementById("familyHead"));
        	//if(document.getElementById("selection").value == "")
        	
			var nomineeRadioButtons = document.getElementsByName("nominee");
			var relationshipArray = new Array();
			
			for(i=0; i< nomineeRadioButtons.length; i++)
			{
				if(nomineeRadioButtons[i].checked == true)
				{
					//document.getElementById("nomineeId").value = nomineeRadioButtons[i].value;
					if (nomineeRadioButtons[i].value.indexOf("->") == -1)
					{	
						opener.document.getElementById(document.getElementById("selection").value).value = nomineeRadioButtons[i].value;
						opener.document.getElementById("nomineeRelation").value = '';
						break;
					}
					relationshipArray = nomineeRadioButtons[i].value.split("->");
					//alert(trim(relationshipArray[1]));
					opener.document.getElementById(document.getElementById("selection").value).value = trim(relationshipArray[1]); //nomineeRadioButtons[i].value;
					if(document.getElementById("selection").value == "nominee")
					{
						//alert(trim(relationshipArray[0]));
						if (trim(relationshipArray[0]) == "Disciple of")
						{
							opener.document.getElementById("nomineeRelation").value = "Guru";
						}
						else if (trim(relationshipArray[0]) == "Councellee of")
						{
							opener.document.getElementById("nomineeRelation").value = "Councellor";
						}
						else if (trim(relationshipArray[0]) == "Cultivated by")
						{
							opener.document.getElementById("nomineeRelation").value = "Cultivator";
						}
						else
						{
							if (document.getElementById("familyHead")==null)
								opener.document.getElementById("nomineeRelation").value = trim(relationshipArray[0]);
							else
								opener.document.getElementById("nomineeRelation").value = '';
						}
					}
					break;
				}
			}
        	window.close();
        }
        
        function trim(stringToTrim) {
			return stringToTrim.replace(/^\s+|\s+$/g,"");
		}

        </script>
    </body>
</html>
