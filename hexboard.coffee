class HexBoard extends GameComponent
    hexes = []

    constructor: (@width, @height, @x_res = 2000, @y_res = 2000) ->
        hexes = (({'x': x, 'y': y} for y in [0...@height-x%2]) for x in [0...@width])
    
    forEachHex: (cb) ->
        ((cb(hexes[x][y]) for y in [0...@height-x%2]) for x in [0...@width])
        
    getHexes: () ->
        [].concat.apply([], hexes)

    getHex: (x,y) ->
        hexes[x][y]

    getAdjacent: (center) ->
        x = center.x
        y = center.y

        ret = []

        width = @width
        height = @height

        push = (x, y) -> 
            if (hexes[x] and hexes[x][y])
                ret.push(hexes[x][y])
                
        push(x,y-1)
        push(x, y+1)
        push(x+1, y)
        push(x-1, y)
        push(x+1, y + 1 + (-2) * ((x + 1) % 2))
        push(x-1, y + 1 + (-2) * ((x + 1) % 2))

        return ret
    
    draw: (canvas_id) ->
        context = @getContext(canvas_id)
        
        x_radius = (@x_res) / ( @width * 1.5)
        y_radius = (@y_res) / ( @height * 2.0 * 0.86602540378)
        hex_radius = Math.min(x_radius - (.25 * x_radius / @width), 
                              y_radius - (0.86602540378 * y_radius / @width)) - 1
        
        @forEachHex (hex) ->
            sin30 = .5 * hex_radius
            cos30 = 0.86602540378 * hex_radius
            
            center = [
                hex_radius + (sin30 + hex_radius) * hex.x
                hex_radius + cos30 * 2 * hex.y + cos30 * (hex.x % 2)
            ]
            
            verts = [
                [center[0] - sin30, center[1] - cos30]
                [center[0] + sin30, center[1] - cos30]
                [center[0] + hex_radius, center[1]]
                [center[0] + sin30, center[1] + cos30]
                [center[0] - sin30, center[1] + cos30]
                [center[0] - hex_radius, center[1]]
            ]
            
            context.beginPath()
            context.moveTo(verts[0][0], verts[0][1])
            context.lineTo(vert[0], vert[1]) for vert in verts
            context.lineTo(verts[0][0], verts[0][1])
            
            context.fillStyle = hex.fill or "gray"
            context.fill()
            
            context.strokeStyle = hex.border or "black"
            context.stroke()
            
            context.fillStyle = hex.textColor or "black"
            context.fillText(hex.note or '', center[0], center[1])
        
(exports ? this).HexBoard = HexBoard