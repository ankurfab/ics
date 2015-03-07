
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Dashboard For ${clor} </title>
	<r:require module="jqui" />
	<r:require module="newjqplot" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>Dandavats HG ${clor} <g:if test="${clor?.isMale}">Prabhuji</g:if><g:else>Mataji</g:else></h1>
            <h2>More Devotees! Happy Devotees!!</h2>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

            <sec:ifAnyGranted roles="ROLE_COUNSELLOR_ADMIN">
		<g:form controller="helper" action="clorDashboard" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Counselor
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="clorid"
				              from="${ics.IndividualRole.findAllByRoleAndStatus(ics.Role.findByName('PuneLeadCouncellors'),'VALID',[sort: "individual.initiatedName"])?.collect{it.individual}}"
				              noSelection="['':'-Choose Counselor-']"
				              optionKey="id" optionValue="initiatedName"
				              value=""/>
                                </td>
                            </tr>                                                
                        </tbody>
                    </table>
                </div>                
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="GenerateDashboard" /></span>
                </div>
            </g:form>
            </sec:ifAnyGranted>


		<div id="accordian">
		    <div id="reg">
				<div id="chartPrjiMataji" style="height:300px; width:400px;float:left;"></div>
				<div id="chartInStationOutStation" style="height:300px; width:400px;float:left;"></div>
		    </div>
		    <div id="summ">
				<div id="chartSummBooks" style="height:300px; width:1200px;float:left;"></div>
				<div id="chartSummContribution" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		</div>
		
        </div>
        <div>

	    <div id="divEvents">
	    	<g:render template="eventSummary"/>
	    </div>

	<!--
	    <div id="divStats" style="margin-top:20px; width:600px; height:200px;float:left;">	    	
	    	<g:render template="clorSummary"/>
	    </div>
	    <div id="divDonations" style="margin-top:20px; width:600px; height:200px;float:left;">
	    	<g:render template="donationSummary"/>
	    </div>
	    <div id="divBD" style="margin-top:20px; width:600px; height:200px;float:left;">
	    	<g:render template="bdSummary"/>
	    </div>
	    <div id="divMeetings" style="margin-top:20px; width:400px; height:200px;float:left;">
	    	<g:render template="meetingSummary"/>
	    </div>
	-->

	</div>        
	
	<script>

		$(document).ready(function(){

	  $( "#accordion" ).accordion();
	  var ajaxDataRenderer = function(url, plot, options) {
	    var ret = null;
	    $.ajax({
	      // have to use synchronous here, else the function
	      // will return before the data is fetched
	      async: false,
	      url: url,
	      dataType:"json",
	      success: function(data) {
		ret = data;
	      }
	    });
	    return ret;
	  };

	var jsonurl_chartPrjiMataji = "${createLink(controller:'Helper',action:'clorSummaryData')}"+"?clorid="+${clor.id};
    var plot_chartRegSumm = $.jqplot('chartPrjiMataji', jsonurl_chartPrjiMataji, {
	title: "Prabhuji/Mataji",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartPrjiMataji
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            placement: 'outside', 
            rendererOptions: {
                numberRows: 1
            }, 
            location:'s',
            marginTop: '15px'
        } 
        });      

	  var jsonurl_chartInStationOutStation = "${createLink(controller:'Helper',action:'clorIndividualData')}"+"?clorid="+${clor.id};
	  var plot2 = $.jqplot('chartInStationOutStation', jsonurl_chartInStationOutStation,{
		    title: "In-station / Out-station",
		    dataRenderer: ajaxDataRenderer,
		    dataRendererOptions: {
		      unusedOptionalUrl: jsonurl_chartInStationOutStation
		    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            placement: 'outside', 
            rendererOptions: {
                numberRows: 1
            }, 
            location:'s',
            marginTop: '15px'
        } 
	  });

	var jsonurl_chartSummBooks = "${createLink(controller:'Helper',action:'clorBookDistributionData')}"+"?clorid="+${clor.id};;
        var plot_chartSumm = $.jqplot('chartSummBooks',jsonurl_chartSummBooks , {
	    title: "2014 Book Distribution",
	    stackSeries: false,
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartSummBooks
	    },
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
            },
		series:[
		    {label:'SmallBooks'},
		    {label:'MediumBooks'},
		    {label:'BigBooks'},
		    {label:'MahaBigBooks'}
		],
		legend: {
		    show: false,
		    location: 'n',
		    placement: 'insideGrid'
		},		    
            axes: {
		    xaxis: {
			renderer: $.jqplot.CategoryAxisRenderer,
		    }                                
            }
        });

	var jsonurl_chartSummContribution = "${createLink(controller:'Helper',action:'clorDonationData')}"+"?clorid="+${clor.id};;
        var plot_chartSumm = $.jqplot('chartSummContribution',jsonurl_chartSummContribution , {
	    title: "Overall Funds Contribution",
	    stackSeries: false,
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartSummContribution
	    },
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true, location: 'e', edgeTolerance: -15, stackedValue: false },
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'vertical'
                }
            },
            axes: {
		    xaxis: {
			renderer: $.jqplot.CategoryAxisRenderer,
		    }                
            }
        });


		});

	</script>



    </body>
</html>
