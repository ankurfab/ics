
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.upload.show" default="Upload DonationRecord" /></title>

    </head>
    <body>
     <r:require module="jqui" />
            <script>
            $(document).ready(function() {

          
            });
            </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_ECS">
                <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
            </sec:ifAnyGranted>
         
            
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.show" default="Upload DonationRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <g:uploadForm>
            <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
                         Use ECS Return File:
                        </td>
                        <td valign="top" class="value">
                        <g:radio name="uploadtype" value="ecs" checked="checked"></g:radio>
                        </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                            Use Account Office File:
                            </td>

                            <td valign="top" class="value">
                            <g:radio name="uploadtype" value="account"></g:radio>
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            Scheme
                            </td>

                            <td valign="top" class="value">
                                <g:select name="scheme" from="${schemes}" optionKey="id"   />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            Use Percetange Deduction
                            </td>

                            <td valign="top" class="value">
                                 <g:checkBox name="usepercentagededuction"/>
                            </td>
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name">
                            Exclude ECS Data
                            </td>

                            <td valign="top" class="value">
                                 <g:checkBox name="excludeecsdata" />
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                            Use Member Details to Update Member Comments
                            </td>

                            <td valign="top" class="value">
                                 <g:checkBox name="usememberdetails" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                            Update Member consumer numbers/Donor Id
                            </td>

                            <td valign="top" class="value">
                                 <g:checkBox name="updatedonorid" />
                            </td>
                        </tr>
                          <tr class="prop">
                            <td valign="top" class="name">
                                Select CSV file
                            </td>

                            <td valign="top" class="value">
                                    <input type="file" name="paymentfile" id="paymentfile" />
                            </td>
                        </tr>
                    </tbody>
                    </table>
            </div>
            
             <div class="buttons">                   
                    <span class="button"><g:actionSubmit class="edit" action="dispalyfiledata" value="${message(code: 'dispalyfiledata', 'default': 'Process Data')}" onclick="return confirm('${message(code: 'upload.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
        </g:uploadForm>
        </div>
    </body>
</html>
