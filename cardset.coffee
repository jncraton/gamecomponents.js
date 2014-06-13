class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = []
    active = []

    constructor: (@x_res = 1000, @y_res = 1000) ->

    paintCard: (context, x, y, text = '') ->
        context.beginPath()
        context.moveTo(x+5, y+5)
        context.lineTo(x+5, y+305)
        context.lineTo(x+205, y+305)
        context.lineTo(x+205, y+5)
        context.lineTo(x+5, y+5)
        context.stroke()
        
        context.fillText(text, 100, 100)

        

    paint: (canvas_id) ->
        context = @getContext(canvas_id)
        
        @paintCard(context, 0,0, "Deck")

(exports ? this).CardSet = CardSet