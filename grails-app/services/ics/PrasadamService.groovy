package ics

class PrasadamService {

    def serviceMethod() {
    }
    
    def getArrivalCount(boolean runtime, boolean vipFlag, String fromTs, String toTs) {
	def result = null
	if(!runtime)
		{
		result = EventRegistration.createCriteria().list() {
			eq('isVipDevotee',vipFlag)
			eq('verificationStatus',VerificationStatus.VERIFIED)
			gt('arrivalDate',Date.parse('dd-MM-yyyy HH:mm', fromTs))
			le('arrivalDate',Date.parse('dd-MM-yyyy HH:mm', toTs))
			projections {
				sum 'numberofPrabhujis'
				sum 'numberofMatajis'
				sum 'numberofChildren'
				sum 'numberofBrahmacharis'
				}
			}
		}
	else
		{
		result = EventRegistrationGroup.createCriteria().list() {
			mainEventRegistration{eq('isVipDevotee',vipFlag)}
			gt('dateCreated',Date.parse('dd-MM-yyyy HH:mm', fromTs))
			le('dateCreated',Date.parse('dd-MM-yyyy HH:mm', toTs))
			projections {
				sum 'numPrji'
				sum 'numMataji'
				sum 'numChildren'
				sum 'numBrahmachari'
				}
			} 
		}
	[total:((result[0][0]?:0)+(result[0][1]?:0)+(result[0][2]?:0)+(result[0][3]?:0)),numPrji:(result[0][0]?:0),numMataji:(result[0][1]?:0),numChildren:(result[0][2]?:0),numBrahmachari:(result[0][3]?:0)]
    }
    
    def getDepartureCount(boolean runtime, boolean vipFlag, String fromTs, String toTs) {
	def result = null
	if(!runtime)
		{
			result = EventRegistration.createCriteria().list() {
			eq('isVipDevotee',vipFlag)
			eq('verificationStatus',VerificationStatus.VERIFIED)
			gt('departureDate',Date.parse('dd-MM-yyyy HH:mm', fromTs))
			le('departureDate',Date.parse('dd-MM-yyyy HH:mm', toTs))
			projections {
				sum 'numberofPrabhujis'
				sum 'numberofMatajis'
				sum 'numberofChildren'
				sum 'numberofBrahmacharis'
			}
			}
		}
	else
		{
		result = EventRegistrationGroup.createCriteria().list() {
			mainEventRegistration{eq('isVipDevotee',vipFlag)}
			mainEventRegistration{gt('departureDate',Date.parse('dd-MM-yyyy HH:mm', fromTs))}
			mainEventRegistration{le('departureDate',Date.parse('dd-MM-yyyy HH:mm', toTs))}
			projections {
				sum 'numPrji'
				sum 'numMataji'
				sum 'numChildren'
				sum 'numBrahmachari'
			}
			}
		}
	if(result?.size()>0)
		[total:((result[0][0]?:0)+(result[0][1]?:0)+(result[0][2]?:0)+(result[0][3]?:0)),numPrji:result[0][0],numMataji:result[0][1],numChildren:result[0][2],numBrahmachari:result[0][3]]
	else
		{
		log.debug("In PrasadamService.getDepartureCount: Result is 0")
		[total:0,numPrji:0,numMataji:0,numChildren:0,numBrahmachari:0]
		}
    }

    def getTPCount(boolean runtime, boolean vipFlag, String fromTs, String toTs) {
	def result = null
	if(!runtime)
		{
		result = EventRegistration.createCriteria().list() {
			eq('isVipDevotee',vipFlag)
			eq('verificationStatus',VerificationStatus.VERIFIED)
			gt('departureDate',Date.parse('dd-MM-yyyy HH:mm', fromTs))
			le('departureDate',Date.parse('dd-MM-yyyy HH:mm', toTs))
			projections {
				sum 'noofBreakfasts'
				sum 'noofLunches'
				sum 'noofDinners'
				}
			}
		}
	else
		{
		result = EventRegistrationGroup.createCriteria().list() {
			mainEventRegistration{eq('isVipDevotee',vipFlag)}
			mainEventRegistration{gt('departureDate',Date.parse('dd-MM-yyyy HH:mm', fromTs))}
			mainEventRegistration{le('departureDate',Date.parse('dd-MM-yyyy HH:mm', toTs))}
			mainEventRegistration{
				projections {
					sum 'noofBreakfasts'
					sum 'noofLunches'
					sum 'noofDinners'
				}
				}
			} 
		}
	
	[numB:result[0][0],numL:result[0][1],numD:result[0][2]]
    }
    
}
