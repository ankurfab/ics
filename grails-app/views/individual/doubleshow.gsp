
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">

                <table>
                    <tbody>
                    <tr>
                    <td>
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${individualInstance?.id}" format="#" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value"><g:link controller="title" action="show" id="${individualInstance?.title?.id}">${individualInstance?.title?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Name</td>
                            
                            <td valign="top" class="value">${individualInstance.toString()}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.picFileURL.label" default="Pic File URL" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "picFileURL")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isDonor.label" default="Is Donor" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance?.isDonor}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isWellWisher.label" default="Is Well Wisher" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance?.isWellWisher}" /></td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.dob.label" default="Dob" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance?.dob}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance?.marriageAnniversary}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isMale.label" default="Is Male" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance?.isMale}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.ashram.label" default="Ashram" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "ashram")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.varna.label" default="Varna" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "varna")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.raashi.label" default="Raashi" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "raashi")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.gotra.label" default="Gotra" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "gotra")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nakshatra.label" default="Nakshatra" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nakshatra")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.motherTongue.label" default="Mother Tongue" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "motherTongue")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.languagePreference.label" default="Language Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "languagePreference")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.literatureLanguagePreference.label" default="Literature Language Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "literatureLanguagePreference")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.communicationsPreference.label" default="Communications Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "communicationsPreference")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isLifeMember.label" default="Is Life Member" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance?.isLifeMember}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.membershipNo.label" default="Membership No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "membershipNo")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.membershipPlace.label" default="Membership Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "membershipPlace")}</td>
                            
                        </tr>


                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.profession.label" default="Profession" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "profession")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.designation.label" default="Designation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "designation")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.address.label" default="Address" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.address}" var="a">
                                    <li><g:link controller="address" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.emailContact.label" default="Email Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.emailContact}" var="e">
                                    <li><g:link controller="emailContact" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.voiceContact.label" default="Voice Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.voiceContact}" var="v">
                                    <li><g:link controller="voiceContact" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.otheContact.label" default="Othe Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.otheContact}" var="o">
                                    <li><g:link controller="otherContact" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.remarks.label" default="Remarks" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "remarks")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.businessRemarks.label" default="Business Remarks" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "businessRemarks")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.firstInitiation.label" default="First Initiation" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance?.firstInitiation}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.firstInitiationPlace.label" default="First Initiation Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "firstInitiationPlace")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.secondInitiation.label" default="Second Initiation" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance?.secondInitiation}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.secondInitiationPlace.label" default="Second Initiation Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "secondInitiationPlace")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.individualRoles.label" default="Individual Roles" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.individualRoles}" var="i">
                                    <li><g:link controller="individualRole" action="show" id="${i.id}">${i.role?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Guided By</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.relative1}" var="r">
                                    <li><g:link controller="relationship" action="show" id="${r.id}">${"("+r.relation.toString()+")"+r.individual2?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Guiding</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.relative2}" var="r">
                                    <li><g:link controller="relationship" action="show" id="${r.id}">${"("+r.relation.toString()+")"+r.individual1?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.panNo.label" default="Pan No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "panNo")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.donations.label" default="Donations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.donations}" var="d">
                                    <li><g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.fundCollections.label" default="Fund Collections" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.fundCollections}" var="f">
                                    <li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.giftIssuedBy.label" default="Gift Issued By" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.giftIssuedBy}" var="g">
                                    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g.toString()?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.giftIssuedTo.label" default="Gift Issued To" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.giftIssuedTo}" var="g">
                                    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g.toString()?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.fundsReceived.label" default="Funds Received" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.fundsReceived}" var="f">
                                    <li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.events.label" default="Events" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.events}" var="e">
                                    <li><g:link controller="eventParticipant" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.objectives.label" default="Objectives" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.objectives}" var="o">
                                    <li><g:link controller="objective" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.followupsBy.label" default="Followups By" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.followupsBy}" var="f">
                                    <li><g:link controller="followup" action="show" id="${f.id}">${f.followupWith?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.followupsWith.label" default="Followups With" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance.followupsWith}" var="f">
                                    <li><g:link controller="followup" action="show" id="${f.id}">${f.followupBy?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccId.label" default="Nvcc Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccId")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccDonarCode.label" default="Nvcc Donar Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccDonarCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccName.label" default="Nvcc Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccIskconRef.label" default="Nvcc Iskcon Ref" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccIskconRef")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccFamilyId.label" default="Nvcc Family Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccFamilyId")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccRelation.label" default="Nvcc Relation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance, field: "nvccRelation")}</td>
                            
                        </tr>
                    
                    
                    </tbody>
                </table>
                </td>
                <td>
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${individualInstance2?.id}" format="#" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value"><g:link controller="title" action="show" id="${individualInstance2?.title?.id}">${individualInstance2?.title?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Name</td>
                            
                            <td valign="top" class="value">${individualInstance2.toString()}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.picFileURL.label" default="Pic File URL" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "picFileURL")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isDonor.label" default="Is Donor" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance2?.isDonor}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isWellWisher.label" default="Is Well Wisher" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance2?.isWellWisher}" /></td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.dob.label" default="Dob" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance2?.dob}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.marriageAnniversary.label" default="Marriage Anniversary" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance2?.marriageAnniversary}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isMale.label" default="Is Male" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance2?.isMale}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.ashram.label" default="Ashram" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "ashram")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.varna.label" default="Varna" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "varna")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.raashi.label" default="Raashi" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "raashi")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.gotra.label" default="Gotra" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "gotra")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nakshatra.label" default="Nakshatra" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nakshatra")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.motherTongue.label" default="Mother Tongue" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "motherTongue")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.languagePreference.label" default="Language Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "languagePreference")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.literatureLanguagePreference.label" default="Literature Language Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "literatureLanguagePreference")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.communicationsPreference.label" default="Communications Preference" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "communicationsPreference")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.isLifeMember.label" default="Is Life Member" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${individualInstance2?.isLifeMember}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.membershipNo.label" default="Membership No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "membershipNo")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.membershipPlace.label" default="Membership Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "membershipPlace")}</td>
                            
                        </tr>


                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.profession.label" default="Profession" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "profession")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.designation.label" default="Designation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "designation")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.address.label" default="Address" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.address}" var="a">
                                    <li><g:link controller="address" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.emailContact.label" default="Email Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.emailContact}" var="e">
                                    <li><g:link controller="emailContact" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.voiceContact.label" default="Voice Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.voiceContact}" var="v">
                                    <li><g:link controller="voiceContact" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.otheContact.label" default="Othe Contact" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.otheContact}" var="o">
                                    <li><g:link controller="otherContact" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.remarks.label" default="Remarks" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "remarks")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.businessRemarks.label" default="Business Remarks" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "businessRemarks")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.firstInitiation.label" default="First Initiation" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance2?.firstInitiation}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.firstInitiationPlace.label" default="First Initiation Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "firstInitiationPlace")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.secondInitiation.label" default="Second Initiation" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${individualInstance2?.secondInitiation}" /></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.secondInitiationPlace.label" default="Second Initiation Place" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "secondInitiationPlace")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.individualRoles.label" default="Individual Roles" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.individualRoles}" var="i">
                                    <li><g:link controller="individualRole" action="show" id="${i.id}">${i.role?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Guided By</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.relative1}" var="r">
                                    <li><g:link controller="relationship" action="show" id="${r.id}">${"("+r.relation.toString()+")"+r.individual2?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Guiding</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.relative2}" var="r">
                                    <li><g:link controller="relationship" action="show" id="${r.id}">${"("+r.relation.toString()+")"+r.individual1?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.panNo.label" default="Pan No" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "panNo")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.donations.label" default="Donations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.donations}" var="d">
                                    <li><g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.fundCollections.label" default="Fund Collections" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.fundCollections}" var="f">
                                    <li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.giftIssuedBy.label" default="Gift Issued By" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.giftIssuedBy}" var="g">
                                    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g.toString()?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.giftIssuedTo.label" default="Gift Issued To" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.giftIssuedTo}" var="g">
                                    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g.toString()?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.fundsReceived.label" default="Funds Received" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.fundsReceived}" var="f">
                                    <li><g:link controller="donation" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.events.label" default="Events" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.events}" var="e">
                                    <li><g:link controller="eventParticipant" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.objectives.label" default="Objectives" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.objectives}" var="o">
                                    <li><g:link controller="objective" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.followupsBy.label" default="Followups By" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.followupsBy}" var="f">
                                    <li><g:link controller="followup" action="show" id="${f.id}">${f.followupWith?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.followupsWith.label" default="Followups With" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${individualInstance2.followupsWith}" var="f">
                                    <li><g:link controller="followup" action="show" id="${f.id}">${f.followupBy?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccId.label" default="Nvcc Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccId")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccDonarCode.label" default="Nvcc Donar Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccDonarCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccName.label" default="Nvcc Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccIskconRef.label" default="Nvcc Iskcon Ref" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccIskconRef")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccFamilyId.label" default="Nvcc Family Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccFamilyId")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individual.nvccRelation.label" default="Nvcc Relation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualInstance2, field: "nvccRelation")}</td>
                            
                        </tr>
                    
                    
                    </tbody>
                </table>
                </td>
                </tr>
                </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${individualInstance?.id}" />
                    <g:hiddenField name="id2" value="${individualInstance2?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="merge" value="Merge" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
