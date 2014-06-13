class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = [1,2,3,4]
    active = []
    card_width = 200

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
        
        @paintCard(150,0, "Deck (" + deck.length + ')')
        @paintCard(550,0, "Discard (" + discard.length + ')')

        for card, i in hand
            @paintCard((card_width + 10) * i,400, card)
(exports ? this).CardSet = CardSet