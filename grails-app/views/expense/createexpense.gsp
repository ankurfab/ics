
<%@ page import="ics.Expense" %>
<!doctype html>
<html>
    <head>
        <title> Create Expense </title>
        <meta name="layout" content="main-jqm-landing">
    <g:form name="createExpenseForm" id="createExpenseForm" controller="Expense"  action="createexpense"  method="POST"> 
        <table>
            <legend>Create Expense</legend>
            <fieldset> 
               

                <tr>
                    <td><label>Project:</label></td> 
                    <td> 
                        <select name="project" id="project" value="Accounting">
                            <option>Financial</option>
                            <option>Insurance</option>
                            <option>Health</option>
                        </select>

                    </td>
                </tr>

                <tr>
                    <td> <label>Type:</label> </td>         
                    <td> <input type="text"  id="type" name="type" value=""  placeholder="type" required></td>
                </tr>

                <tr>
                    <td><label>Category:</label></td>          
                    <td><input  type="text"  id="category" name="category" value=""  placeholder="category" required></td>
                </tr>


                <tr>
                    <td><label>Description:</label></td>          
                    <td><textarea cols="40" rows="8" name="description" id="description"  placeholder="description" ></textarea></td>
                </tr>

                <tr>
                    <td><label>Amount:</label></td>          
                    <td><input type="text"  id="amount" name="amount" value="" placeholder="amount" required></td>
                </tr>

                <tr>
                    <td><label>ExpenseDate:</label></td>          
                    <td><input type="text" data-role="date" name="expenseDate" class="datepicker" value=""  placeholder="expenseDate" ></td>
                </tr>

                <tr>
                <div data-role="controlgroup"  data-type="horizontal" data-theme="b"> 
                    <td>  </td>
                    <td> <button class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-check" id="createexpensesubmitbutton" type="submit">Submit</button> 
                        <button  id="cancel" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-delete" data-rel="back" type="reset">Cancel</button> </td>
                </div>
                </tr>
            </fieldset>
        </table>  
    </g:form>  
    <script>
    //code to select the date
        $('.datepicker').on("click", function(event, ui)
        {
            $('.datepicker').each(function() {
                $(this).datepicker({
                    format: "dd-mm-yy",
                    yearRange: '1910:2050',
                    todayBtn: true,
                    calendarWeeks: true,
                    todayHighlight: true,
                    changeDate: true,
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function(dateText, inst)
                    {
                    }
                });
            });
        });
    </script>
</body>            
</html>







