package ics

enum VerificationStatus {

	VERIFIED('Verified', 'Confirmed'),
	UNDER_VERIFICATION('Under Verification', 'Under process'),
	REJECTED('Rejected', 'Cancelled'),
	UNVERIFIED('Not Verified', 'Not Confirmed'),

	String displayName
	String vipDisplayName

	VerificationStatus(String displayName, String vipDisplayName) {
		this.displayName = displayName
		this.vipDisplayName = vipDisplayName
	}
}