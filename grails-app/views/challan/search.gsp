<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search</title>
    </head>
    <body>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>

        <div class="body">
            <h1>Search</h1>
            <div id="divSearch">
		 <select id="type">
		  <option value="PR">Payment Reference No</option>
		  <option value="P">Donation Receipt No</option>
		</select> 
		Reference: <g:textField id="query" name="query"/>
		<input align="left" class="searchButton" type="submit" value="Search" onclick="search()"/>
		</div>
		
		<div id="divResult">
		</div>
        </div>

    <script type="text/javascript">

        function search() {
		var url = "${createLink(controller:'Challan',action:'search')}"+"?type="+$('#type').val()+"&query="+$('#query').val();
		$("#divResult").load(url);
        }


        	
    </script>

    </body>
</html>