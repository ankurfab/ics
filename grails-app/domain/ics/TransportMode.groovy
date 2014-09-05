package ics

enum TransportMode {

	BUS('Bus'),
	TRAIN('Train'),
	FLIGHT('Flight')
  
	String displayName

	TransportMode(String displayName) {
		this.displayName = displayName
	}
}