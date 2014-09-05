package ics

class PurchaseList {

    Date purchaseListDate	//list preparation date
    Date purchaseDateDate	//purchase date
    String status		// PR, PR Aprro... 
    String name
    Individual preparedBy
    Individual purchasedBy
    Individual purchasedFrom
    Department department
    String preparationComments
    String purchaseComments

    Date estimateDate
    BigDecimal estimatedAmount
    String estimateReference
    String estimateComments
    String estimateStatus
    
    Date billDate
    BigDecimal billAmount
    String billReference
    String billComments
    String billStatus
    
    Date paymentDate
    BigDecimal paidAmount
    String paymentReference
    String paymentComments
    String paymentMode
    String paymentStatus

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [requiredItems:PurchaseItem, purchasedItems:PurchaseItem]

    static constraints = {
    
	    purchaseListDate()
	    name()
	    preparedBy()
	    preparationComments(nullable:true)
	    status()
	    department(nullable:true)

	    purchaseDateDate(nullable:true)
	    purchasedBy(nullable:true)
	    purchasedFrom(nullable:true)
	    purchaseComments(nullable:true)

	    estimateDate(nullable:true)
	    estimatedAmount(nullable:true)
	    estimateReference(nullable:true)
	    estimateComments(nullable:true)
	    estimateStatus(nullable:true)

	    billDate(nullable:true)
	    billAmount(nullable:true)
	    billReference(nullable:true)
	    billComments(nullable:true)
	    billStatus(nullable:true)

	    paymentDate(nullable:true)
	    paidAmount(nullable:true)
	    paymentReference(nullable:true)
	    paymentComments(nullable:true)
	    paymentMode(nullable:true)
	    paymentStatus(nullable:true)
	    
	    requiredItems(nullable:true)
	    purchasedItems(nullable:true)

	creator()
	dateCreated()
	updator()
	lastUpdated()
     }
}
