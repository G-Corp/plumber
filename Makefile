PROJECT = plumber

DEPS = lager 
dep_lager = git https://github.com/basho/lager.git master

CP = cp
CP_R = cp -r
RM_RF = rm -rf
DATE = $(shell date +"%F %T")

include erlang.mk

dev: deps app
	@erl -pa ebin include deps/*/ebin deps/*/include -config config/${PROJECT}.config

rel-dev: deps app
	@${RM_RF} ../${PROJECT}-dev
	git clone git@github.com:botsunit/${PROJECT}.git ../${PROJECT}-dev
	@${CP_R} ebin ../${PROJECT}-dev
	@${CP_R} config ../${PROJECT}-dev
	@${CP_R} include ../${PROJECT}-dev
	cd ../${PROJECT}-dev; git add . 
	cd ../${PROJECT}-dev; git commit -m "Update ${DATE}"

