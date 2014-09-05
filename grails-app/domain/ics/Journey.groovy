package ics

class Journey {

    static constraints = {
    }
    
    Boolean arrival //true-> arrival journey ; false-> departure journey
    String mode
    String modeDetail
    String modeComments
    Date modeDateTime
    String location
    Integer numPrjiGuest
    Integer numMatajiGuest
    Integer numChildGuest

    Integer numPrjiPrasadam
    Integer numMatajiPrasadam
    Integer numChildPrasadam
    
    Date dateCreated
    Date lastUpdated
    String creator
    String updator
}
