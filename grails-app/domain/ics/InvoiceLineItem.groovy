package ics

class InvoiceLineItem {

    static constraints = {
	    item()
	    qty()
	    unitSize(nullable:true)
	    unit()
	    rate()
	    taxRate(nullable:true)
	    totalWithoutTax(nullable:true)
	    totalWithTax(nullable:true)
	    description(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    Item item
    BigDecimal qty
    BigDecimal unitSize	//for eg 5 pkts of 200 gms each. For this case qty=5, unitSize=200, unit = gms
    Unit unit
    BigDecimal rate
    BigDecimal taxRate
    BigDecimal totalWithoutTax
    BigDecimal totalWithTax
    String description

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
	    
    static belongsTo = [invoice: Invoice]
    
    String toString() {
    	item.toString()+":"+qty+":"+unit+":"+rate+"/-"
    }
}
