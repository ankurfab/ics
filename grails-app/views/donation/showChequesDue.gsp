
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title>Due Cheques</title>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	<span class="menuButton"><g:link class="create" action="dummydonation">DummyDonation</g:link></span>
            <span class="menuButton"><g:link class="list" controller="donation" action="showChequesDue">DueCheques</g:link></span>
        </div>
        <div class="body">
            <h1>Cheques Due for submission from <g:formatDate format="dd-MM-yyyy" date="${last}" /> till <g:formatDate format="dd-MM-yyyy" date="${now}" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

            <div class="list">
            Cheques Due As per original dates
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'donation.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nvccReceiptBookNo" title="BookNo" />
                        
                            <g:sortableColumn property="nvccReceiptNo" title="ReceiptNo" />
                        
                            <th><g:message code="donation.donatedBy.label" default="Donated By" /></th>
                        
                            <th><g:message code="donation.collectedBy.label" default="Collected By" /></th>
                        
                            <g:sortableColumn property="amount" title="${message(code: 'donation.amount.label', default: 'Amount')}" />
			    <th>ChequeNo</th>
			    <th>ChequeDate</th>
			    <th>ChequeDepositDate</th>
			    <th>Bank</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationDueNowList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td ><g:link action="show" id="${donationInstance.id}">${fieldValue(bean: donationInstance, field: "id")}</g:link></td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "nvccReceiptBookNo")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "nvccReceiptNo")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "donatedBy")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "collectedBy")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "amount")}</td>

			    <td >${donationInstance?.chequeNo}</td>
			    <td ><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>
			    <td ><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDepositDate}" /></td>
			    <td >${donationInstance?.bank?.name}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="list">
            Cheques Due As per revised dates
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'donation.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nvccReceiptBookNo" title="BookNo" />
                        
                            <g:sortableColumn property="nvccReceiptNo" title="ReceiptNo" />
                        
                            <th><g:message code="donation.donatedBy.label" default="Donated By" /></th>
                        
                            <th><g:message code="donation.collectedBy.label" default="Collected By" /></th>
                        
                            <g:sortableColumn property="amount" title="${message(code: 'donation.amount.label', default: 'Amount')}" />
			    <th>ChequeNo</th>
			    <th>ChequeDate</th>
			    <th>ChequeDepositDate</th>
			    <th>Bank</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationDueNowRevisedList}" status="i" var="donationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td ><g:link action="show" id="${donationInstance.id}">${fieldValue(bean: donationInstance, field: "id")}</g:link></td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "nvccReceiptBookNo")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "nvccReceiptNo")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "donatedBy")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "collectedBy")}</td>
                        
                            <td >${fieldValue(bean: donationInstance, field: "amount")}</td>

			    <td >${donationInstance?.chequeNo}</td>
			    <td ><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}" /></td>
			    <td ><g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDepositDate}" /></td>
			    <td >${donationInstance?.bank?.name}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="list">
            PDCs due for conversion
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'donation.id.label', default: 'Id')}" />
                        
                            <th>Donated By</th>
                        
                            <th>Collected By</th>
                        
                            <th>Amount</th>
			    <th>Scheme</th>
			    <th>ChequeNo</th>
			    <th>ChequeDate</th>
			    <th>Bank</th>
			    <th>Branch</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pdcList}" status="i" var="pdcInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td ><g:link controller="pdc" action="show" id="${pdcInstance.id}">${fieldValue(bean: pdcInstance, field: "id")}</g:link></td>
			    <td >${pdcInstance?.issuedBy}</td>
			    <td >${pdcInstance?.receivedBy}</td>
			    <td >${pdcInstance?.amount}</td>
			    <td >${pdcInstance?.scheme}</td>
			    <td >${pdcInstance?.chequeNo}</td>
			    <td ><g:formatDate format="dd-MM-yyyy" date="${pdcInstance?.chequeDate}" /></td>
			    <td >${pdcInstance?.bank?.name}</td>
			    <td >${pdcInstance?.branch}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
