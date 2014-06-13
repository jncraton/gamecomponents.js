class CardSet extends GameComponent
    deck = [1,2,3,4,5,6,7,8,9,10]
    discard = []
    hand = []
    active = []
    card_width = 150
    
    discard: (pos) ->
        if hand[pos]
            discard.push(hand.splice(pos, 1))

    draw: () ->
        # Shuffle if we are out of cards
        if deck.length == 0
            deck = deck.concat(discard).sort -> 
                Math.random() - Math.random()
            discard = []
        
        # Move a card from deck to hand
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