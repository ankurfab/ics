
<%@ page import="ics.Mb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Snapshot Charts </title>
	<r:require module="jqui" />
	<r:require module="newjqplot" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">

		<g:set var="attr" value="${ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','Centre','Config')}" />
		<g:set var="centres" value="${ics.AttributeValue.findAllByAttribute(attr,[sort:'value'])?.collect{it.value}}" />

		<g:form controller="mb" action="snapshot" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Centre
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="centre"
				              from="${centres}"
				              noSelection="['':'-Choose Centre-']" value="${centre}"/>
                                </td>
                            </tr>                                                
                        </tbody>
                    </table>
                </div>                
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="GenerateDashboard" /></span>
                </div>
            </g:form>


		<div id="accordian">
		    <div>
				<div id="chartPrjiMataji" style="height:300px; width:400px;float:left;"></div>
				<div id="chartVarna" style="height:300px; width:400px;float:left;"></div>
		    </div>
		    <div>
				<div id="chartCategory" style="height:300px; width:1200px;float:left;"></div>
				<div id="chartCulture" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		    <div>
				<div id="chartEducation" style="height:300px; width:1200px;float:left;"></div>
				<div id="chartIncome" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		    <div>
				<div id="chartSpiritualMaster" style="height:300px; width:1200px;float:left;"></div>
				<div id="chartWorkflowStatus" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		    <div>
				<div id="chartStage" style="height:300px; width:1200px;float:left;"></div>
				<div id="chartMarriageStatus" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		</div>
		
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

	var jsonurl_chartPrjiMataji = "${createLink(controller:'Mb',action:'genderwiseReport')}"+"?centre=${centre}";
    var plot_chartPrjiMataji = $.jqplot('chartPrjiMataji', jsonurl_chartPrjiMataji, {
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
            location:'s',
        } 
        });      

	var jsonurl_chartVarna = "${createLink(controller:'Mb',action:'candidateAttributeReport')}"+"?centre=${centre}&attribute=varna";
    var plot_chartVarna = $.jqplot('chartVarna', jsonurl_chartVarna, {
	title: "Varna",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartVarna
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartCategory = "${createLink(controller:'Mb',action:'mbProfileAttributeReport')}"+"?centre=${centre}&attribute=scstCategory";
    var plot_chartCategory = $.jqplot('chartCategory', jsonurl_chartCategory, {
	title: "Candidate Category",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartCategory
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartCulture = "${createLink(controller:'Mb',action:'mbProfileAttributeReport')}"+"?centre=${centre}&attribute=devotionalCulture";
    var plot_chartCulture = $.jqplot('chartCulture', jsonurl_chartCulture, {
	title: "Culture",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartCulture
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartEducation = "${createLink(controller:'Mb',action:'candidateAttributeReport')}"+"?centre=${centre}&attribute=eduCat";
    var plot_chartEducation = $.jqplot('chartEducation', jsonurl_chartEducation, {
	title: "Education",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartEducation
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartIncome = "${createLink(controller:'Mb',action:'candidateAttributeReport')}"+"?centre=${centre}&attribute=income";
    var plot_chartIncome = $.jqplot('chartIncome', jsonurl_chartIncome, {
	title: "Income",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartIncome
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartSpiritualMaster = "${createLink(controller:'Mb',action:'mbProfileAttributeReport')}"+"?centre=${centre}&attribute=spiritualMaster";
    var plot_chartSpiritualMaster = $.jqplot('chartSpiritualMaster', jsonurl_chartSpiritualMaster, {
	title: "Spiritual Master",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartSpiritualMaster
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      

	var jsonurl_chartWorkflowStatus = "${createLink(controller:'Mb',action:'mbProfileAttributeReport')}"+"?centre=${centre}&attribute=workflowStatus";
    var plot_chartWorkflowStatus = $.jqplot('chartWorkflowStatus', jsonurl_chartWorkflowStatus, {
	title: "Workflow Status",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartWorkflowStatus
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
        },
        legend:{
            show:true, 
            location:'s',
        } 
        });      




		});

	</script>



    </body>
</html>
