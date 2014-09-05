package ics


class ReportJob {
    
    def reportService
    
    static triggers = {
      //for live
      cron name:'cronTrigger', startDelay:10000, cronExpression: '0 30 16 * * ?'     
      
      //for dev
      //cron name:'cronTrigger', startDelay:10000, cronExpression: '24 18 * * * ?'     
    }

    def execute() {
        try{
        reportService.populatePeriodReport(['period.id':Period.last()?.id])
        }
        catch(Exception e){}
    }
}
