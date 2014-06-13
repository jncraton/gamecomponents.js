class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = []
    active = []

    constructor: (@x_res = 1000, @y_res = 1000) ->

    paintCard: (x, y, text = '') ->
        @strokePath([
            [x+5, y+5]
            [x+5, y+305]
            [x+205, y+305]
            [x+205, y+5]
        ])
        
        @context.fillText(text, 100, 100)

    paint: (canvas_id) ->
        @getContext(canvas_id)
        
        @paintCard(0,0, "Deck")

(exports ? this).CardSet = CardSet