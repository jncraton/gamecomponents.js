class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = []
    active = []

    constructor: (@x_res = 1000, @y_res = 1000) ->

    paint: (canvas_id) ->
        context = @getContext(canvas_id)

        context.beginPath()
        context.moveTo(5,5)
        context.lineTo(5, 305)
        context.lineTo(205, 305)
        context.lineTo(205, 5)
        context.lineTo(5, 5)
        context.stroke()
        
        context.fillText("Deck", 100, 100)

(exports ? this).CardSet = CardSet