all: dist/gamecomponents.js dist/gamecomponents.min.js

build/%.js: src/%.coffee
	coffee -o build -c $^

dist/gamecomponents.js: build/gamecomponent.js build/hexboard.js build/cardset.js
	cat $^ > $@
	
dist/gamecomponents.min.js: dist/gamecomponents.js
	java -jar tools/yuicompressor-2.4.8.jar $^ > $@