#!/usr/bin/python
# -*- coding: utf-8 -*-

#
#
#

import mwclient
import sys

def create(username,password,email,realname):
	url='wiki.eluniversal.com'
	site = mwclient.Site(url, path = '/')

	lg=site.login('wasuaje','www4214')

	#procedo a crear las cuentas de usuario
	rs= site.raw_api('createaccount',name=username,password=password,email=email,realname=realname)
	print rs
	rs2= site.raw_api('createaccount',name=username,password=password,email=email,realname=realname,token=rs['createaccount']['token'])	
	print rs2

if __name__ == "__main__":

	print "NO SE PUEDE IMPLEMENTAR TODAVIA HASTA QUE SE MIGRE A LA ULTIMA VERSION DE MEDIAWIKI"
	#print sys.argv
	# if  len(sys.argv) < 4 or len(sys.argv) > 4:
	# 	print "3 parametros exactos requeridos, username,email, real name"
	# else:
	# 	username=sys.argv[1]
	# 	password="123_%s_456" % username
	# 	email=sys.argv[2]
	# 	realname=sys.argv[3]
	# 	create(username,password,email,realname)