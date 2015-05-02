<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>MB Reports</title>
	<r:require module="grid" />
    </head>
    <body>
    
        <div class="nav">
            <span class="menuButton"><g:link class="reportLink" name="workflowStatusReport" id="1">Workflow Status Report</g:link></span>
        </div>

        <div class="body">

	    <div id="divResult">
	    </div>

        </div>


    <script type="text/javascript">
        $(document).ready(function()
        {
		$(".reportLink").click(function (e) 
		{
		    e.preventDefault();
		    var reportName = $(this).attr("name");
		    var url = "${createLink(controller:'Mb',action:'showReportResult')}"+"?reportName="+reportName;
		    $("#divResult").load(url);
		});
        });        	
    </script>

    </body>
</html>