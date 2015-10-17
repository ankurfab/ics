
<%@ page import="ics.IndividualDepartment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Payroll for ${currentMonth}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>Payroll for ${currentMonth}</h1>

		<g:form name="formPayroll" controller="IndividualDepartment" action="processPayroll" method="post" >

		<g:set var="totalBaseSalary" value="${0}" />
		<g:set var="totalSalaryDeduction" value="${0}" />
		<g:set var="totalLoanInstallment" value="${0}" />
		<g:set var="totalNetSalary" value="${0}" />

		<div>
			<table class="details" border="1">
				<thead>
					<th>S.No.</th>
					<th>Name</th>
					<th>BaseSalary</th>
					<th>Deduction</th>
					<th>LoanInstallment</th>
					<th>NetSalary</th>
				</thead>
				<g:each var="indDep" in="${indDepList}" status="sno">
				<tr>
					<td>${sno+1}</td>
					<td>${indDep?.individual}</td>
					<td id="${'baseSalary_'+indDep.id}">${indDep.salary}</td>
					<td><g:textField class="deduction" name="${'deduction_'+indDep.id}" value="0"/></td>
					<g:set var="loan" value="${ics.Loan.findByLoanedByAndStatusAndCategory(indDep.individual,'OPEN','DEPARTMENT')}" />
					<g:set var="loanInstallment" value="${loan?(new Double(loan.amount/loan.numInstallments)?.round(0)):0}" />
					<td id="${'loanInstallment_'+indDep.id}">${loanInstallment}</td>
					<td id="${'netSalary_'+indDep.id}">${indDep.salary-loanInstallment}</td>
				</tr>
				<g:set var="totalBaseSalary" value="${totalBaseSalary+indDep.salary}" />
				<g:set var="totalLoanInstallment" value="${totalLoanInstallment+loanInstallment}" />
				<g:set var="totalNetSalary" value="${totalBaseSalary-totalLoanInstallment}" />
				</g:each>
				<tr class="sum">
					<td></td>
					<td>Total</td>
					<td id="totalBaseSalary">${totalBaseSalary}</td>
					<td id="salaryDeductionTotal">${totalSalaryDeduction}</td>
					<td id="totalLoanInstallment">${totalLoanInstallment}</td>
					<td id="netSalaryTotal">${totalNetSalary}</td>
				</tr>

			</table>
		</div>

		</g:form>

        </div>

<script type="text/javascript">
  jQuery(document).ready(function () {

	$( ".deduction" ).change(function(event) {
		var elementId = event.target.id;
		var cliId = elementId.split('_')[1];
		//alert( "Handler for .change() called for CLI:"+cliId );
		  var baseSalary = $('#baseSalary_'+cliId).html();
		  var loanInstallment = $('#loanInstallment_'+cliId).html();
		  var deduction = $('#deduction_'+cliId).val();
		  var netSalary = baseSalary-loanInstallment-deduction;
		  //change value
		  $('#netSalary_'+cliId).html(netSalary);
		  
		  //update totals
		  var table = $('#details');
		  var totalDeduction = calculateInputSum('.deduction');
		  $('#salaryDeductionTotal').html(totalDeduction);
		  var totalNetSalary = $('#totalBaseSalary').html() - $('#totalLoanInstallment').html() - totalDeduction
		  $('#netSalaryTotal').html(totalNetSalary);

	});


function sumOfColumns(table, columnIndex) {
    var tot = 0;
    table.find("tr").children("td:nth-child(" + columnIndex + ")")
    .each(function() {
        $this = $(this);
        alert($this);
        if (!$this.hasClass("sum") && $this.html() != "") {
            alert($this.html());
            tot += parseInt($this.html());
        }
    });
    return tot;
}

function calculateSum(cls) {
    var tot = 0;
	$(cls).each(function(i, obj) {
        if ($(this).html() != "") {
            //alert($this.html());
            tot += parseInt($(this).html());
        	}
	});
    return tot;
}

function calculateInputSum(cls) {
    var tot = 0;
	$(cls).each(function(i, obj) {
        if ($(this).val() != "") {
            tot += parseInt($(this).val());
        	}
	});
    return tot;
}

    });
</script>

    </body>
</html>

