package ics

class Invoice {

    static constraints = {
	    invoiceNumber()
	    invoiceDate()
	    preparedBy()
	    departmentBy(nullable:true)	//issued by which department
	    departmentTo(nullable:true)	//raised for which department
	    personTo(nullable:true)	//raised for which department
	    dueDate(nullable:true)
	    itemTotalAmount(nullable:true)
	    itemTotalAmountWithTax(nullable:true)
	    extraAmount(nullable:true)
	    discountAmount(nullable:true)
	    invoiceAmount(nullable:true)
	    status()
	    comments(nullable:true)
	    paymentReference(nullable:true)
	    type(nullable:true)
	    description(nullable:true)
	    mode(nullable:true)
	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()
    }
    
    String invoiceNumber
    Date invoiceDate
    Individual preparedBy
    Department departmentBy	//issued by which department
    CostCenter departmentTo	//raised for which department
    String personTo		//raised for which person
    Date dueDate
    BigDecimal itemTotalAmount
    BigDecimal itemTotalAmountWithTax
    BigDecimal extraAmount
    BigDecimal discountAmount
    BigDecimal invoiceAmount
    String status
    String comments
    PaymentReference paymentReference
    String type
    String description
    String mode		//cash or kind

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
	    
    static hasMany = [lineItems:InvoiceLineItem]
    
    String toString() {
    	departmentBy.toString()+"/"+invoiceNumber+"/"+invoiceAmount+"/"+status
    }
}
