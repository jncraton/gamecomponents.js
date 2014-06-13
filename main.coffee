w = 9
h = 9

board = new HexBoard(w, h, 1000, 1000)
card_set = new CardSet()
card_set.draw('cards')

console.log('total hexes', board.getHexes().length)

players = ['red', 'green', 'blue', 'brown']
turn = 0

setStart = (x,y,color) ->
    hex = board.getHex(x,y)
    
    if (hex)
        hex.fill = color
        hex.note = 'POP'

setStart(0,0,'red')
setStart(0,h-1,'green')
setStart(w-1,0,'blue')
setStart(w-1,h-1,'brown')

doTurn = (color) ->
    timer = setTimeout(() -> 
        doTurn(players[turn % 4])
        turn += 1
        board.draw('board')
    , 20)

    if (color)
        hexes = board.getHexes().sort (a, b) ->
            return Math.random() - Math.random()

        for hex in hexes
            if (hex.fill == color)
                for hex in board.getAdjacent(hex)
                    if (!hex.fill) 
                        if Math.random() > (5/80)
                            hex.fill = color
                            if Math.random() > .5
                                if Math.random() > .5
                                    hex.note = 'POP'
                                else
                                    hex.note = 'MAT'
                        else
                            hex.fill = 'black'
                            hex.textColor = 'white'
                            hex.note = 'HAZ'
                        return
        
        clearTimeout(timer)
        console.log('no move for ' + color)

doTurn()

