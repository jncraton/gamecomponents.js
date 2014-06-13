class CardSet extends GameComponent
    deck = [1,2,3]
    discard = []
    hand = [1,2,3,4]
    active = []

    paintCard: (x, y, text = '') ->
        @strokePath([
            [x+5, y+5]
            [x+5, y+305]
            [x+205, y+305]
            [x+205, y+5]
        ])
        
        @context.fillText(text, x+100, y+100)

    paint: (canvas_id) ->
        @getContext(canvas_id)
        
        @paintCard(150,0, "Deck (" + deck.length + ')')
        @paintCard(550,0, "Discard (" + discard.length + ')')

        for card, i in hand
            @paintCard(210 * i,400, card)
(exports ? this).CardSet = CardSet