<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Item Sale Report</title>
	<r:require module="jqui" />
    </head>
    <body>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>

        <div class="body">
            <h1>Item Sale Report</h1>
            <div id="divSearch">
            <table>
            	<tr>
            		<td>
            		</td>
            		
            	</tr>
            </table>
		Item: <g:select name="itemid" from="${items}" optionKey="id" optionValue="name" noSelection="['':'-Choose Item-']"/>
		From: <g:textField id="fromDate" name="fromDate"/>
		To: <g:textField id="toDate" name="toDate"/>
		<input align="left" class="searchButton" type="submit" value="Search" onclick="search()"/>
		</div>
		
		<div id="divResult">
		</div>
        </div>

    <script type="text/javascript">
        $(document).ready(function()
        {
	   $("#fromDate").datepicker({yearRange: "-1:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});
	   $("#toDate").datepicker({yearRange: "-1:+0",changeMonth: true,
			changeYear: true,
			dateFormat: 'dd-mm-yy'});

        });

        function search() {
		var url = "${createLink(controller:'Invoice',action:'itemSaleReportResult')}"+"?itemid="+$('#itemid').val()+"&from="+$('#fromDate').val()+"&to="+$('#toDate').val();
		$("#divResult").load(url);
        }


        	
    </script>

    </body>
</html>