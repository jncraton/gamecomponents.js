class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = []
    active = []

    constructor: (@x_res = 1000, @y_res = 1000) ->

    draw: (canvas_id) ->
        context = @getContext(canvas_id)

        context.moveTo(5,5)
        context.lineTo(5, 305)
        context.lineTo(205, 305)
        context.lineTo(205, 5)
        context.lineTo(5, 5)
        context.stroke()

(exports ? this).CardSet = CardSet