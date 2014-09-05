package ics

class Motd {

    static constraints = {
    quote(maxSize:1000)
    reference(maxSize:500)


    dateCreated()
    creator()
    lastUpdated()
    updator()
    }

    String quote
    String reference


    Date dateCreated
    Date lastUpdated
    String creator
    String updator
}
