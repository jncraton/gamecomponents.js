board_size = 5
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
    hex.fill = ''
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
        hex.textColor = 'black'
        
    player = {
        color: color,
        home: {x: x, y: y}
    }
    
    player.prod_deck = new CardSet()
    player.prod_deck.gain({name:'Explorer'})
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

    end_turn = () ->
        player.prod_deck.discard(0)
        player.prod_deck.discard(0)
        player.prod_deck.discard(0)
        if player.prod_deck.deck.length == 0
            player.prod_deck.shuffle()
        else if player.prod_deck.deck.length == 1
            player.prod_deck.draw()
        else if player.prod_deck.deck.length == 2
            player.prod_deck.draw()
            player.prod_deck.draw()
        else
            player.prod_deck.draw()
            player.prod_deck.draw()
            player.prod_deck.draw()


    if (player)
        console.log('Starting turn for ' + player.color)
        console.log('Hand:')
        for card in player.prod_deck.hand
            console.log('    ' + card.name)
        # Try exploring
        explorer = player.prod_deck.getHandCardByName('Explorer')
        if explorer
            player.prod_deck.discard(explorer.handIndex)
            hexes = board.getHexes().sort (a, b) ->
                return Math.random() - Math.random()

            for hex in hexes
                if (hex.fill == player.color)
                    for hex in board.getAdjacent(hex)
                        if (!hex.fill) 
                            hex.fill = player.color
                            if (hex.note == 'MAT')
                                player.prod_deck.gain({name: 'Salvager'})
                            if (hex.note == 'POP')
                                player.prod_deck.gain({name: 'Explorer'})
                            if (!hex.note)
                                player.prod_deck.gain({name: 'Solar Array'})
                            end_turn()
                            return
        
        #clearTimeout(timer)
        end_turn()
        console.log('no move for ' + player.color)

doTurn()

