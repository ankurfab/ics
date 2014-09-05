package ics

enum AccommodationAllotmentStatus {

	ALLOTEMENT_COMPLETE('Allotment Complete'),
	ALLOTEMENT_IN_PROGRESS('Allotment in Progress'),
	ALLOTEMENT_REJECTED('Allotment Rejected'),
	NOT_ALLOTED('Not Alloted')

	String displayName

	AccommodationAllotmentStatus(String displayName) {
		this.displayName = displayName
	}
}