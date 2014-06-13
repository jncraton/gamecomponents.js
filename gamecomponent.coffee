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

    strokePath: (points) ->
        @context.beginPath()
        @context.moveTo(points[0][0], points[0][1])
        
        for point in points[1..]
            @context.lineTo(point[0], point[1])

        @context.lineTo(points[0][0], points[0][1])
        @context.stroke()

(exports ? this).GameComponent = GameComponent