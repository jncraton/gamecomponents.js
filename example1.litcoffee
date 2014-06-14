Begin by creating a 9x9 hex board:

    w = 9
    h = 9

    board = new HexBoard(w, h)

Populate the board with different types of hexes

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

Add a basic event listener on hex activation (clicks):

    board.addEventListener('hexActivated', (hex) ->
        hex.fill = 'gray'
        board.paint('board')
    )
    
Create a set of cards to play with:

    card_set = new CardSet()
    for i in [1..20]
        card_set.gain({text: i})

Create an event listener to discard cards on click:

    card_set.addEventListener('cardActivated', (card) ->
        console.log('Selected card ' + card.handIndex)
        card_set.discard(card.handIndex)
        card_set.draw()
        card_set.paint('cards')
    )

Create the starting players:

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

Simulate some basic turns:

    doTurn = (color) ->
        timer = setTimeout(() -> 
            doTurn(players[turn % 4])
            turn += 1
            board.paint('board')
            
            card_set.discard(Math.floor(Math.random() * 10))
            card_set.discard(Math.floor(Math.random() * 10))
            card_set.draw()
            card_set.paint('cards')
        , 20)

        if (color)
            hexes = board.getHexes().sort (a, b) ->
                return Math.random() - Math.random()

            for hex in hexes
                if (hex.fill == color)
                    for hex in board.getAdjacent(hex)
                        if (!hex.fill) 
                            hex.fill = color
                            return
            
            clearTimeout(timer)
            console.log('no move for ' + color)

    doTurn()

