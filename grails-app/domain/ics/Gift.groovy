package ics

class Gift {

    static constraints = {
	    name()
	    description(nullable:true)
	    scheme(nullable:true)
	    worth()
	    cost()
	    qtyInStock()
	    effectiveFrom(nullable:true)
	    effectiveTill(nullable:true)
	    category(nullable:true)
	    department(nullable:true)

	    purchasedFrom(nullable:true)
	    purchasedBy(nullable:true)
	    purchaseAmount(nullable:true)
	    purchaseReference(nullable:true)
	    purchaseDate(nullable:true)

	    image(nullable:true, maxSize: 102400 /* 100K */)
	    imageType(nullable:true)

	    dateCreated()
	    creator()
	    lastUpdated()
	    updator()

    }

    String name
    String description
    int worth
    int cost
    Date effectiveFrom
    Date effectiveTill
    String category
    int qtyInStock=0
    Scheme scheme

    int qtyPurchased=0
    Individual purchasedFrom
    Individual purchasedBy
    BigDecimal purchaseAmount
    String purchaseReference
    Date purchaseDate
    
    Department department
    
    byte[] image
    String imageType

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    static hasMany = [giftIssued:GiftIssued]
    
  
    	static mapping = {
    		giftIssued sort:'issueDate'
    	}
    

            String toString() {
                //return (category?:"")+":"+scheme.toString()+":"+name
                return name
    	  }
}
