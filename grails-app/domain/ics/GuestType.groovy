package ics

enum GuestType {

	SRILA_PRABHUPAD_DISCIPLES('Srila Prabhupada Disciples'),
	GBC('GBC\'s'),
	SANNYASIS('Sannyasis'),
	TPS('TPs'),
	SENIOR_DEVOTEES('Senior Devotees'),
	ABROAD('Abroad'),
	OTHER_POSTS('Other posts'),

	String displayName

	GuestType(String displayName) {
		this.displayName = displayName
	}
}