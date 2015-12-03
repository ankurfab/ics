<%@ page import="ics.Mb" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ICS : Marriage Board</title>
    <r:require module="mbHome"/>
    <r:layoutResources />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
</head>

<body>

<!-- Navigation -->
<a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i class="fa fa-bars"></i></a>
<a id="navbrand" href="#" class="pull-left"><r:img dir="images" file="mb_logo1.png"/></a>
<nav id="sidebar-wrapper">
    <ul class="sidebar-nav">
        <a id="menu-close" href="#" class="btn btn-light btn-lg pull-right toggle"><i class="fa fa-times"></i></a>
        <li class="sidebar-brand">
            <a href="#"  onclick = $("#menu-close").click(); >ICS MB</a>
        </li>
        <li>
            <a href="${createLink(controller:'Mb',action:'home')}" onclick = $("#menu-close").click(); >Home</a>
        </li>
        <li>
            <a href="${createLink(controller:'Mb',action:'manage')}" onclick = $("#menu-close").click(); >Manage</a>
        </li>
    </ul>
</nav>
<r:img id="bg" dir="images" file="mb_bg.jpg" hidden="hidden"/>
<!-- Top content -->
        <div class="container transback">
            <h3 style="text-align: center;margin: 75px 0 20px"><strong>The following profiles are new and seek your approval. Once approved the respective candidate will be informed via SMS and Mail to edit their profile.</strong></h3>
            <div class="panel-group" id="accordion">
                <g:each in="${profiles}">
                <div class="panel panel-default transback">
                    <div class="panel-heading panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse${it.objId}"><h4><strong>${it.donorName}</strong></h4></a>
                    </div>
                    <div id="collapse${it.objId}" class="panel-collapse collapse">
                        <g:form action="approveProfile" method="post">
                        <div class="panel-body row">
                            <div class="col-sm-8">
                            <p>Legal Name : <strong>${it.donorName}</strong></p>
                            <p>Initiated Name : <strong>${it.initiatedName ? it.initiatedName : '-'}</strong></p>
                            <p>Contact Number : <strong>${it.donorContact}</strong></p>
                            <p>Email Address : <strong>${it.donorEmail}</strong></p>
                            <p>Counsellor / Mentor : <strong>${it.refClor}</strong></p>
                            <p>Referrer Name : <strong>${it.refName}</strong></p>
                            <g:set var="attr" value="${ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','Centre','Config')}" />
                            <g:set var="centres" value="${ics.AttributeValue.findAllByAttribute(attr)?.collect{it.value}}" />
                            <p>Referrer Centre : <g:select name="refCentre" from="${centres}" value="${it.refCentre}"></g:select></p>
                            <p>Referrer Contact Number : <strong>${it.refContact}</strong></p>
                            <p>Referrer Email Address : <strong>${it.refEmail}</strong></p>
                            <p>Relation to Candidate : <strong>${it.refReln}</strong></p>
                            <g:hiddenField name="profId" value="${it.objId}"/>
                            <g:hiddenField name="donorName" value="${it.donorName}"/>
                            <g:hiddenField name="initiatedName" value="${it.initiatedName}"/>
                            <g:hiddenField name="donorContact" value="${it.donorContact}"/>
                            <g:hiddenField name="donorEmail" value="${it.donorEmail}"/>
                            <g:hiddenField name="refClor" value="${it.refClor}"/>
                            <g:hiddenField name="refName" value="${it.refName}"/>
                            <g:hiddenField name="refContact" value="${it.refContact}"/>
                            <g:hiddenField name="refEmail" value="${it.refEmail}"/>
                            <g:hiddenField name="refReln" value="${it.refReln}"/>
                            </div>
                            <div class="col-sm-4">
                                <button type="submit" class="btn btn-success">Approve</button>
                                <a id="saveTempLink" href="javascript:void(0);" onclick="updateTempProfile();" data-profid="${it.objId}" class="btn btn-success" style="margin-left: 20px">Save</a>
                                <g:link action="deleteTempProfile" params="['profId': it.objId,'profDenied': true,'donorName':it.donorName,'donorEmail':it.donorEmail,'donorContact':it.donorContact]" class="btn btn-danger" style="margin-left: 20px">Deny</g:link>
                            </div>
                        </div>
                        </g:form>
                    </div>
                </div>
                </g:each>
            </div>
        </div>
<r:layoutResources />
<script type="text/javascript">
    function updateTempProfile(){
        $.ajax({
            url: "/ics/mb/updateTempProfile?profId="+$('#saveTempLink').data('profid')+"&newCenter="+$('#refCentre').val(),
            type: "POST",
            dataType: "json",
            success: function() {
                window.location.reload();
            }
        }).done(function(){
            window.location.reload();
        });
    }
    $(document).ready(function(){
        $.backstretch($('#bg').attr('src'));
        $("#menu-close").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
        $('.btn-danger').click(function(){
           $(this).addClass('clickedOnce');
        });
        $('.clickedOnce').click(function(){
           return false;
        });
        // Opens the sidebar menu
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
    });
</script>
</body>
</html>