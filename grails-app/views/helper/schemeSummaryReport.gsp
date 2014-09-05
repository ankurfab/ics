
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.show" default="SchemeMember Report" /></title>
      <r:require module="jqui" />
    <r:require module="newjqplot" />
     <r:require module="export"/>    
        <export:resource />




    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
                      
        </div>
        <div class="body">
            <h1><g:message code="schemeMember.show" default="SchemeMember Report" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div id="summarymember" style="float:right;padding:10px 10px;margin:10px 50px;border:1px solid;">
            <g:message code="schemeMember.summarydetails" default="Member Summary Details" />
            <hr>
                <g:each in="${membersummary}" var="item">
                <div id="summaryrow" style="margin:5px;border:1px none">
                 ${item[0]} are  ${item[1]}
                 </div>
                </br>
                </g:each>
            </div>
            <div id="summaryconcern" style="float:right;padding:10px 10px;margin:10px 50px;border:1px solid;">
            <g:message code="schemeMember.summarydetails" default="Concern Summary Details" />
            <hr>
                <g:each in="${concernssummary}" var="item">
                <div id="summaryrow" style="margin:5px;border:1px none">
                 ${item[0]} are  ${item[1]}
                 </div>
                </br>
                </g:each>
            </div>
            <div id="summarycenter" style="float:right;padding:10px 10px;margin:10px 50px;border:1px solid;">
            <g:message code="schemeMember.summarydetails" default="Center Summary Details" />
            <hr>
                <g:each in="${centersummary}" var="item">
                <div id="summaryrow" style="margin:5px;border:1px none">
                 ${item[0]} are  ${item[1]}
                 </div>
                </br>
                </g:each>
            </div>
            <div style="clear:both"></div>
             <div class="buttons">
                    <span class="button"><input type="button" class="export" id="exportimagebutton" value="${message(code: 'export', 'default': 'Export As Image')}" /></span>                                       
             </div>
             <export:formats formats="['excel','csv','pdf','rtf']" controller="helper" action="schemeTotalMemberSummaryReportAsCVS" />

             <div id="chart2" style="margin-top:20px; width:1200px; height:700px;float:left;"></div>
             <div style="clear:both"></div>

             <div id="exportedimage" title="Save the Report">
              <div id="imgChart2" style="margin-top:20px; width:1200px; height:700px;float:right;"></div>
              
             </div>

        </div>
        <script type="text/javascript" language="javascript">

    $(document).ready(function(){
      

     $.jqplot.config.enablePlugins = true;

    plot2 = $.jqplot('chart2', [${memberscount},${membersprofileCompleteCount}], {
        stackSeries: true,
        highlightMouseOver:true,

        legend: {
        show: true,
        labels:['Total Active,IRegular,Resumed Members','Total Profile Complete'],
         placement: 'insideGrid', 
         rendererOptions: {
            numberRows: 1
        },
        location: 'nw',
        xoffset: 0
        },
        title: 'Center wise member Report',
        color: '#ffffff',
        seriesDefaults: {
        renderer: $.jqplot.BarRenderer,
        pointLabels: { show: true, location: 'n', edgeTolerance: -15 },
        
        rendererOptions: {
            barPadding: 10,
            barMargin: 10,
            fillToZero: true
        }
        },
        cursor:{
          showVerticalLine:true,
          showTooltip: true,
          followMouse: true,
          showTooltipDataPosition:true,
          zoom:true,
          intersectionThreshold:6,
          tooltipFormatString: '%s x:%s, y:%s'
        },
        series: [{
        label: 'centers'
        }],
       
        axes: {
        xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            label: 'Center',
            ticks: ${centers},
            showMinorTicks:true,
            labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
            tickRenderer: $.jqplot.CanvasAxisTickRenderer,
            tickOptions: {
              // labelPosition: 'middle',
              angle: 30
            }

        },
        yaxis: {min:0, label: 'Total Members', tickInterval:${maxmembercount}, showMinorTicks:true}
        }
    });
       

      

      $( "#exportedimage" ).dialog({
        height: 740,
        width:1260,
        modal: true,
        autoOpen:false
        });

        $("#exportimagebutton").click(function(){
            $( "#exportedimage" ).dialog("open");
            var imgData = $('#chart2').jqplotToImageStr({}); // given the div id of your plot, get the img data
            var imgElem = $('<img/>').attr('src',imgData); // create an img and add the data to it
            $('#imgChart2').empty();
            $('#imgChart2').append(imgElem);
        });

       
        
        

    });
</script>
    </body>
</html>
