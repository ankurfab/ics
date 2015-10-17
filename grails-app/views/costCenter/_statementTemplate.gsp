            <div class="list">
            	<table>
                	<tr>
                	<td>
                	<b>Between: ${fd.format("dd-MM-yy")} and ${td.format("dd-MM-yy")}</b>
                	</td>
                	</tr>
                </table>
                </div>
	    	    	    		
	<br>
	<g:set var="balance" value="${balance}" />
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th>CC</th>
                            <th>Date</th>
                            <th>Reference</th>
                            <th>Details</th>
                            <th>Phone</th>
                            <th>Email</th>
			    <th>Income</th>                            
                            <th>Expense</th>
                            <th>Balance</th>
                            <th>EntryBy</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${records}" status="i" var="record">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${record.ccname}</td>
                            <td>${record.date?.format('dd-MM-yyyy')}</td>
                            <td>${record.ref}</td>
                            <td>${record.details}</td>
                            <td>${record.contact}</td>
                            <td>${record.email}</td>
							<g:set var="incomeVal" value="${record?.income?:0}"/>
                            <td>${incomeVal}</td>
							<g:set var="expenseVal" value="${record?.expense?:0}"/>
                            <td>${expenseVal}</td>
                            <g:set var="balance" value="${balance + (record?.income?:0) - (record?.expense?:0)}" />
                            <td>${balance}</td>
                            <td>${record.entryby}</td>
                        </tr>
                    </g:each>                    
                    </tbody>
					<tr>
						<td colspan="6"><b>Total</b></td>
						<td><b>${totalIncome}</b></td>
						<td><b>${totalExpense}</b></td>
						<g:set var="finalBalance" value="${totalIncome- totalExpense}"/>
						<td><b>${finalBalance}</b></td>
					</tr>
                </table>
            </div>