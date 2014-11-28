package ics

class FarmerService {

    def receiptSequenceService

    def serviceMethod() {
    }
    
    def generateShareCertificate(Farmer farmerInstance) {
	log.debug("Generating share certificate for farmer:"+farmerInstance)
	farmerInstance.folioNo = receiptSequenceService.getNext("FDB-FN")
	farmerInstance.shareCertificateNo = receiptSequenceService.getNext("FDB-SC")
	if(!farmerInstance.save())
		farmer.errors.allErrors.each {log.debug(it)}
	//now populate share certificate
	def numShares = farmerInstance.shareAmount/Share.get(1).shareAmount
	def shareCertificate = new ShareCertificate()
	shareCertificate.certificateNo = farmerInstance.shareCertificateNo
	shareCertificate.numShares = numShares
	shareCertificate.amountShares = farmerInstance.shareAmount
	shareCertificate.shareNos = ""
	shareCertificate.shares = []
	def share
	def firstShare= Share.findByStatusIsNull()
	for(int j=0;j<numShares;j++)
		{
		share = Share.get(firstShare.id+j)
		share.status='ISSUED_'+farmerInstance.id
		if(!share.save())
			share.errors.allErrors.each {log.debug(it)}
		shareCertificate.shares.add(share)
		if(j==0 || j==numShares-1)
			shareCertificate.shareNos += share.shareSerialNo+"-"
		}
	if(!shareCertificate.save())
		shareCertificate.errors.allErrors.each {log.debug(it)}

	//now add the share certificate to the farmer
	farmerInstance.shareCertificates = []
	farmerInstance.shareCertificates.add(shareCertificate)
	if(!farmerInstance.save())
		farmer.errors.allErrors.each {log.debug(it)}
	return farmerInstance
    }
    
    
}
