package ics

class PurchaseItem {

     
    Item item
    
    BigDecimal qty
    BigDecimal unitSize	//for eg 5 pkts of 200 gms each. For this case qty=5, unitSize=200, unit = gms
    Unit unit
    BigDecimal rate

    BigDecimal nqty	//normalized
    Unit nunit		//normalized
    BigDecimal nrate	//normalized

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    static constraints = {
    
	item()
	qty()
	unitSize(nullable:true)
	unit()
	rate(nullable:true)
	
	nqty(nullable:true)
	nunit(nullable:true)
	nrate(nullable:true)

	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()
      }
      
      String toString() {
      	return item.toString()+' '+qty+' '+unit
      }

}
