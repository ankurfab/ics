
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
            <h1><g:message code="schemeMember.show" default="SchemeMember Donation Report" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form  action="schemeDonationRecordReport" >
            <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
                         From Date
                        </td>
                        <td valign="top" class="value">
                                 <g:textField name="startDate" value="${startDate}" />    
                                  Prior Months
                                  <g:select id="numberofmonths" name="numberofmonths" from="${['1','2','3','4']}" keys="${['1','2','3','4']}" value="${numberofmonths}"  /> 
                        </td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                           To Date
                            </td>

                            <td valign="top" class="value">
                                     <g:textField name="endDate" value="${endDate}"/>    
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">
                                Centre (not applicable for exporting Data)
                            </td>

                            <td valign="top" class="value">
                                     <g:select id="centre_id" name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${centre?.id}" noSelection="['0': 'ALL']"  />
                            </td>
                        </tr>

                    </tbody>
                    </table>
            </div>
            
             <div class="buttons">                   
                    <span class="button"><input type="submit" class="edit"value="${message(code: 'schemeDonationRecordReport', 'default': 'Load Report')}"  /></span>
                </div>
        </g:form>

            <div style="clear:both"></div>
            
             <div class="buttons">
                    <span class="button"><input type="button" class="export" id="exportimagebutton2" value="${message(code: 'export', 'default': 'Export As Image')}" /></span>  
             </div>
              <export:formats formats="['excel','csv','pdf','rtf']" controller="helper" action="schemeDonationRecordReportAsCVS" params="['startDate':startDate, 'endDate':endDate]"/>

             <div id="chart3" style="margin-top:20px; width:1200px; height:700px;float:left;"></div>
             <div style="clear:both"></div>
             <div id="chart4" style="margin-top:20px; width:1200px; height:500px;float:left;"></div>
             <div style="clear:both"></div>
             <div id="chart5" style="margin-top:20px; width:1200px; height:700px;float:left;"></div>
             <div style="clear:both"></div>
             <div class="buttons">
                    <span class="button"><input type="button" class="export" id="exportimagebutton3" value="${message(code: 'export', 'default': 'Export Above As Image')}" /></span>  
             </div>
             <div style="clear:both"></div>
             <div id="exportedimage" title="Save the Report">
              <div id="imgChart2" style="margin-top:20px; width:1200px; height:1400px;float:right;"></div>
              
             </div>
             <div id="exportedimage3" title="Save Summary Report">
              <div id="imgChart3" style="margin-top:20px; width:1200px; height:300px;float:right;"></div>
             </div>

        </div>
        <script type="text/javascript" language="javascript">

         $(document).ready(function(){

               $("#startDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                $("#endDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});

     var plot_totaldonationsReport = $.jqplot('chart5',[${collecteddonations}] , {
        title: '${title3}',
        stackSeries: false,
        
       
        series:{
                fillColor: "#CC0066",
        },
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true, location: 'n', edgeTolerance: -15 },
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'vertical',
                     barMargin: 30,
                     highlightMouseDown: true 
                }
            },
             
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    label: 'Month-Year',
                    showMinorTicks:true,
                     ticks: ${montharray},
                      labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        tickOptions: {
                          // labelPosition: 'middle',
                          angle: 30
                        }
                },
                 yaxis: {min:0, label: 'Total Donation', tickInterval:${maxTotaldonation}, showMinorTicks:true}
            }
           
        });

       
        var plot_chartSumm = $.jqplot('chart3',[${totaldonations}] , {
        title: '${title}',
        stackSeries: false,
        
       
        series:{
                fillColor: "#4bb2c5",
        },
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true, location: 'n', edgeTolerance: -15 },
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'vertical',
                     barMargin: 30,
                     highlightMouseDown: true 
                }
            },
             
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    label: 'Centers',
                    showMinorTicks:true,
                     ticks: ${dcenters},
                      labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        tickOptions: {
                          // labelPosition: 'middle',
                          angle: 30
                        }
                },
                 yaxis: {min:0, label: 'Total Donation', tickInterval:${maxdonation}, showMinorTicks:true}
            }
           
        });

    var plot_chartModes = $.jqplot('chart4',[${totalmodedonations}] , {
        title: '${title2}',
        stackSeries: false,
        
       
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
           
            rendererOptions: {  showDataLabels: true
                                // , dataLabels: 'value' // enable this for showing values.
                             }
        },        
          
        legend:{
            show:true,             
            placement: 'outsideGrid', 
            
            location:'s',
            marginTop: '15px'
        } 
        
        });

      $( "#exportedimage" ).dialog({
        height: 1440,
        width:1300,
        modal: true,
        autoOpen:false
        });
         $( "#exportedimage3" ).dialog({
        height: 740,
        width:1300,
        modal: true,
        autoOpen:false
        });

     
        $("#exportimagebutton2").click(function(){
            $( "#exportedimage" ).dialog("open");
            var imgData = $('#chart3').jqplotToImageStr({}); // given the div id of your plot, get the img data
            var imgElem = $('<img/>').attr('src',imgData); // create an img and add the data to it
            $('#imgChart2').empty();
            $('#imgChart2').append(imgElem);

            var imgData4 = $('#chart4').jqplotToImageStr({}); // given the div id of your plot, get the img data
            var imgElem4 = $('<img/>').attr('src',imgData4); // create an img and add the data to it
            
            $('#imgChart2').append(imgElem4);
           
        });

          $("#exportimagebutton3").click(function(){
            $( "#exportedimage3" ).dialog("open");            
            var imgData5 = $('#chart5').jqplotToImageStr({}); // given the div id of your plot, get the img data
            var imgElem5 = $('<img/>').attr('src',imgData5); // create an img and add the data to it
            $('#imgChart3').empty();
            $('#imgChart3').append(imgElem5);
        });
        
        

    });
</script>
    </body>
</html>
