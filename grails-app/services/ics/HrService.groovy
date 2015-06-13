package ics

class HrService {

    def financeService
    
    def salaryEAR(Map params) {
	log.debug("Inside salaryEAR with params:"+params)
	def message = "OK"
	Map salEARParams = [:]
	return message
    }

    def loanEAR(Map params) {
	log.debug("Inside loanEAR with params:"+params)
	def message = "OK"
	Map loanEARParams = [:]
	return message
    }
    
    def processPayroll() {
	log.debug("Inside processPayroll with params:"+params)
	def message = "OK"
	return message
    }

}
