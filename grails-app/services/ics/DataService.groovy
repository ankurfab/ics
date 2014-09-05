package ics
import groovy.sql.Sql;

class DataService {
    def dataSource

    def serviceMethod() {
    }
    
	def eventRegistrationSummaryByStatusData(boolean vipFlag) {
		def result
		def numV=0,numUnderV=0,numR=0,numUnV=0
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						isNull('status')
						projections {
							groupProperty('verificationStatus')
							rowCount('num')
						}
					}
		//log.debug("eventRegistrationSummaryByStatusData: "+result)
		result?.each {
			switch(it[0]) {
				case VerificationStatus.VERIFIED :
					numV = it[1]
					break
				case VerificationStatus.UNDER_VERIFICATION :
					numUnderV = it[1]
					break
				case VerificationStatus.REJECTED :
					numR = it[1]
					break
				case VerificationStatus.UNVERIFIED :
					numUnV = it[1]
					break
				default:
					break
			}
		}

		//render( [[1, 3, 2, 4, 6, 9]] as JSON)
		return [[[VerificationStatus.VERIFIED.toString(),numV], [VerificationStatus.UNDER_VERIFICATION.toString(),numUnderV], [VerificationStatus.REJECTED.toString(),numR], [VerificationStatus.UNVERIFIED.toString(),numUnV]]]
	}

	def eventRegistrationSummaryData(boolean vipFlag) {
		def result
		def numP=0,numM=0,numC=0,numB=0
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						ne('verificationStatus',VerificationStatus.REJECTED)
						isNull('status')
						projections {
							sum('numberofPrabhujis')
							sum('numberofMatajis')
							sum('numberofChildren')
							sum('numberofBrahmacharis')
						}
					}
		//log.debug("eventRegistrationSummaryData: "+result)

		//render( [[['a',25],['b',14],['c',7]]] as JSON)
		return [[['Prji',result[0][0]?:0],['Mataji',result[0][1]?:0],['Children',result[0][2]?:0],['Brahmacharis/Students',result[0][3]?:0]]]
	}

	def eventRegistrationDetailData(boolean vipFlag) {
		def list = []
		def result
		def sql = new Sql(dataSource)
		//def query = "SELECT DATE_FORMAT(date_created,'%d-%b-%y') AS date, count(name) AS total_reg FROM event_registration GROUP BY date"
		def query = "SELECT DATE(date_created) AS date, count(name) AS total_reg FROM event_registration where status is null and is_Vip_Devotee="+ vipFlag+" GROUP BY date"
		result = sql.rows(query)
		sql.close()
		//log.debug("eventRegistrationDetailData: "+result)
		result.each {
			def data = []
			//data.add("'"+it.date.toString()+' 1:00AM'+"'")
			data.add(it.date.getTime())
			data.add(it.total_reg)
			list.add(data)
		}
		//log.debug("list: "+list)

		return [list]
	}

	def eventSummaryData(boolean vipFlag) {
		//summarize reg,acco,trans,prasad,volunteer later
		
		//summarize reg,acco,volunteer
		def  dataP = []
		def  dataM = []
		def  dataC = []
		def  dataB = []
		def result
		
		//reg
		result = EventRegistration.createCriteria().list {
						eq('isVipDevotee',vipFlag)
						eq('verificationStatus',VerificationStatus.VERIFIED)
						isNull('status')
						projections {
							sum 'numberofPrabhujis'
							sum 'numberofMatajis'
							sum 'numberofChildren'
							sum 'numberofBrahmacharis'
							sum 'numPrjiVolunteer'
							sum 'numMatajiVolunteer'
							sum 'numBrahmacharisVolunteer'
						}
					}
		//log.debug("Reg:"+result)

		dataP.add([result[0][0]?:0,1])
		dataM.add([result[0][1]?:0,1])
		dataC.add([result[0][2]?:0,1])
		dataB.add([result[0][3]?:0,1])
		dataP.add([result[0][4]?:0,3])
		dataM.add([result[0][5]?:0,3])
		dataC.add([0,3])//no volunteer children
		dataB.add([result[0][6]?:0,3])


		/*dataP.add([result[0][0]?:0,1])
		dataM.add([result[0][1]?:0,1])
		dataC.add([result[0][2]?:0,1])
		dataP.add([result[0][3]?:0,3])
		dataM.add([result[0][4]?:0,3])
		dataC.add([0,3])//no volunteer children*/
		
		//acco
		//todo condider VIP case
		result = AccommodationAllotment.createCriteria().list {
						eventRegistration{eq('isVipDevotee',vipFlag)}
						projections {
							sum 'numberofPrabhujisAllotted'
							sum 'numberofMatajisAllotted'
							sum 'numberofChildrenAllotted'
							sum 'numberofBrahmacharisAllotted'
						}
					}
		//log.debug("Reg:"+result)
		dataP.add([result[0][0]?:0,2])
		dataM.add([result[0][1]?:0,2])
		dataC.add([result[0][2]?:0,2])
		dataB.add([result[0][3]?:0,2])
				
		/*dataP.add([result[0][0]?:0,2])
		dataM.add([result[0][1]?:0,2])
		dataC.add([result[0][2]?:0,2])*/

		/*log.debug('dataP'+dataP)
		log.debug('dataM'+dataM)
		log.debug('dataC'+dataC)*/
		//render( [[[2,1], [4,2], [6,3], [3,4]], [[5,1], [1,2], [3,3], [4,4]], [[4,1], [7,2], [1,3], [2,4]]] as JSON)
		return [dataP,dataM,dataC,dataB]
	}
	
	def counsellorCounselleeCollectionData(Date fd, Date td) {
    		/*** new logic
    		def donor_collectorid_query = "select c.name AS donor,c.counsellor AS donors_counsellor,d.collected_by_id AS collectorid,round(sum(d.amount)) AS donation from (donation d join individual_counsellor_view c) where ((d.donated_by_id = c.id) and (d.fund_receipt_date >= '"+String.format('%tF',fd)+"') and (d.fund_receipt_date <= '"+String.format('%tF',td)+"')) group by c.name,c.counsellor,d.collected_by_id"
    		
    		def query = "select i.id AS id,d.donor AS donor,d.donors_counsellor AS donors_counsellor,d.donation AS donation,if(isnull(d.donors_counsellor),i.name,d.donor) AS collector,ifnull(d.donors_counsellor,i.counsellor) AS collectors_counsellor from (("+donor_collectorid_query+") d join individual_counsellor_view i) where (d.collectorid = i.id);"
    		****/
    		/*def sql = new Sql(dataSource);
    		
    		def query = "select * from (select * from (select iclor.id councellor_id1, iclor.initiated_name councellor_name1, iclee.id councellee_id1, iclee.legal_name councellee_legal_name1, iclee.initiated_name councellee_initiated_name1, sum(amount) collection from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.collected_by_id=iclee.id and d.collected_by_id<>d.donated_by_id and d.donated_by_id not in (select distinct d.donated_by_id from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.donated_by_id<>d.collected_by_id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"') and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q1 left join (select iclor.id councellor_id2, iclor.initiated_name councellor_name2, iclee.id councellee_id2, iclee.legal_name councellee_legal_name2, iclee.initiated_name councellee_initiated_name2, sum(amount) donation from individual iclee ,donation d, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and d.donated_by_id=iclee.id and d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"'  group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q2 on q1.councellee_legal_name1=q2.councellee_legal_name2) q3 left join (select iclor.id councellor_id1, iclor.initiated_name councellor_name, iclee.id councellee_id, iclee.legal_name councellee_legal_name, iclee.initiated_name councellee_initiated_name, sum(amount) loanAmount from individual iclee ,loan l, relation r, relationship rship, individual iclor where  iclor.id=rship.individual2_id and rship.relation_id=r.id and r.name='Councellee of' and rship.status='ACTIVE' and iclee.id=rship.individual1_id and l.loaned_by_id=iclee.id  and l.loan_date>='"+String.format('%tF',fd)+"' and l.loan_date<='"+String.format('%tF',td)+"' group by  iclee.legal_name order by iclor.initiated_name,iclee.legal_name) q4 on q3.councellee_legal_name1=q4.councellee_legal_name"
    		
    		
    		def queryResult = sql.rows(query)
    		sql.close()
     		return [queryResult: queryResult, fd:fd, td:td]*/
     		
		
		
		/*def result = Donation.createCriteria().list() {
				 ge('fundReceiptDate',fd)
				 le('fundReceiptDate',td)
				}
		return result*/
		
		def query="select d.id id, date_format(d.fund_receipt_date,'%d/%m/%Y') fundReceiptDate,d.nvcc_receipt_book_no nvccReceiptBookNo,d.nvcc_receipt_no nvccReceiptNo,date_format(donation_Date,'%d/%m/%Y') donationDate,amount,donated_By_id donorId,dc.name systemdonorName,dc.counsellor donorCounsellor, donor_Name donorName,donor_Address donorAddress,donor_Contact donorContact,donor_Email donorEmail,collected_By_id collectedById,cc.name collectedByName,cc.counsellor collectedByCounsellorName from donation d left join individual_counsellor_view dc on d.donated_by_id=dc.id left join individual_counsellor_view cc on d.collected_by_id=cc.id where d.fund_receipt_date>='"+String.format('%tF',fd)+"' and d.fund_receipt_date<='"+String.format('%tF',td)+"'"
		log.debug("In counsellorCounselleeCollectionData: "+query)
		def sql = new Sql(dataSource)
    		def queryResult = sql.rows(query)
    		sql.close()
    		return queryResult
		
	}


}
