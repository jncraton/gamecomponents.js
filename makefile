%.js: %.coffee
	coffee -c $^

%.js: %.litcoffee
	coffee -c $^

example1_web.js: gamecomponent.js hexboard.js cardset.js example1.js
	cat $^ > $@