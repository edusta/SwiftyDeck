//
//  Card.swift
//  SwiftyDeck
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 EDUsta. All rights reserved.
//

import Foundation

public enum Suit: String, CaseIterable, CustomStringConvertible {
    case spades, hearts, diamonds, clubs
    
    public var description: String {
        switch self {
        case .spades: return "♠"
        case .hearts: return "♥"
        case .diamonds: return "♦"
        case .clubs: return "♣"
        }
    }
}
public enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
}

public struct Card: Hashable, Equatable, CustomStringConvertible {
    public let suit: Suit
    public let rank: Rank
    
    public init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    public var description: String {
        return "\(rank) of \(suit)"
    }
}
