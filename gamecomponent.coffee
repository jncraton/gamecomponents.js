class GameComponent
    handlers = {}

    constructor: (@x_res = 1000, @y_res = 1000) ->
    
    addEventListener: (name, cb) ->
        handlers[name] = cb
    
    trigger: (event_name, arg) ->
        if handlers[event_name]
            handlers[event_name](arg)
    
    getContext: (canvas_id) ->
        if @canvasId != canvas_id
            @canvasId = canvas_id

            canvas = document.getElementById(canvas_id)
            canvas.width = @x_res
            canvas.height = @y_res
            @context = canvas.getContext('2d')
            @context.font = 'normal 20pt Sans'
            @context.textAlign = 'center'
            @context.textBaseline = 'middle'
            @context.strokeStyle = "black"
            @context.lineWidth = 5
            
            if (@click)
                canvas.addEventListener('click', ((e) -> 
                    e.cx = e.offsetX * (e.target.width / e.target.scrollWidth)
                    e.cy = e.offsetY * (e.target.height / e.target.scrollHeight)
                    @click(e)
                ).bind(this))
        
        @context.clearRect(0, 0, @x_res, @y_res);
            
        return @context

    strokePath: (points) ->
        @context.beginPath()

        @context.moveTo(points[0][0], points[0][1])
        @context.lineTo(point[0], point[1]) for point in points[1..]
        @context.lineTo(points[0][0], points[0][1])

        @context.stroke()

(exports ? this).GameComponent = GameComponent