PROJECT = plumber

DEPS = lager doteki
dep_lager = git https://github.com/basho/lager.git master
dep_doteki = git https://github.com/botsunit/doteki.git master

DOC_DEPS = edown
dep_edown = git https://github.com/botsunit/edown.git master

include erlang.mk

EDOC_OPTS = {doclet, edown_doclet} \
						, {app_default, "http://www.erlang.org/doc/man"} \
						, {source_path, ["src"]} \
						, {overview, "overview.edoc"} \
						, {stylesheet, ""} \
						, {image, ""} \
						, {top_level_readme, {"./README.md", "https://github.com/botsunit/${PROJECT}"}}

dev: deps app
	@erl -pa ebin include deps/*/ebin deps/*/include -config config/${PROJECT}.config

