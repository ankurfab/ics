
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Link Donor</title>
	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
            <span class="menuButton"><g:link class="list" controller="helper" action="searchIndividual">SearchIndividual</g:link></span>
        </div>
        <div class="body">
            <h1>Link Donor</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${donationInstance?.id}" />
                <g:hiddenField name="version" value="${donationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                	<!--<g:link elementId="showindlink" controller="individual" action="show" onclick="showInd();">Donated By</g:link>-->
                                	<label for="donatedBy">Donated By</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}">
                                    <g:hiddenField name="donatedBy.id" value="" />
				    <div style="width: 300px">
						<gui:autoComplete
						id="acDonatedBy"
						width="300px"
						controller="individual"
						action="allIndividualsExceptDummyDonorAsJSON"
						useShadow="true"
						queryDelay="0.5" minQueryLength='3'
						/>
					</div>
                                       
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="donation.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${donationInstance?.comments}" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="linkdonorupdate" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
            <script language="javascript"> 
	    function showInd() {
	    	var ele = document.getElementById('acDonatedBy_id');
	    	var lnk = document.getElementById('showindlink');
	    	lnk.href = lnk.href+"/"+ele.value;
	    } 
	    <!--function validate() {   
	    //alert("value: "+document.getElementById("acdonatedBy").value);
		if (document.getElementById("donatedBy").value=='')
		{
			alert("Please provide Donor Name!!");
			document.getElementById('donatedBy').focus();
			return false;
		}
	    	return true;
	    }-->
	    </script>
            
            
        </div>
    </body>
</html>
