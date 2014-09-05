package ics



class StatementJob {
    
    def commsService
    
    static triggers = {
      simple repeatInterval: 90000l // execute job once in 5 seconds
    }

    def execute() {
        /*println "hare krishna "+new Date()
        log.debug("starting stmt job")
        commsService.sendCCStmt()
        log.debug("finishing stmt job")*/
    }
}
