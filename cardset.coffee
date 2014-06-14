class CardSet extends GameComponent
    deck = []
    discard = []
    hand = []
    active = []
    card_width = 150
    
    click: (e) ->
        x = e.offsetX * (e.target.width / e.target.scrollWidth)
        y = e.offsetY * (e.target.height / e.target.scrollHeight)
        
        x = Math.floor(x / (card_width + 10))
        y = Math.floor((y - 300) / ((card_width * 1.5 + 10)))

        card = x + y * 5
        
        if card >= 0 and card < hand.length
            hand[card].handIndex = card
            @trigger('cardActivated', hand[card])

    gain: (card) ->
        discard.push(card)
    
    shuffle: () ->
        deck = deck.concat(discard).sort -> 
            Math.random() - Math.random()
        discard = []
    
    discard: (pos) ->
        if hand[pos]
            discard.push(hand.splice(pos, 1))

    draw: () ->
        if deck.length == 0
            @shuffle()
            
        if deck.length > 0
            hand.push(deck.pop())

    paintCard: (x, y, text = '') ->
        x += 5
        y += 5
    
        @strokePath([
            [x, y]
            [x, y+card_width*1.5]
            [x+card_width, y+card_width*1.5]
            [x+card_width, y]
        ])
        
        @context.fillText(text, x+card_width/2, y+card_width/2)

    paint: (canvas_id) ->
        @getContext(canvas_id)
        
        @paintCard(0,0, "Deck (" + deck.length + ')')
        @paintCard(card_width + 10,0, "Discard (" + discard.length + ')')

        for card, i in hand
            @paintCard((card_width + 10) * (i % 5),300 + (card_width * 1.5 + 10) * Math.floor(i/5), card)
(exports ? this).CardSet = CardSet