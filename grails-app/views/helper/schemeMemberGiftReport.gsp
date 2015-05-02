
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
            <h1><g:message code="schemeMember.show" default="SchemeMember Member Gift Report" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <g:form  action="schemeMemberGiftReport" >
            <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
                         Select Gift
                        </td>
                        <td valign="top" class="value">
                               <g:select id ="gift_id" name="gift.id" from="${gifts}" optionKey="id" value="${gift?.id}"  />
                        </td>
                        </tr>

                        
                        <tr class="prop">
                            <td valign="top" class="name">
                                Centre
                            </td>

                            <td valign="top" class="value">
                                     <g:select id="centre_id" name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${centre?.id}" noSelection="['0': 'ALL']"  />
                            </td>
                        </tr>
                         <tr class="prop">
                            <td valign="top" class="name">
                                Filter by Comments
                            </td>

                            <td valign="top" class="value">
                                     <g:textField id="comments" name="comments" value="${comments}" />
                            </td>
                        </tr>
                        
                        
                        
                    </tbody>
                    </table>
            </div>
            
             <div class="buttons">                   
                    <span class="button"><input type="submit" class="edit"value="${message(code: 'schemeMemberGiftReport', 'default': 'Load Report')}"  /></span>
                </div>
        </g:form>

            <div style="clear:both"></div>
            
             <div class="buttons">
                    <span class="button"><input type="button" class="export" id="exportimagebutton2" value="${message(code: 'export', 'default': 'Export As Image')}" /></span>  
             </div>
              

             <div id="chart3" style="margin-top:20px; width:1200px; height:500px;float:left;"></div>
             <div style="clear:both"></div>
             <div id="chart4" style="margin-top:20px; width:1200px; height:500px;float:left;"></div>
             <div style="clear:both"></div>

             <div id="exportedimage" title="Save the Report">
              <div id="imgChart2" style="margin-top:20px; width:1200px; height:700px;float:right;"></div>
              
             </div>
             <div id="centregiftsummary" style="float:left;padding:10px 10px;margin:50px 50px;">           
                <div>
                <!-- table tag will hold our grid -->
                <table id="centregiftsummary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
                <!-- pager will hold our paginator -->
                <div id="centregiftsummary_list_pager" class="scroll" style="text-align:center;"></div>
                </div>
            </div>
             
        </div>
        <script type="text/javascript" language="javascript">

         $(document).ready(function(){

         var plot_chartModes = $.jqplot('chart4',[${totalmodegifts}] , {
                                title: '${giftmodereporttitle}',
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


         
       
        plot2 = $.jqplot('chart3', [${memberscount},${membersGiftCount}], {
        stackSeries: true,
        highlightMouseOver:true,

        legend: {
        show: true,
        labels:['Total Active,IRegular,Resumed,Suspended Members','Total Gift Given'],
         placement: 'insideGrid', 
         rendererOptions: {
            numberRows: 1
        },
        location: 'nw',
        xoffset: 0
        },
        title: '${giftsummaryreporttitle}',
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
        yaxis: {min:0, label: 'Total Members/Gifts', tickInterval:${maxmembercount}, showMinorTicks:true}
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

            var imgData4 = $('#chart4').jqplotToImageStr({}); // given the div id of your plot, get the img data
            var imgElem4 = $('<img/>').attr('src',imgData4); // create an img and add the data to it
            
            $('#imgChart2').append(imgElem4);
        });
        
        
            jQuery("#centregiftsummary_list").jqGrid({             
              url:'${createLink(controller:'helper',action:'schemeMembersGiftListOfCentre')}',
              postData:{gift_id:function(){return $("#gift_id").val();}, centre_id:function(){return $("#centre_id").val();} ,comments:function(){ return $("#comments").val();} },
              datatype: "json",                            
              colNames:['Gifted To','Gift', 'Gift Date','Centre','Comments','Gift Received Status','Way Gift Collected', 'Member Profile Status','Member Status', 'Member Rank', 'id'],
              colModel:[
                {name:'individual',search:false},
                {name:'amount',formatter:'showlink',search:false,formatoptions:{baseLinkUrl:'${createLink(controller:'giftRecord',action:'show')}',target:'_blank'}},
                {name:'donationdate',search:false},
                {name:'centre',search:false},                
                {name:'comments',search:false},            
                {name:'comments',search:false},            
                {name:'details',formatter:'showlink',search:false,
                formatoptions:{baseLinkUrl:'${createLink(controller:'giftRecord',action:'show')}',target:'_blank'}},
                {name:'isProfileComplete',search:false},
                {name:'status',search:false},
                {name:'star',search:false},
                {name:'id',hidden:true}
                 ],
            rowNum:4,
            rowList:[10,20,30,50],
            pager: '#centregiftsummary_list_pager',
            viewrecords: true,
            gridview: true,            
            width: 1100,
            height: "100%",
            caption:"Gift List for a Centre"
            });


    });
</script>
    </body>
</html>
