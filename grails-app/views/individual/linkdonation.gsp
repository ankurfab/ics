
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <title>Link Donation</title>
        
	<g:javascript library="jquery" />
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
      <script type="text/javascript">
          $(document).ready(function()
          {
          $('#receiptBook').focus();
         
          })
      </script>
	
    </head>
    <body>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list">Individual List</g:link></span>
            <span class="menuButton"><a class="list" href="${createLink(uri: '/searchIndividual.gsp')}" target= "_blank">SearchIndividual</a></span>
        </div>
        <div class="body">
            <h1>Link Donation</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${ReceiptBookIssued}">
            <div class="errors">
                <g:renderErrors bean="${ReceiptBookIssued}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post">
				<g:hiddenField name="individualId" value="${id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
							<td valign="top" class="name">
								Receipt Book: 
								
							</td>
							<td valign="top" class="name" colspan="5">

								<g:textField name="receiptBook" value="" />
                                    <!--<g:select name="receiptBook.id" from="${ics.ReceiptBook.list()}" optionKey="id" value="${receiptBook?.id}" noSelection="['null': '--Select--']"/>-->
							
							</td>
							</tr>
							<tr class="prop">
							<td valign="top" class="name">
								Receipt: 
							
							</td>
							<td valign="top" class="value">
     
							 <!--
							 <span id="loading_county_drop_down">
							 <img src="style/loader.gif" width="16" height="16" align="absmiddle">&nbsp;Loading...
							 </span>
							
							<div id="receipt_drop_down">
								<g:select name="receipt.id" from="" optionKey="id" value="receipt?.id" />
							</div>
							-->
							<g:textField name="receipt" value="" />
							</td>
							
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="linkdonationupdate" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
            <script language="javascript"> 

	    function populateReceiptsSelectBox(e)
	    {
	    	alert(e);
	    	alert(eval("(" + e.responseText + ")"));
	    	//alert((e.responseText).length);
	    	
	    	var rbs = eval("(" + e.responseText + ")");
	    	//var rbs = e;
	    	alert(rbs);
	    	var rct;
	    	if(rbs)
	    	{
	    		var rselect = document.getElementById('receipt.id');
				// Clear all previous options
				var l = rselect.length

				while (l > 0) { 
				l-- 
				rselect.remove(l) }

				// Rebuild the select 	    	
	    		
				for (var i=0; i < rbs.length; i++) 
					{ 

					rct = rbs[i];

					alert(rct);

					alert(rct.getProperty("id"));
					var opt = document.createElement('option'); 
					opt.text = rct.receiptNumber;
					opt.value = rct.id;
					
					try { 
					rselect.add(opt, null) // standards compliant; doesn't work in IE 

					} catch(ex) { 
					rselect.add(opt) // IE only 
					} 
		
				}
			}
	    }
	    </script>
            
            
        </div>
    </body>
</html>
