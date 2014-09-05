
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Assign login-id to Individual</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${individualInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="assignsave" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="role">User Role</label>
                                </td>
                                <td valign="top" class="name">
                                    <g:select name="icsRole.id" from="${icsRoleList}" optionKey="id" optionValue="${{it.authority}}" value=""  
                                    onchange="${remoteFunction(controller:'helper', action:'ajaxListIcsUsers', params:'\'id=\' + escape(this.value)', onSuccess:'updateIcsUser(data)')}"
                                    />
                                </td>
                            </tr>
                            
                            <tr class="prop">
			                                    <td valign="top" class="name">
			                                        <label for="user">User</label>
			                                    </td>
			                                    <td valign="top" class="name">
			                                        <g:select name="icsuser" from="" id="icsuser"></g:select>
			                                    </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individualrole">Individual Role</label>
                                </td>
                                <td valign="top" class="name">
                                    <g:select name="role.id" from="${roleList}" optionKey="id" optionValue="${{it.name}}" value=""  
                                    onchange="${remoteFunction(controller:'helper', action:'ajaxListIndividuals', params:'\'id=\' + escape(this.value)', onSuccess:'updateIndividual(data)')}"
                                    />
                                </td>
                            </tr>
                            
                            <tr class="prop">
			                                    <td valign="top" class="name">
			                                        <label for="individual">Individual</label>
			                                    </td>
			                                    <td valign="top" class="name">
			                                        <!--<g:select name="individual" from="" id="individual"></g:select>-->
			                                    </td>
                            </tr>
                             
			 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="assign" class="save" value="Assign" /></span>
                </div>

            </g:form>
        </div>
        
            <g:javascript>
	    
	    function updateIcsUser(icsUsers) { // The response comes back as a bunch-o-JSON
	    //var icsUsers = eval("(" + e.responseText + ")") // evaluate JSON
	    
	    if (icsUsers) 
	    { 
	    var rselect = document.getElementById('icsuser')
	    
	    // Clear all previous options
	    var l = rselect.length
	    
	    while (l > 0) {
	    l--
	    rselect.remove(l) }
	    
	    // Rebuild the select
	    for (var i=0; i < icsUsers.length; i++) 
	    { var iu = icsUsers[i]
	    var opt = document.createElement('option');
	    opt.text = iu.username
	    opt.value = iu.id
	    try { rselect.add(opt, null)
	    // standards compliant; doesn't work in IE
	    } catch(ex) { 
	    rselect.add(opt) // IE only 
	    } } } }
	    
	    // This is called when the page loads to initialize iu
	    var zselect = document.getElementById('icsRole.id')
	    var zopt = zselect.options[zselect.selectedIndex]
	    ${remoteFunction(controller:"helper", action:"ajaxListIcsUsers", params:"'id=' + zopt.value", onSuccess:"updateIcsUser(data)")}
	   
	   	    function updateIndividual(individuals) { // The response comes back as a bunch-o-JSON
	   	    //var individuals = eval("(" + e.responseText + ")") // evaluate JSON
	   	    
	   	    if (individuals) 
	   	    { 
	   	    var rselect = document.getElementById('individual')
	   	    
	   	    // Clear all previous options
	   	    var l = rselect.length
	   	    
	   	    while (l > 0) {
	   	    l--
	   	    rselect.remove(l) }
	   	    
	   	    // Rebuild the select
	   	    for (var i=0; i < individuals.length; i++) 
	   	    { var iu = individuals[i]
	   	    var opt = document.createElement('option');
	   	    opt.text = iu.initiatedName+":"+iu.legalName
	   	    opt.value = iu.id
	   	    try { rselect.add(opt, null)
	   	    // standards compliant; doesn't work in IE
	   	    } catch(ex) { 
	   	    rselect.add(opt) // IE only 
	   	    } } } }
	   	    
	   	    // This is called when the page loads to initialize iu
	   	    var zselect1 = document.getElementById('role.id')
	   	    var zopt1 = zselect1.options[zselect1.selectedIndex]
	   	    ${remoteFunction(controller:"helper", action:"ajaxListIndividuals", params:"'id=' + zopt1.value", onSuccess:"updateIndividual(data)")}
	
		</g:javascript>

    </body>
</html>
