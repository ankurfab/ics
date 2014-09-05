package ics

class Denomination {

    static constraints = {
    collectionDate()
    collectedBy()
    fiftyPaiseCoinQty(min:0)
    oneRupeeCoinQty(min:0)
    twoRupeeCoinQty(min:0)
    fiveRupeeCoinQty(min:0)
    tenRupeeCoinQty(min:0)
    oneRupeeNoteQty(min:0)
    twoRupeeNoteQty(min:0)
    fiveRupeeNoteQty(min:0)
    tenRupeeNoteQty(min:0)
    twentyRupeeNoteQty(min:0)
    fiftyRupeeNoteQty(min:0)
    hundredRupeeNoteQty(min:0)
    fiveHundredRupeeNoteQty(min:0)
    oneThousandRupeeNoteQty(min:0)
    tallyTotal(nullable:true)
    tallyDate(nullable:true)
    ackDate(nullable:true)
    ackBy(nullable:true)
    ackRef(nullable:true,blank:true)
    comments(nullable:true,blank:true)
    status()
    dateCreated()
    creator()
    lastUpdated()
    updator()
    }
    
    Integer fiftyPaiseCoinQty
    Integer oneRupeeCoinQty
    Integer twoRupeeCoinQty
    Integer fiveRupeeCoinQty
    Integer tenRupeeCoinQty
    Integer oneRupeeNoteQty
    Integer twoRupeeNoteQty
    Integer fiveRupeeNoteQty
    Integer tenRupeeNoteQty
    Integer twentyRupeeNoteQty
    Integer fiftyRupeeNoteQty
    Integer hundredRupeeNoteQty
    Integer fiveHundredRupeeNoteQty
    Integer oneThousandRupeeNoteQty

    Date collectionDate
    Individual collectedBy
    Date ackDate
    Individual ackBy
    String ackRef
    
    Date tallyDate
    Integer tallyTotal
    
    String comments
    String status

    Date dateCreated
    Date lastUpdated
    String creator
    String updator
    
    String toString() {
    	def total = fiftyPaiseCoinQty * 0.5 + oneRupeeCoinQty * 1 + twoRupeeCoinQty * 2 + fiveRupeeCoinQty * 5 + tenRupeeCoinQty * 10 + oneRupeeNoteQty * 1 + twoRupeeNoteQty * 2 + fiveRupeeNoteQty * 5 + tenRupeeNoteQty * 10 + twentyRupeeNoteQty * 20 + fiftyRupeeNoteQty * 50 + hundredRupeeNoteQty * 100 + fiveHundredRupeeNoteQty * 500 + oneThousandRupeeNoteQty * 1000
    	return (fiftyPaiseCoinQty>0?"50p:"+fiftyPaiseCoinQty+";":'') + (oneRupeeCoinQty>0?"1c:"+oneRupeeCoinQty+";":'') + (twoRupeeCoinQty>0?"2c:"+twoRupeeCoinQty+";":'') + (fiveRupeeCoinQty>0?"5c:"+fiveRupeeCoinQty+";":'') + (tenRupeeCoinQty>0?"10c:"+tenRupeeCoinQty+";":'') + (oneRupeeNoteQty>0?"Re1:"+oneRupeeNoteQty+";":'') + (twoRupeeNoteQty>0?"Rs2:"+twoRupeeNoteQty+";":'') + (fiveRupeeNoteQty>0?"Rs5:"+fiveRupeeNoteQty+";":'') + (tenRupeeNoteQty>0?"Rs10:"+tenRupeeNoteQty+";":'') + (twentyRupeeNoteQty>0?"Rs20:"+twentyRupeeNoteQty+";":'') + (fiftyRupeeNoteQty>0?"Rs50:"+fiftyRupeeNoteQty+";":'') + (hundredRupeeNoteQty>0?"Rs100:"+hundredRupeeNoteQty+";":'') + (fiveHundredRupeeNoteQty>0?"Rs500:"+fiveHundredRupeeNoteQty+";":'') + (oneThousandRupeeNoteQty>0?"Rs1000:"+oneThousandRupeeNoteQty+";":'') + (" Total: "+total)
    }

}
