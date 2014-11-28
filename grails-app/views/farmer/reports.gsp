
<%@ page import="ics.Farmer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Reports</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="totalLandReport">Total Land Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="irrigatedLandReport">Irrigated Land Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="nonirrigatedLandReport">Non Irrigated Land Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="majorCropReport">Major Crop Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="dairyBusinessReport">Dairy Business Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="wellIrrigationTypeReport">Well Irrigation Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="borewellIrrigationTypeReport">Bore-Well Irrigation Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="canalIrrigationTypeReport">Canal Irrigation Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="liftIrrigationTypeReport">Lift Irrigation Report</g:link></td>                                
                            </tr>
                                                        
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="dripReport">Drip Micro Irrigation Report</g:link></td>                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="value"><g:link action="sprinklerReport">Sprinkler Micro Irrigation Report</g:link></td>                                
                            </tr>
                            
                            
                        </tbody>
                    </table>
	        </div>
        </div>
    </body>
</html>
