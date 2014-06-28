class CardSet extends GameComponent
    card_width = 150
    
    constructor: ->
        @deck = []
        @discardPile = []
        @hand = []
        super()
    
    click: (e) ->
        x = Math.floor(e.cx / (card_width + 10))
        y = Math.floor((e.cy - 300) / ((card_width * 1.5 + 10)))

        card = x + y * 5
        
        if card >= 0 and card < @hand.length
            @hand[card].handIndex = card
            @trigger('cardActivated', @hand[card])

    gain: (card) ->
        @discardPile.push(card)
    
    shuffle: () ->
        @deck = @deck.concat(@discardPile)
        @discardPile = []
        
        tmp = []
        
        for i in [0...@deck.length]
            tmp.push(@deck.splice(Math.random() * @deck.length, 1)[0])
                
        @deck = tmp
        
    getHandCardByName: (name) ->
        for card, i in @hand
            if card.name == name
                card.handIndex = i
                return card
        return null
    
    discard: (pos) ->
        if @hand[pos]
            @discardPile.push(@hand.splice(pos, 1)[0])

    trash: (pos) ->
        if @hand[pos]
            @hand.splice(pos, 1)

    draw: () ->
        if @deck.length == 0
            @shuffle()
            
        if @deck.length > 0
            @hand.push(@deck.pop())

    paintCard: (x, y, card) ->
        x += 5
        y += 5
    
        @strokePath([
            [x, y]
            [x, y+card_width*1.5]
            [x+card_width, y+card_width*1.5]
            [x+card_width, y]
        ])
        
        @context.fillText(card.name, x+card_width/2, y+card_width/2)

    paint: (canvas_id) ->
        @getContext(canvas_id)
        
        @paintCard(0,0, {name: "Deck (" + @deck.length + ')'})
        @paintCard(card_width + 10,0, {name: "Discard (" + @discardPile.length + ')'})
        
        for card, i in @hand
            @paintCard((card_width + 10) * (i % 5),300 + (card_width * 1.5 + 10) * Math.floor(i/5), card)
(exports ? this).CardSet = CardSet