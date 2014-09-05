package ics

class Loan {

    static constraints = {
    	loanDate()
    	loanedBy()
    	reference1()
    	reference2()
    	nominee()
    	amount(min:1)
    	term()
    	category()
    	loanReceiptNo()
    	accoutsReceiptNo(nullable:true,blank:true)
    	mode()
    	lotId() 
    	fatherOrSpouse()
    	nomineeRelation(nullable:true)
    	fdNumber(nullable:true)
    	bank(nullable:true)
    	bankName(nullable:true)
    	bankBranch(nullable:true,blank:true)
    	chequeNo(nullable:true,blank:true)
    	chequeDate(nullable:true)
    	paymentComments(nullable:true,blank:true)
    	comments(nullable:true,blank:true)
    	loanStartDate(nullable:true)
    	loanEndDate(nullable:true)
    }

    Date loanDate
    Individual loanedBy
    int amount
    String term
    String category
    String loanReceiptNo
    String accoutsReceiptNo
    PaymentMode mode
    Bank bank
    String bankName
    String bankBranch
    String chequeNo
    Date chequeDate
    String paymentComments
    String status
    String comments
    int lotId
    String fdNumber
    String fatherOrSpouse
    String nomineeRelation

    Individual reference1
    Individual reference2
    String nominee

    Date loanStartDate
    Date loanEndDate

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	String.format('%td-%<tm-%<tY',loanDate)+":"+loanReceiptNo+":"+":"+amount
    }

}
