package com.krishna

import org.apache.commons.lang.builder.HashCodeBuilder

class IcsUserIcsRole implements Serializable {

	IcsUser icsUser
	IcsRole icsRole

	boolean equals(other) {
		if (!(other instanceof IcsUserIcsRole)) {
			return false
		}

		other.icsUser?.id == icsUser?.id &&
			other.icsRole?.id == icsRole?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (icsUser) builder.append(icsUser.id)
		if (icsRole) builder.append(icsRole.id)
		builder.toHashCode()
	}

	static IcsUserIcsRole get(long icsUserId, long icsRoleId) {
		find 'from IcsUserIcsRole where icsUser.id=:icsUserId and icsRole.id=:icsRoleId',
			[icsUserId: icsUserId, icsRoleId: icsRoleId]
	}

	static IcsUserIcsRole create(IcsUser icsUser, IcsRole icsRole, boolean flush = false) {
		new IcsUserIcsRole(icsUser: icsUser, icsRole: icsRole).save(flush: flush, insert: true)
	}

	static boolean remove(IcsUser icsUser, IcsRole icsRole, boolean flush = false) {
		IcsUserIcsRole instance = IcsUserIcsRole.findByIcsUserAndIcsRole(icsUser, icsRole)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(IcsUser icsUser) {
		executeUpdate 'DELETE FROM IcsUserIcsRole WHERE icsUser=:icsUser', [icsUser: icsUser]
	}

	static void removeAll(IcsRole icsRole) {
		executeUpdate 'DELETE FROM IcsUserIcsRole WHERE icsRole=:icsRole', [icsRole: icsRole]
	}

	static mapping = {
		id composite: ['icsRole', 'icsUser']
		version false
	}
}
