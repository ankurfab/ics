<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title>Profile</title>
	<r:require module="jqui" />
    </head>
  
  <body>
  <div class="nav">
              <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
    </g:if>
   <div>
  <g:form action="save" method="post" onsubmit="return validate();" enctype="multipart/form-data">
  <g:hiddenField name="profile" value="true" />
  <g:hiddenField name="type" value="${type}" />
  <g:hiddenField name="id" value=""/>
  <table border="0" cellspacing="0" cellpadding="0">
                          <tbody bgcolor="lavender">
                          
                            <tr>
                            <td valign="top" width="10%">
			                                    <label for="legalName"><b><g:message code="individual.legalName.label" default="Name" /></b></label>*
			                                    </td>
			    
			                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}" width="60%">
			                                        <g:textField name="legalName" size="110" maxlength="127" value="${individualInstance?.legalName}" tabindex="2"/>
                                </td>
                               </tr>
                               <!--<tr>
                               <td valign="top" width="10%">
			       			                                    <label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
			       			                                    </td>
			       			    
			       			                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}" width="60%">
			       			                                        <g:textField name="initiatedName" size="110" maxlength="127" value="${individualInstance?.initiatedName}" tabindex="2"/>
                                </td>
                               </tr>-->
                               </tbody>
  </table>
  <div class="buttons">
  					<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
				</div>
  </g:form>
  </div>
  
  <script type="text/javascript">
          $(document).ready(function()
          {
		$( "#legalName" ).autocomplete({
			//source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",
			source: "${createLink(controller:'individual',action:'allIndividualsFuzzyAsJSON_JQ')}",
			minLength: 1,
			select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#id").val(ui.item.id); // update the hidden field.
			  },
			response: function(event, ui) {
			    // ui.content is the array that's about to be sent to the response callback.
			    alert(ui.content);
			    if (ui.content.length === 0) {
				$("#id").val('');
				$("#empty-message").text("No results found");
			    } else {
				$("#empty-message").empty();
			    }
			  }
		});          
          });

  </script>

  
  </body>
  
  
  </html>