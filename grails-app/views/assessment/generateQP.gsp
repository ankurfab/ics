
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Generate Question Paper for ${assessmentInstance?.name}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="assessment.list" default="Assessment List" /></g:link></span>
        </div>
        <div class="body">
            <h1>Generate Question Paper for ${assessmentInstance?.name}</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${assessmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${assessmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="triggerGenerateQP" method="post" >
                <g:hiddenField name="id" value="${assessmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Number of Questions:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'name', 'errors')}">
					<g:field type="number" name="numQuestions" min="1" max="100" required="true" value="20"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Percentage of EASY questions:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'name', 'errors')}">
					<g:field type="number" name="perctEasy" min="0" max="100" required="true" value="30"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Percentage of MEDIUM questions:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'name', 'errors')}">
					<g:field type="number" name="perctMedium" min="0" max="100" required="true" value="40"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Percentage of HARD questions:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'name', 'errors')}">
					<g:field type="number" name="perctHard" min="0" max="100" required="true" value="30"/>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="language">Language:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'language', 'errors')}">
                                    <g:select name="language" from="${['ENGLISH','HINDI','MARATHI']}" value="${'ENGLISH'}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="question.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="question.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="" noSelection="['': 'Please choose the course(optional)']" />

                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Generate" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
