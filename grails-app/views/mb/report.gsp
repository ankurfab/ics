<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>MB Reports</title>
	<r:require module="grid" />
	<r:require module="jqui" />
	<r:require module="newjqplot" />

<style>
nav {background:#FFF;float:left;}
nav ul {text-align:center;}
nav ul li {float:left;display:inline;}
nav ul li:hover {background:#E6E6E6;}
nav ul li a {display:block;padding:15px 25px;color:#444;}
nav ul li ul {position:absolute;width:110px;background:#FFF;}
nav ul li ul li {width:110px;}
nav ul li ul li a {display:block;padding:15px 10px;color:#444;}
nav ul li ul li:hover a {background:#F7F7F7;}
nav ul li ul.fallback {display:none;}
nav ul li:hover ul.fallback {display:block;}
</style>

    </head>

    <body>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'home')}"><g:message code="default.home.label"/></a></span>
        </div>

<nav>
  <ul>
    <li>
      <a href="#">Reports</a>
      <ul class="fallback">
        <li><a class="reportLink" name="workflowStatusReport" href="${createLink(action:'workflowStatusReport',id:1)}">Workflow Status Report</a></li>
        <li><a class="reportLink" name="severityPriorityReport" href="${createLink(action:'severityPriorityReport',id:1)}">Severity Priority Report</a></li>
        <li><a class="reportLink" name="rejectionReasonReport" href="${createLink(action:'rejectionReasonReport',id:1)}">Rejection Reason Report</a></li>
        <li><a class="reportLink" name="varnaCategoryReport" href="${createLink(action:'varnaCategoryReport',id:1)}">Varna Category Report</a></li>
        <li><a class="reportLink" name="candidateSalientFeaturesReport" href="${createLink(action:'candidateSalientFeaturesReport',id:1)}">Candidate Salient Features Report</a></li>
      </ul>
    </li>
    <li>
      <a href="#">Charts</a>
      <ul class="fallback">
        <li><a href="#">Sub-Link 1</a></li>
        <li><a href="#">Sub-Link 2</a></li>
        <li><a href="#">Sub-Link 3</a></li>
        <li><a href="#">Sub-Link 4</a></li>
      </ul>
    </li>
    <li>
      <a href="${createLink(action:'snapshot')}">Snapshots</a>
    </li>
  </ul>
</nav>


        <div class="body">

	    <div id="divSelection">
	    </div>


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

$('nav li ul').hide().removeClass('fallback');
$('nav li').hover(
  function () {
    $('ul', this).stop().slideDown(100);
  },
  function () {
    $('ul', this).stop().slideUp(100);
  }
);
		
        });        	
    </script>

    </body>
</html>