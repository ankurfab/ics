package ics

class MenuOrder {

    Date orderDate
    Individual requestedBy
    Individual acceptedBy
    
    MenuChart menuChart
    Department department
    
    BigDecimal estimatedOrderValue
    BigDecimal actualOrderValue
    BigDecimal invoicedOrderValue
    BigDecimal advance
    String invoiceRef
    Date invoiceDate
    boolean settled	//invoice settled or due
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static constraints = {
    
	
	orderDate()
	requestedBy()
	acceptedBy()
	menuChart()
	estimatedOrderValue()
	actualOrderValue()
	invoicedOrderValue()
	advance()
	invoiceRef()
	invoiceDate()
	settled()	
	
	creator()
	dateCreated()
	updator()
	lastUpdated()
}}
