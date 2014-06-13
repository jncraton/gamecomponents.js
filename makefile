%.js: %.coffee
	coffee -c $^

web.js: hexboard.js cardset.js main.js
	cat $^ > $@