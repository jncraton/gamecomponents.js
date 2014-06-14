all: example1.js gamecomponents.js

%.js: %.coffee
	coffee -c $^

%.js: %.litcoffee
	coffee -c $^

gamecomponents.js: gamecomponent.js hexboard.js cardset.js
	cat $^ > $@