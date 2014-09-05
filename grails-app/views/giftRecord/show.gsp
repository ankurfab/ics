
<%@ page import="ics.GiftRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="giftRecord.show" default="Show GiftRecord" /></title>
    </head>
    <body>
    <r:require module="jqui" />
            <script>
            $(document).ready(function() {

            $( "#commenteditdiv" ).dialog({
            height: 340,
            width:500,
            modal: true,
            autoOpen:false
            });

            $("#commentsvalue").click(function(){
                $( "#commenteditdiv" ).dialog("open");
            });
            });
            </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="list" action="list"><g:message code="giftRecord.list" default="GiftRecord List" /></g:link></span>
            </sec:ifAnyGranted>
            
        </div>
        <div class="body">
            <h1><g:message code="giftRecord.show" default="Show GiftRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${giftRecordInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.giftedTo" default="Gifted To" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${giftRecordInstance?.giftedTo?.id}">${giftRecordInstance?.giftedTo?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.gift" default="Gift" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="gift" action="show" id="${giftRecordInstance?.gift?.id}">${giftRecordInstance?.gift?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.giftDate" default="Gift Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${giftRecordInstance?.giftDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.quantity" default="Quantity" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "quantity")}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.scheme" default="Scheme" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "scheme")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "centre")}</td>
                                
                            </tr>
                            

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.reference" default="Reference" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "reference")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value" id="commentsvalue">${fieldValue(bean: giftRecordInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.giftReceivedStatus" default="Gift Received Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "giftReceivedStatus")}</td>
                                
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.giftReceivedStatus" default="Way Gift Collected" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "giftChannel")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${giftRecordInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${giftRecordInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="giftRecord.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: giftRecordInstance, field: "updator")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                 <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>

                    <span class="menuButton"><g:link class="create" controller="giftRecord" action="create" target="_blank" params="['giftedTo.id': giftRecordInstance?.giftedTo?.id, 'giftid':giftRecordInstance?.id]">Copy & Create GiftRecord</g:link></span>

                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
                </sec:ifAnyGranted>
            </g:form>
        </div>
         <div id="commenteditdiv" title="Enter Comments">
        <p>Enter Gift Record Comments here.</p>
        <g:form>
             <g:hiddenField name="id" value="${giftRecordInstance?.id}" />

                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                            <td valign="top" class="name">
                                                <label for="comments"><g:message code="giftRecord.comments" default="Comments" />:</label>
                                            </td>
                                            <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'comments', 'errors')}">
                                                
                                                <g:textArea name="updatedcomments" rows="2" cols="80" value="${fieldValue(bean: giftRecordInstance, field: 'comments')}" />
                                            </td>
                                        </tr>
                        </tbody>
                    </table>
                    <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updatecomments" value="${message(code: 'update', 'default': 'Update')}" /></span>                   
                </div>
                </div>

        </g:form>
        </div>
    </body>
</html>
