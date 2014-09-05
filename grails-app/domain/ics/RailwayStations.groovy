package ics

enum RailwayStations {

	PUNE_STATION('Pune Station'),
	MUMBAI_CST('Mumbai CST'),
	MUMBAI_CENTRAL('Mumbai Central'),
	BENDRA_TERMINUS('Bandra terminus'),

	String displayName

	RailwayStations(String displayName) {
		this.displayName = displayName
	}
}