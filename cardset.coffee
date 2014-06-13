class CardSet
    deck = [1,2,3]
    discard = []
    hand = []
    active = []

    constructor: (@x_res = 1000, @y_res = 1000) ->

    draw: (canvas_id) ->
        canvas = document.getElementById(canvas_id)
        context = canvas.getContext('2d')
        canvas.width = @x_res
        canvas.height = @y_res
        context.clearRect(0, 0, canvas.width, canvas.height);
        
        context.font = 'normal 20pt Sans'
        context.textAlign = 'center'
        context.textBaseline = 'middle'
        
        context.moveTo(5,5)
        context.lineTo(5, 305)
        context.lineTo(205, 305)
        context.lineTo(205, 5)
        context.lineTo(5, 5)
        context.strokeStyle = "black"
        context.lineWidth = 5
        context.stroke()

(exports ? this).CardSet = CardSet