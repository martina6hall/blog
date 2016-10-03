default: out/prefixed.css js/b.min.js
	piccolo

out/prefixed.css: out/built.css
	./node_modules/.bin/cssmin out/built.css | ./node_modules/.bin/autoprefixer --output out/prefixed.css

out/built.css: css/b/base.css bower_components/google-code-prettify/src/prettify.css
	-mkdir out
	awk 'FNR==1{print ""}{print}' $^ > out/built.css

js/b.min.js: bower_components/google-code-prettify/src/prettify.js js/base.js
	awk 'FNR==1{print ""}{print}' $^ | ./node_modules/.bin/uglifyjs --compress --output $@ -

pub:
	piccolo
	./bin/pub
	./bin/hubping

deps:
	npm update
	./node_modules/.bin/bower update

clean:
	find ./dst -name "*.html" | xargs rm

watch:
	./bin/waitforit.sh

serve:
	cd ./dst ; http-server -a 127.0.0.1

setup:
	go get -u github.com/jcgregorio/piccolo
	go get -u github.com/jcgregorio/piccolo

server:
	go get -u github.com/jcgregorio/userve/go/userve
	./build_release

