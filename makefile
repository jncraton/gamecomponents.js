all: dist/gamecomponents.js

build/%.js: src/%.coffee
	coffee -o build -c $^

dist/gamecomponents.js: build/gamecomponent.js build/hexboard.js build/cardset.js
	cat $^ > $@