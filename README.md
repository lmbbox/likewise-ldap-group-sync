# Likewise LDAP Group Sync

This is a script that will work with Likewise's LDAP integration to find the user accounts in a given LDAP group and add them to a local group in linux.

## Usage

First you need to create configuration files in the group.d folder. Use the .example file as a reference when creating yours (see below).

	# LDAP Group Membership Sync Config
	ADGROUP=Linux^Admins
	LOCALGROUP=admin
	DEFAULTUSERS=usera,userb

You must set all three values, where:

	ADGROUP is the LDAP group you which to add users from
	LOCALGROUP is the local linux group you wish to add the ADGROUP users to
	DEFAULTUSERS is a way to make sure local users stay on the group you are updating via LDAP
