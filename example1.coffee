board_size = 9
board = new HexBoard(board_size, board_size)

for hex in board.getHexes()
    if Math.random() > (5/80)
        if Math.random() > .5
            if Math.random() > .5
                hex.note = 'POP'
            else
                hex.note = 'MAT'
    else
        hex.fill = 'black'
        hex.textColor = 'white'
        hex.note = 'HAZ'

board.addEventListener('hexActivated', (hex) ->
    hex.fill = 'gray'
    board.paint('board')
)

colors = ['red', 'green', 'blue', 'brown']
players = []
turn = 0

initPlayer = (x,y,color) ->
    hex = board.getHex(x,y)
    
    if (hex)
        hex.fill = color
        hex.note = 'POP'
        
    player = {
        color: color,
        home: {x: x, y: y}
    }
    
    player.prod_deck = new CardSet()
    player.prod_deck.gain({name:'Explorer'})
    player.prod_deck.gain({name:'Solar Array'})
    player.prod_deck.gain({name:'Salvager'})
    player.prod_deck.draw()
    player.prod_deck.draw()
    player.prod_deck.draw()
    
    players.push(player)

initPlayer(0,0,'red')
initPlayer(0,board_size-1,'green')
initPlayer(board_size-1,0,'blue')
initPlayer(board_size-1,board_size-1,'brown')

doTurn = (player) ->
    timer = setTimeout(() -> 
        doTurn(players[turn % 4])
        turn += 1
        board.paint('board')
        if player
            player.prod_deck.paint('cards')
    , 20)

    if (player)
        # Try exploring
        explorer = player.prod_deck.getHandCardByName('Explorer')
        solar_array = player.prod_deck.getHandCardByName('Solar Array')
        if explorer and solar_array
            player.prod_deck.discard(explorer.handIndex)
            player.prod_deck.discard(solar_array.handIndex)
            hexes = board.getHexes().sort (a, b) ->
                return Math.random() - Math.random()

            for hex in hexes
                if (hex.fill == player.color)
                    for hex in board.getAdjacent(hex)
                        if (!hex.fill) 
                            hex.fill = player.color
                            return
        
        clearTimeout(timer)
        console.log('no move for ' + player.color)

doTurn()

