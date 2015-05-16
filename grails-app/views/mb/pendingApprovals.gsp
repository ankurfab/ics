<%@ page import="ics.Mb" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ICS : Marriage Board</title>
    <r:require module="mbHome"/>
    <r:layoutResources />
</head>
<body>
<r:img id="bg" dir="images" file="1.jpg" hidden="hidden"/>
<nav class="navbar navbar-inverse navbar-no-bg" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand"></div>
        </div>
        <h3 class="site-head hidden-xs hidden-sm">ISKCON Community Services : Marriage Board</h3>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="top-navbar-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#">Tutorials</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Top content -->
<div class="top-content">
    <div class="inner-bg">
        <div class="container">
            <h3 style="text-align: center;color: black;margin: -30px 0 40px 0"><strong>The Following Profiles are new and Seek your approval. Once approved the repective candidate will be informed via SMS and Mail to edit their profile.</strong></h3>
            <div class="panel-group" id="accordion">
                <g:each in="${profiles}">
                <div class="panel panel-default">
                    <div class="panel-heading panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse${it.objId}"><h4>${it.donorName}</h4></a>
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
                            <p>Referrer Centre : <strong>${it.refCentre}</strong></p>
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
                            <g:hiddenField name="refCentre" value="${it.refCentre}"/>
                            <g:hiddenField name="refContact" value="${it.refContact}"/>
                            <g:hiddenField name="refEmail" value="${it.refEmail}"/>
                            <g:hiddenField name="refReln" value="${it.refReln}"/>
                            </div>
                            <div class="col-sm-4">
                                <button type="submit" class="btn btn-success">Approve</button>
                                <a href="/ics/mb/deleteTempProfile?profId=${it.objId}" class="btn btn-danger" style="margin-left: 20px">Deny</a>
                            </div>
                        </div>
                        </g:form>
                    </div>
                </div>
                </g:each>
            </div>
        </div>
    </div>
</div>
<r:layoutResources />
<script type="text/javascript">
    $(document).ready(function(){
        $('#approveProfile').click(function(){
            $.ajax({

            });
        })
    });
</script>
</body>
</html>