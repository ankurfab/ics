package ics

class Loan {

    static constraints = {
    	loanDate()
    	loanedBy()
    	reference1(nullable:true)
    	reference2(nullable:true)
    	nominee(nullable:true)
    	amount(min:1)
    	term(nullable:true)
    	category()
    	loanReceiptNo()
    	accoutsReceiptNo(nullable:true,blank:true)
    	mode(nullable:true)
    	lotId(nullable:true) 
    	fatherOrSpouse(nullable:true)
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
    	numInstallments(nullable:true)
    	numInstallmentsOver(nullable:true)
    	type(nullable:true)
    	status(nullable:true)
    	
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
    
    Integer numInstallments
    Integer numInstallmentsOver
    String type		//IN or OUT; received from the person or given to the person

    Date dateCreated
    Date lastUpdated
    String creator
    String updator

    String toString() {
    	String.format('%td-%<tm-%<tY',loanDate)+":"+loanReceiptNo+":"+":"+amount
    }

}
