
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Compare Two Individuals</title>
    </head>
    <body>
        <div class="body">
            <h1>Compare Two Individuals</h1>
            <g:form controller='individual' action="doubleshow" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="id">Individual1:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="id" value="" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="id2">Individual2:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="id2" value="" />
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
    </body>
</html>
