package ics

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class MenuChartController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def menuService

    def index() {
        //redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [menuChartInstanceList: MenuChart.list(params), menuChartInstanceTotal: MenuChart.count()]
    }

    def create() {
        [menuChartInstance: new MenuChart(params)]
    }

    def save() {
        def menuChartInstance = new MenuChart(params)
        if (!menuChartInstance.save(flush: true)) {
            render(view: "create", model: [menuChartInstance: menuChartInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), menuChartInstance.id])
        redirect(action: "show", id: menuChartInstance.id)
    }

    def show() {
        def menuChartInstance = MenuChart.get(params.id)
        if (!menuChartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "list")
            return
        }

        [menuChartInstance: menuChartInstance]
    }

    def edit() {
        def menuChartInstance = MenuChart.get(params.id)
        if (!menuChartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "list")
            return
        }

        [menuChartInstance: menuChartInstance]
    }

    def update() {
        def menuChartInstance = MenuChart.get(params.id)
        if (!menuChartInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (menuChartInstance.version > version) {
                menuChartInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'menuChart.label', default: 'MenuChart')] as Object[],
                          "Another user has updated this MenuChart while you were editing")
                render(view: "edit", model: [menuChartInstance: menuChartInstance])
                return
            }
        }

        menuChartInstance.properties = params

        if (!menuChartInstance.save(flush: true)) {
            render(view: "edit", model: [menuChartInstance: menuChartInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), menuChartInstance.id])
        redirect(action: "show", id: menuChartInstance.id)
    }

    def delete() {
        def menuChartInstance = MenuChart.get(params.id)
        if (!menuChartInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "list")
            return
        }

        try {
            menuChartInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'menuChart.label', default: 'MenuChart'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

// return JSON list of menuChart
    def jq_menuChart_list = {      
      
      //def sortIndex = params.sidx ?: 'chartName'
      def sortIndex = 'chartDate' //todo hardcoded
      def sortOrder  = params.sord ?: 'asc'

      def maxRows = Integer.valueOf(params.rows)
      def currentPage = Integer.valueOf(params.page) ?: 1

      def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
      
      def result = MenuChart.createCriteria().list(max:maxRows, offset:rowOffset) {
            eq("category","Temple")
            order(sortIndex, sortOrder)
      }
      def totalRows = result.totalCount
      def numberOfPages = Math.ceil(totalRows / maxRows)
      
      def jsonCells = []
      result.each {
	    def bfast = Menu.findByMenuChartAndMeal(it,Meal.BREAKFAST)
	    def health = Menu.findByMenuChartAndMeal(it,Meal.HEALTH)
	    def brunch = Menu.findByMenuChartAndMeal(it,Meal.BRUNCH)
	    def lunch = Menu.findByMenuChartAndMeal(it,Meal.LUNCH)
	    def dinner = Menu.findByMenuChartAndMeal(it,Meal.DINNER)
	    def op = Menu.findByMenuChartAndMeal(it,Meal.OUTPROGRAM)
	    def ffl = Menu.findByMenuChartAndMeal(it,Meal.FFL)
	    def program = Menu.findByMenuChartAndMeal(it,Meal.PROGRAM)
	    
	    def brunchMI = MenuItem.where{menu==brunch}.findAll()
	    def lunchMI = MenuItem.where{menu==lunch}.findAll()
	    def dinnerMI = MenuItem.where{menu==dinner}.findAll()
	    
	    jsonCells.add([cell: [
		    it.chartName,
		    it.chartDate?.format('EEE'),
		    it.chartDate?.format('dd-MM-yy'),
		    it.chartDate==null?"":Event.findByStartDate(it.chartDate)?.toString(),
		    bfast!=null?MenuItem.findByMenu(bfast)?.toString():'',
		    health!=null?MenuItem.findByMenu(health)?.toString():'',
		    brunchMI.find{it.recipe?.recipe?.category?.startsWith('Sabji')}?.toString(), //todo this is error prone in case category has multiple terms
		    brunchMI.find{it.recipe?.recipe?.category?.startsWith('Dal')}?.toString(),
		    brunchMI.find{it.recipe?.recipe?.category?.startsWith('Roti')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('Rice')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('Dal')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('SabjiDry')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('SabjiWet')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('Accompaniment')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('Sweet')}?.toString(),
		    lunchMI.find{it.recipe?.recipe?.category?.startsWith('Drinks')}?.toString(),
		    dinnerMI.find{it.recipe?.recipe?.category?.startsWith('Rice')}?.toString(),
		    dinnerMI.find{it.recipe?.recipe?.category?.startsWith('Sabji')}?.toString(),
		    dinnerMI.find{it.recipe?.recipe?.category?.startsWith('Dal')}?.toString(),
		    dinnerMI.find{it.recipe?.recipe?.category?.startsWith('HealthKhichadi')}?.toString(),
		    op!=null?MenuItem.findByMenu(op)?.toString():'',
		    ffl!=null?MenuItem.findByMenu(ffl)?.toString():'',
		    program!=null?MenuItem.findByMenu(program)?.toString():''
		], id: it.id])
        }
        
        def jsonData= [rows: jsonCells,page:currentPage,records:totalRows,total:numberOfPages]
        render jsonData as JSON
    }
    
	def jq_edit_menuChart = {
	      println "inside jq_edit_menuChart: "+params
	      def menuChart
	      def message = ""
	      def state = "FAIL"
	      def id

	      // determine our action
	      switch (params.oper) {
		case 'add':
		  id = menuService.createMenu(params)
		  if (id>0) {
		    message = "menu  Added"
		    state = "OK"
		  } else {
		    message = "Could Not Save menu"
		  }
		  break;
		case 'del':
		  // check menu exists
		  menuChart = MenuChart.get(params.id)
		  if (menuChart) {
		    // delete menu
		    menuChart.delete()
		    message = "menuchart Deleted"
		    state = "OK"
		  }
		  break;
		 default :
		  // edit action
		  // first retrieve the menu by its ID
		  menuChart = MenuChart.get(params.id)
		  if (menuChart) {
		    // set the properties according to passed in parameters
		    menuChart.properties = params
			  menuChart.updator = "" //todo remove hardcoding
		    if (! menuChart.hasErrors() && menuChart.save()) {
		      message = "menuchart  Updated"
		      id = menuChart.id
		      state = "OK"
		    } else {
			    menuChart.errors.allErrors.each {
				println it
				}
		      message = "Could Not Update menu"
		    }
		  }
		  break;
 	 }

      def response = [message:message,state:state,id:id]

      render response as JSON
    }



}
