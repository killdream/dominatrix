bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
doxx       = $(bin)/doxx
uglify     = $(bin)/uglifyjs
VERSION    = $(shell node -e 'console.log(require("./package.json").version)')


lib: src/*.ls
	$(lsc) -o lib -c src/*.ls

dist:
	mkdir -p dist

dist/dominatrix.umd.js: compile dist
	$(browserify) lib/index.js --standalone Dominatrix > $@

dist/dominatrix.umd.min.js: dist/dominatrix.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/dominatrix.umd.js

minify: dist/dominatrix.umd.min.js

compile: lib

documentation: compile
	$(doxx) --source lib  \
	        --target docs

clean:
	rm -rf dist build lib

test:
	$(lsc) test/tap.ls

package: compile documentation bundle minify
	mkdir -p dist/dominatrix-$(VERSION)
	cp -r docs/literate dist/dominatrix-$(VERSION)/docs
	cp -r lib dist/dominatrix-$(VERSION)
	cp dist/*.js dist/dominatrix-$(VERSION)
	cp package.json dist/dominatrix-$(VERSION)
	cp README.md dist/dominatrix-$(VERSION)
	cp LICENCE dist/dominatrix-$(VERSION)
	cd dist && tar -czf dominatrix-$(VERSION).tar.gz dominatrix-$(VERSION)

publish: clean
	npm install
	npm publish

bump:
	node tools/bump-version.js $$VERSION_BUMP

bump-feature:
	VERSION_BUMP=FEATURE $(MAKE) bump

bump-major:
	VERSION_BUMP=MAJOR $(MAKE) bump

.PHONY: test bump bump-feature bump-major publish package clean documentation
