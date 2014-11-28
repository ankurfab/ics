
<%@ page import="ics.EventRegistration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${eventRegistrationInstance?.event?.title} Registration</title>
    </head>
    <body>
        <div class="nav" role="navigation">
		<ul>
			<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</ul>
	</div>
	<div class="body" width="100%">
            <h1>Online registration for ${eventRegistrationInstance?.event?.title}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventRegistrationInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventRegistrationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="create" method="post">
                <g:hiddenField name="eventName" value="${eventRegistrationInstance?.event?.title}" />
                <g:hiddenField name="eid" value="${eventRegistrationInstance?.event?.id}" />
                <div class="dialog">
                	<table>
                	<tr>
			<td>
                    <table>
                        <tbody>
			    <tr class="prop" style="display:block">
			        <td>&nbsp;</td>
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="eventRegistration.event.label" default="Event" /></label>
				    <span class="required-indicator">*</span>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'event', 'errors')}">
                                    <g:select disabled="false" id="event" name="event.id" from="${ics.Event.findAllByRegistrationMode('Public',[sort:'title'])}" optionKey="id" optionValue="title" required="" value="${eventRegistrationInstance?.event?.id}" class="many-to-one"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
			        <td>&nbsp;</td>
                                <td valign="top" class="name">
				     <label for="name">
					     <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
						<g:message code="eventRegistration.vipName" default="Name of Main Guest" />
					     </sec:ifAnyGranted>
					     <sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
						<g:message code="eventRegistration.name" default="Name" />
					     </sec:ifNotGranted>
				      :</label>&nbsp;
				    <span class="required-indicator">*</span>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${eventRegistrationInstance?.name}" />
                                </td>
                            </tr>
                        
                            <!-- to be used later on
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code">Registration Code [Optional]</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'regCode', 'errors')}">
                                    <g:textField name="regCode" value="${eventRegistrationInstance?.regCode}" />
                                </td>
                            </tr>
                            -->
			    
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <img src="${createLink(controller: 'simpleCaptcha', action: 'captcha')}"/>
                                </td>
				<td valign="top" class="name">
					<label for="captcha" style="vertical-align:center;">Type the letters in the box:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'regCode', 'errors')}">
				    <g:textField name="captcha"/>
                                </td>
                            </tr>

                            <tr class="prop">
			        <td>&nbsp;</td>
                                <td valign="top" class="name">
                                    &nbsp;
                                </td>
                                <td valign="top">
				    <div class="buttons" style="width:100px;">
				    <span class="button">
                                        <g:submitButton name="verify" class="save" value="Submit" />
				    </span>
				    </div>
				    <div style="display:none">
					<!--<h1 style="color:red">Due to overwhelming response of devotees, we have exceeded our Accommodation capacity. We are unable to provide Accommodation for the time being.<br>
					For any details or clarification, kindly contact: Kiran pr - 09158164563/ Email - register@iskconpune.in
					</h1>-->
					<h1 style="color:red"><b>Last Date for Registration is 4th Feb 2013, Monday.<b><br> </h1>
					<h2 style="color:red">We would like to thank all of you for your wonderful and enthusiastic response. We need to stop the process of Registrations in order to start allocation of Accommodation and other facilities. Therefore all registrations will be closed from 4th Feb 2013, Monday, 10.00 pm
					</h2>
				    </div>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>			        
			</td>
			<td>
				<!--<a href="http://www.iskconpune.in"><img src="${resource(dir:'images',file:'rvto-poster.jpg')}"
				  alt="NVCC" /></a>-->                                
			</td>			
                	</tr>
                	</table>
                </div>

            </g:form>
        </div>
    </body>
</html>
