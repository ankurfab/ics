package ics

class MenuService {

    def serviceMethod() {
    }
    
    def createMenu(Map params) {
	  def flag = true
	  
	  // first get the date
	  def dt = Date.parse('dd-MM-yyyy', params.Date)
	  if(!dt)
		dt = new Date()
	   Calendar calendar = new GregorianCalendar();
	   calendar.setTime(dt)

	  //create the menu chart
	  def menuChart = new MenuChart()
	  //menuChart.chartName = "Week"+calendar.get(Calendar.WEEK_OF_YEAR)+" Year"+dt.format('yy')
	  menuChart.chartName = "Week"+dt.format('ww')+" Year"+dt.format('yy')
	  menuChart.category = "Temple" //todo remove hardcoding
	  menuChart.chartDate = dt
	  menuChart.menu = []
	  if(!menuChart.save())
		{
		    flag = false
		    menuChart.errors.allErrors.each {
			println it
			}
			return 0
		}


	  //check if event is supplied
	  if(params.Event)
		{
		def event = new Event(title:params.Event, startDate:dt)
		event.save()
		}

    	createBreakfast(menuChart, params)
    	createHealth(menuChart, params)
    	createBrunch(menuChart, params)
    	createLunch(menuChart, params)
    	createDinner(menuChart, params)
    	createOutprogram(menuChart, params)
    	createFFL(menuChart, params)
    	createProgram(menuChart, params)
    	return menuChart.id
    }
    
    def createMenu(MenuChart menuChart, Meal meal, String mealDate) {
	  def menu = new Menu()
	  menu.meal = meal
	  menu.mealDate=Date.parse('dd-MM-yyyy', mealDate)
	  menu.creator = "" //todo remove hardcoding
	  menu.updator = menu.creator
	  menu.menuChart = menuChart
	  menu.menuItems = []
	  if (!menu.save()) {
	    menu.errors.allErrors.each {
		println it
		}
		return null
	  }
	  return menu
    }
    
    def createMenuItem(Menu menu, List recipeList) {
	if(!menu || !recipeList || recipeList?.size()==0)
		return
	def rv,mi 
	recipeList.each{
		rv = it.defaultRecipe
		//create new menu item
		mi = new MenuItem()
		mi.recipe = rv
		mi.menu = menu
		  if (!mi.save()) {
		    mi.errors.allErrors.each {
			println it
			}
		  }
	}
    }
    
    def createBreakfast(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.Breakfast)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.BREAKFAST,params.Date)
		if(!menu)
			return
		//create new menu item
		createMenuItem(menu, recipeList)
		}
    }
    
    def createHealth(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.BreakfastHealthKhichadi)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.HEALTH,params.Date)
		if(!menu)
			return
		createMenuItem(menu, recipeList)
		}
    }

    def createBrunch(MenuChart menuChart, Map params) {
	  //find the recipe
	  def recipeList = []
	  def recipe1 = Recipe.findByName(params.BrunchSabji)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  def recipe2 = Recipe.findByName(params.BrunchDal)
	  if(recipe2)
	  	recipeList.add(recipe2)
	  def recipe3 = Recipe.findByName(params.BrunchRoti)
	  if(recipe3)
	  	recipeList.add(recipe3)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.BRUNCH,params.Date)
		if(!menu)
			return
		createMenuItem(menu, recipeList)
		}
    }
    
    def createLunch(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.LunchRice)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  def recipe2 = Recipe.findByName(params.LunchDal)
	  if(recipe2)
	  	recipeList.add(recipe2)
	  def recipe3 = Recipe.findByName(params.LunchSabjiDry)
	  if(recipe3)
	  	recipeList.add(recipe3)
	  def recipe4 = Recipe.findByName(params.LunchSabjiWet)
	  if(recipe4)
	  	recipeList.add(recipe4)
	  def recipe5 = Recipe.findByName(params.LunchAccompaniment)
	  if(recipe5)
	  	recipeList.add(recipe5)
	  def recipe6 = Recipe.findByName(params.LunchSweet)
	  if(recipe6)
	  	recipeList.add(recipe6)
	  def recipe7 = Recipe.findByName(params.LunchDrinks)
	  if(recipe7)
	  	recipeList.add(recipe7)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.LUNCH,params.Date)
		if(!menu)
			return
		createMenuItem(menu, recipeList)
		}
    }
    
    def createDinner(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.DinnerRice)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  def recipe2 = Recipe.findByName(params.DinnerSabji)
	  if(recipe2)
	  	recipeList.add(recipe2)
	  def recipe3 = Recipe.findByName(params.DinnerDal)
	  if(recipe3)
	  	recipeList.add(recipe3)
	  def recipe4 = Recipe.findByName(params.DinnerHealthKhichadi)
	  if(recipe4)
	  	recipeList.add(recipe4)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.DINNER,params.Date)
		if(!menu)
			return
		createMenuItem(menu, recipeList)
		}
    }
    
    def createOutprogram(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.OPSweet)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.OUTPROGRAM,params.Date)
		if(!menu)
			return
		//create new menu item
		createMenuItem(menu, recipeList)
		}
    }
    
    def createFFL(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.FFLKhichadi)
	  if(recipe1)
	  	recipeList.add(recipe1)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.FFL,params.Date)
		if(!menu)
			return
		//create new menu item
		createMenuItem(menu, recipeList)
		}
    }
    
    def createProgram(MenuChart menuChart, Map params) {
	  def recipeList = []
	  //find the recipe
	  def recipe1 = Recipe.findByName(params.Programs)
	  println "createProgram: "+recipe1
	  if(recipe1)
	  	recipeList.add(recipe1)
	  if(recipeList.size()>0)
		{
		//create menu
		def menu = createMenu(menuChart,Meal.PROGRAM,params.Date)
		if(!menu)
			return
		//create new menu item
		createMenuItem(menu, recipeList)
		}
    }
    
    
}
