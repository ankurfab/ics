<div id="chart" style="height:300px; width:400px;float:left;"></div>

<script>
  $(document).ready(function () {

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
	  
var jsonurl = "${createLink(controller:'Mb',action:'genderwiseReport')}";
    var plot = $.jqplot('chart', jsonurl, {
	title: "Chart",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl
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
    });
</script>
