package ics

class ItemCount {

    int icNum 
    Item item
    
    String qualifier
    
    BigDecimal qty
    BigDecimal subqty
    Unit unit
    Unit subunit
    BigDecimal rate

    BigDecimal nqty	//normalized
    Unit nunit		//normalized
    BigDecimal nrate	//normalized
    
    String yieldFormula
    String qtyFormula

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static belongsTo = [instruction: Instruction]

    static constraints = {
    
	icNum(nullable:true)
	item()
	qualifier(nullable:true)
	qty(nullable:true)
	unit(nullable:true)
	subqty(nullable:true)
	subunit(nullable:true)	
	rate(nullable:true)
	
	nqty(nullable:true)
	nunit(nullable:true)
	nrate(nullable:true)

	yieldFormula(nullable:true)
	qtyFormula(nullable:true)
	
	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()
      }
      
      String toString() {
      	return icNum+ ' ' +item.toString()+ ' ' +qty + ' ' +unit
      }

}
