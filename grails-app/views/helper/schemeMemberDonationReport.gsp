
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.show" default="SchemeMember Member Donation Report" /></title>
        <r:require module="grid" />
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
            <h1><g:message code="schemeMember.show" default="SchemeMember Member Donation Report(Distinct Members are counted)" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <g:form  action="schemeMemberDonationReport" >
            <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
                         From Date
                        </td>
                        <td valign="top" class="value">
                                 <g:textField name="startDate" value="${startDate}" />    
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
                           Amount (Related to Bigger Donation List only )
                            </td>

                            <td valign="top" class="value">
                                     <g:textField name="selectedamount" value="${selectedamount}"/>    
                            </td>
                        </tr>
                        
                        
                    </tbody>
                    </table>
            </div>
            
             <div class="buttons">                   
                    <span class="button"><input type="submit" class="edit"value="${message(code: 'schemeMemberDonationReport', 'default': 'Load Report')}"  /></span>
                </div>
        </g:form>

            <div style="clear:both"></div>
            
             <div class="buttons">
                    <span class="button"><input type="button" class="export" id="exportimagebutton2" value="${message(code: 'export', 'default': 'Export As Image')}" /></span>  
             </div>
              <export:formats formats="['excel','csv','pdf','rtf']" controller="helper" action="schemeMemberDonationReportAsCVS" params="['startDate':startDate, 'endDate':endDate]"/>

             <div id="chart3" style="margin-top:20px; width:1200px; height:700px;float:left;"></div>
             <div style="clear:both"></div>
             <div id="bouncedsummary" style="float:left;padding:10px 10px;margin:50px 50px;">           
                <div>
                <!-- table tag will hold our grid -->
                <table id="bouncedsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                <!-- pager will hold our paginator -->
                <div id="bouncedsummary_list_pager" class="scroll" style="text-align:center;"></div>
                </div>
            </div>
             <div style="clear:both"></div>
             <div id="biggerdonationsummary" style="float:left;padding:10px 10px;margin:50px 50px;">           
                <div>
                <!-- table tag will hold our grid -->
                <table id="biggerdonationsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                <!-- pager will hold our paginator -->
                <div id="biggerdonationsummary_list_pager" class="scroll" style="text-align:center;"></div>
                </div>
            </div>

             <div id="exportedimage" title="Save the Report">
              <div id="imgChart2" style="margin-top:20px; width:1200px; height:700px;float:right;"></div>
              
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

    
       
        var plot_chartSumm = $.jqplot('chart3',[${totalmembers}] , {
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
                 yaxis: {min:0, label: 'Total Members given Donation', tickInterval:${maxcount}, showMinorTicks:true}
            }
          
        });

      $( "#exportedimage" ).dialog({
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
        });
        
         jQuery("#bouncedsummary_list").jqGrid({             
              datatype: "local",
              data: ${bouncedRecordData},              
              colNames:['Donor','Donation Date','Centre','Comments','Payment Details','id'],
              colModel:[
                {name:'individual',search:false},
                {name:'donationdate',search:false},
                {name:'centre',search:false},                
                {name:'comments',search:false},            
                {name:'details',formatter:'showlink',search:false,
                formatoptions:{baseLinkUrl:'${createLink(controller:'donationRecord',action:'show')}',target:'_blank'}},
                {name:'id',hidden:true}
                 ],
            rowNum:4,
            rowList:[10,20,30],
            pager: '#bouncedsummary_list_pager',
            viewrecords: true,
            gridview: true,            
            width: 1100,
            height: "100%",
            caption:"Bounced Donation List"
            });

            jQuery("#biggerdonationsummary_list").jqGrid({             
              url:'${createLink(controller:'helper',action:'schemeMembersGivenDonationMoreThanAmount')}',
              postData:{startDate:function(){return $("#startDate").val();}, endDate:function(){return $("#endDate").val();} ,selectedamount:function(){return $("#selectedamount").val();} },
              datatype: "json",                            
              colNames:['Donor','Donation Amount', 'Donation Date','Centre','Comments','Payment Details','id'],
              colModel:[
                {name:'individual',search:false},
                {name:'amount',formatter:'showlink',search:false,formatoptions:{baseLinkUrl:'${createLink(controller:'donationRecord',action:'show')}',target:'_blank'}},
                {name:'donationdate',search:false},
                {name:'centre',search:false},                
                {name:'comments',search:false},            
                {name:'details',formatter:'showlink',search:false,
                formatoptions:{baseLinkUrl:'${createLink(controller:'donationRecord',action:'show')}',target:'_blank'}},
                {name:'id',hidden:true}
                 ],
            rowNum:4,
            rowList:[10,20,30,50],
            pager: '#biggerdonationsummary_list_pager',
            viewrecords: true,
            gridview: true,            
            width: 1100,
            height: "100%",
            caption:"Bigger Donation List"
            });


    });
</script>
    </body>
</html>
