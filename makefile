%.js: %.coffee
	coffee -c $^

%.js: %.litcoffee
	coffee -c $^

web.js: gamecomponent.js hexboard.js cardset.js main.js
	cat $^ > $@