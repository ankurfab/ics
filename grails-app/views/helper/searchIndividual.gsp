
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search individuals</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="individual">List</g:link></span>
            <span class="menuButton"><g:link class="list" action="searchIndividualByRole" controller="helper">SearchIndividualByRole</g:link></span>
            <span class="menuButton"><g:link class="list" action="index" controller="searchable">FuzzySearch</g:link></span>
        </div>
        <div class="body" width="40%">
            <h1>Search individuals</h1>
            <g:form controller='individual' action="genericsearch" method="post" >
              <g:hiddenField name="ExactSearch" value="Like" />
                <div class="dialog">
			<g:radioGroup name="searchon" labels="['Name','Address','Email','Phone','NVCC Code']" values="[1,2,3,4,5]" value="1" >
			<table border ="0">
                        <tbody>
                            <tr>
                                <td valign="left" class="name" width="30%">
									${it.label}
                                </td>
                                <td valign="left" class="name">
									${it.radio}
                                </td>
                            </tr>
							<g:if test="${it.label=='Name'}">
							<tr>
								<td>
									<label for="name">Only Donors </label>
								</td>
								<td>
									<g:checkBox name="SearchDonors" />
								</td>

							</tr>
							</g:if>
                        	
                        </tbody>
                    </table>
					
			</g:radioGroup>
			<table border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                        
                            <tr>
                                <td valign="middle" class="name" width="27%">
                                    <label for="name">Search for</label>
                                </td>
                                <td valign="middle" class="value" width="22%">
                                	Exact <g:checkBox name="ExactSearch1" onClick="checkExact() "  />
                                </td>
                                <td valign="middle" class="value" width="150px">
                                    <g:textField name="query" value=""/>
                                </td>
                            </tr>
                           
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="save" value="Search" /></span>
                </div>
            </g:form>
        </div>
        <script language="javascript"> 
         function checkExact() {
		    	    	var cb = document.getElementById('ExactSearch1');
		    	    	
		    		var flag = document.getElementById('ExactSearch');
		    	    	if (cb.checked)
		    	    	{
		    	    		
		    	    		flag.value = "Exact";
		    	    	}
		    	    	else
		    	    		{
		    	    		
		    	    		flag.value = "Like";
		    	    		}
		    	    } 
	</script>
    </body>
</html>
