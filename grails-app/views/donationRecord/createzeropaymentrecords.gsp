
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.list" default="Create Zero donation records" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="create" action="uploadpaymentdata"><g:message code="donationRecord.upload" default="DonationRecord Upload" /></g:link></span>

                 <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
            </sec:ifAnyGranted>
        </div>
        <div class="body">
          <r:require module="jqui" />
        <script type="text/javascript">
         $(document).ready(function()
            {
                $("#donationDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
               
            })
        </script>
            <h1><g:message code="donationRecord.zeropayment" default="Create Zero donation records" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            
            <g:form method="post" >
            <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
                            Select Scheme
                        </td>
                        <td valign="top" class="value">
                             <g:select name="scheme" from="${schemes}" optionKey="id"   />
                        </td>
                        </tr>

                       <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donationDate"><g:message code="donationRecord.donationDate" default="Donation Date" />:</label>
                                </td>
                                <td valign="top" class="value">
                                    
                                      <g:textField name="donationDate" />  
                                </td>
                        </tr>
                        
                    </tbody>
                    </table>
            </div>
            
             <div class="buttons">                   
                    <span class="button"><g:actionSubmit class="create" action="fetchrecordsforzeropayment" value="${message(code: 'fetchrecordsforzeropayment', 'default': 'Find Records In Selected Month For Which No Donation Record is There')}" onclick="return confirm('${message(code: 'upload.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
