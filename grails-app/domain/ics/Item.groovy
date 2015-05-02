package ics

class Item {

    static searchable = { only = ['name','otherNames','*category','variety','brand'] }

    String name       /* rice */
    String otherNames
    
    
    String category  /* Grains */
    String subcategory  /* Grains */
    
    BigDecimal densityFactor  
        
    String variety   /* Basmati, Kolam */
    String brand     /* Laxmi Brand */
    
    BigDecimal rate  
    BigDecimal taxRate  

    String comments
    
    Department department	//Kitchen, VaishnavSamvardhan, Common (if null)

	byte[] image1Data
	String image1Type
	byte[] image2Data
	String image2Type

    BigDecimal nunitSize	//normalized unit size i.e. 25
    Unit nunit		//normalized unit KG (for a 25kg gunny bag of rice)
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    //static belongsTo = [itemCategory: ItemCategory]

    static constraints = {
    
	name()
	otherNames(nullable:true)	
	
	category(nullable:true)
	subcategory(nullable:true)
	variety(nullable:true)
	brand(nullable:true)
	densityFactor(nullable:true)
	
	comments(nullable:true, blank:true)
	department(nullable:true)

	image1Data(nullable:true, maxSize: 65535  /* 64K */)
	image1Type(nullable:true)
	image2Data(nullable:true, maxSize: 65535  /* 64K */)
	image2Type(nullable:true)

	nunitSize(nullable:true)
	nunit(nullable:true)

	rate(nullable:true)
	taxRate(nullable:true)

	creator(nullable:true)
	dateCreated()
	updator(nullable:true)
	lastUpdated()
	}
	
    String toString() {
         	return name
     	}

    String toFullString() {
         	return (category?:'')+":"+(subcategory?:'')+":"+(name?:'')+":"+(variety?:'')+":"+(brand?:'')
     	}

/*
    def getRate() {
        def rate = null
        def ili = InvoiceLineItem.findAllByItem(this, [max:1,sort:'id',order:'desc'])
        if(ili.size()>0)
        	{
        	//@TODO: normalize the rate
        	rate = ili[0].rate
        	}
        return rate
    }

    def getTaxRate() {
        def taxRate = null
        def ili = InvoiceLineItem.findAllByItem(this, [max:1,sort:'id',order:'desc'])
        if(ili.size()>0)
        	{
        	//@TODO: normalize the rate
        	taxRate = ili[0].taxRate
        	}
        return taxRate
    }
*/

}
