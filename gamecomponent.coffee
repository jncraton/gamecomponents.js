class GameComponent
    constructor: (@x_res = 1000, @y_res = 1000) ->

    getContext: (canvas_id) ->
        canvas = document.getElementById(canvas_id)
        @context = canvas.getContext('2d')
        canvas.width = @x_res
        canvas.height = @y_res
        @context.clearRect(0, 0, canvas.width, canvas.height);
        
        @context.font = 'normal 20pt Sans'
        @context.textAlign = 'center'
        @context.textBaseline = 'middle'
        @context.strokeStyle = "black"
        @context.lineWidth = 5
        
        return @context

(exports ? this).GameComponent = GameComponent