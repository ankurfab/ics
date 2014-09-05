
<%@ page import="ics.MenuChart" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuChart.label', default: 'MenuChart')}" />
		<title>MenuChart List</title>

		<r:require module="grid" />
		    <style>
		    .ui-autocomplete-loading {
			background: white url("${resource(dir: 'images/', file: 'spinner.gif')}") right center no-repeat;
		    }
		    </style>
	</head>
	<body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
		<!--
		<div class="ui-widget">
		    <label for="birds">Birds: </label>
		    <input id="birds" size="50" />
		</div>
		-->

		<!-- table tag will hold our grid -->
		<table id="menuChart_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="menuChart_list_pager" class="scroll" style="text-align:center;"></div>

		<script type="text/javascript">
		  $(document).ready(function () {
		    jQuery("#menuChart_list").jqGrid({
		      url:'jq_menuChart_list',
		      editurl:'jq_edit_menuChart',
		      datatype: "json",
		      colNames:['Week','Day','Date','Event','Breakfast','Health Khichadi','Sabji','Dal','Roti','Rice','Dal','Sabji Dry','Sabji Wet','Health Accompaniment','Sweet','Drinks','Rice','Sabji','Dal','Health Khichadi','Sweet','Khichadi','Programs','id'],
		      colModel:[
				{name:'Week', editable:false},
				{name:'Day', editable:false},
				{name:'Date', editable:true,
				editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy'}); 
				  }}},
				{name:'Event', editable:true},
				{name:'Breakfast', editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'BreakfastHealthKhichadi' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'BrunchSabji' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'BrunchDal' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'BrunchRoti' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchRice' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchDal' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchSabjiDry' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchSabjiWet' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchAccompaniment' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchSweet' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'LunchDrinks' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'DinnerRice' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'DinnerSabji' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'DinnerDal' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'DinnerHealthKhichadi' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'OPSweet' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'FFLKhichadi' , editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'Programs', editable:true,
				    'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
    					}
				},
				{name:'id',hidden:true}
		     		],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager: '#menuChart_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    width: 1440,
		    height: "100%",
		    multiselect: false,
		    caption:"MenuChart List"
		    });
		   $("#menuChart_list").jqGrid('setGroupHeaders', 
			{
			useColSpanStyle: true,
			groupHeaders:[
				{startColumnName: 'BrunchSabji', numberOfColumns: 3, titleText: 'Brunch'},
				{startColumnName: 'LunchRice', numberOfColumns: 7, titleText: 'Lunch'},
				{startColumnName: 'DinnerRice', numberOfColumns: 4, titleText: 'Dinner'},
				{startColumnName: 'OPSweet', numberOfColumns: 1, titleText: 'OutPgm'},
				{startColumnName: 'FFLKhichadi', numberOfColumns: 1, titleText: 'FFL'}
				]
			});
		jQuery("#menuChart_list").jqGrid('setFrozenColumns');
		jQuery("#menuChart_list").jqGrid('navGrid',"#menuChart_list_pager",{edit:false,add:false,del:true});
		jQuery("#menuChart_list").jqGrid('inlineNav',"#menuChart_list_pager");
		    });

		function autocomplete_element(value, options) {
		  // creating input element
		  var $ac = $('<input type="text"/>');
		  // setting value to the one passed from jqGrid
		  $ac.val(value);
		  // creating autocomplete
		  $ac.autocomplete({
			   source: "${createLink(controller:'recipe',action:'list_JQ')}"+"?category="+options.name,
			   minLength: 0
		  });
		  // returning element back to jqGrid
		  return $ac;
		}

		function autocomplete_value(elem, op, value) {
		  if (op == "set") {
		    $(elem).val(value);
		  }
		  return $(elem).val();
		}

		</script>

    <script>
    $(function() {
        function split( val ) {
            return val.split( /,\s*/ );
        }
        function extractLast( term ) {
            return split( term ).pop();
        }
 
        $( "#birds" )
            // don't navigate away from the field on tab when selecting an item
            .bind( "keydown", function( event ) {
                if ( event.keyCode === $.ui.keyCode.TAB &&
                        $( this ).data( "autocomplete" ).menu.active ) {
                    event.preventDefault();
                }
            })
            .autocomplete({
                source: function( request, response ) {
                    $.getJSON( "${createLink(controller:'recipe',action:'list')}"+".json", {
                        term: extractLast( request.term )
                    }, response );
                },
                search: function() {
                    // custom minLength
                    var term = extractLast( this.value );
                    if ( term.length < 0 ) {
                        return false;
                    }
                },
                focus: function() {
                    // prevent value inserted on focus
                    return false;
                },
                select: function( event, ui ) {
                    var terms = split( this.value );
                    // remove the current input
                    terms.pop();
                    // add the selected item
                    terms.push( ui.item.value );
                    // add placeholder to get the comma-and-space at the end
                    terms.push( "" );
                    this.value = terms.join( ", " );
                    return false;
                }
            });
    });
    </script>

	</body>
</html>
