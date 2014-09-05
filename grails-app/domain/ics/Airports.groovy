package ics

enum Airports {

	PUNE_AIRPORT('Pune Airport'),
	MUMBAI_DOMESTIC('Mumbai Domestic'),
	MUMBAI_INTERNATIONAL('Mumbai International'),

	String displayName

	Airports(String displayName) {
		this.displayName = displayName
	}
}