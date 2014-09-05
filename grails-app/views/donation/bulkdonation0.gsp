
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Create Bulk Donation</title>

	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;}
	</style>

    </script>

		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>

    <body >

	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />    

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	<span class="menuButton"><g:link class="create" action="dummydonation">Donation</g:link></span>
            <g:if test="${donationInstance?.id}">
		<span class="menuButton"><g:link class="create" controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">IssueGift</g:link></span>
		</g:if>
	</div>
        <div class="body">
            <h1>Create Bulk Donations for Receipt Book</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>

            
	  
		    <g:form action="bulkdonation1" method="post">
			<div class="dialog">
			    <table border="0" cellspacing="0" cellpadding="0">
				<tbody bgcolor="lavender">
					<tr class="prop">
					<td valign="top" class="name">
						Receipt Book: 

					</td>
					<td valign="top" class="name" colspan="5">

						<g:textField name="rbno" value="" />

					</td>
					</tr>

				</tbody>
			    </table>
			</div>

		
			<div class="buttons">
			    <span class="button"><g:submitButton name="create" class="save" value="Next" /></span>
			</div>
		    </g:form>
            
		
	    <script language="text/javascript"> 
            	function processResponse(resp)
            	{
            		alert(resp);
            	}

      	    </script>

        </div>
    </body>
</html>
