//
//  Deck.swift
//  SwiftyDeck
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 EDUsta. All rights reserved.
//

import Foundation

public enum DeckError: Error, Equatable {
    case invalidDrawCount(drawCount: Int)
    case notEnoughCards(deckCount: Int, drawCount: Int)
}

public struct Deck: Drawable {
    public private(set) var cards: [Card]
    public var count: Int {
        return cards.count
    }
    
    public static func standard(shuffled: Bool) -> Deck {
        let cards = Rank.allCases.flatMap { (rank) -> [Card] in
            return Suit.allCases.map({ (suit) -> Card in
                return Card(suit: suit, rank: rank)
            })
        }
        
        return Deck(cards: shuffled ? cards.shuffled() : cards)
    }

    public mutating func deal() -> Result<Card, Error> {
        let result = draw(randomly: false, drawCount: 1)
        
        switch result {
        case .success(let cards):
            return .success(cards.first!)
        case .failure(let error):
            return .failure(error)
        }
    }
    public mutating func draw(randomly: Bool, drawCount: Int) -> Result<[Card], Error> {
        guard drawCount > 0 else {
            return .failure(DeckError.invalidDrawCount(drawCount: drawCount))
        }
        guard self.count >= drawCount else {
            return .failure(DeckError.notEnoughCards(deckCount: self.count, drawCount: drawCount))
        }
        
        let drawnCards = (0..<drawCount).map({ (_) -> Card in
            // We can safely unwrap the results;
            // Since we are sure that the Array has enough Cards.
            return (randomly ? self.cards.popRandom() : self.cards.popLast())!
        })
        
        guard drawnCards.count == drawCount else {
            return .failure(DeckError.invalidDrawCount(drawCount: drawCount))
        }

        return .success(drawnCards)
    }
}

extension Array where Element == Card {
    mutating func popRandom() -> Element? {
        guard let element = randomElement() else { return nil }
        guard let elementIndex = firstIndex(where: { $0 == element }) else { return nil }
        
        return remove(at: elementIndex)
    }
}
