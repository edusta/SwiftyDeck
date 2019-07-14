//
//  DeckSet.swift
//  SwiftyDeck
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 EDUsta. All rights reserved.
//

import Foundation

public struct DeckSet: Drawable {
    public private(set) var deckCount: Int
    public private(set) var combinedDeck: Deck
    
    public var count: Int {
        return combinedDeck.count
    }
    public var cards: [Card] {
        return combinedDeck.cards
    }
    
    public static func standard() -> DeckSet {
        return DeckSet(deckCount: 4, shuffled: true)
    }
    
    public init(deckCount: Int, shuffled: Bool) {
        self.deckCount = deckCount
        
        let decks = (0..<deckCount).map { (_) -> Deck in
            return Deck.standard(shuffled: shuffled)
        }
        self.combinedDeck = Deck(cards: decks.flatMap({ (deck) -> [Card] in
            return deck.cards
        }))
    }

    public mutating func deal() -> Result<Card, Error> {
        return combinedDeck.deal()
    }
}
