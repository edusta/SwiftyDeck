//
//  Card.swift
//  Nimble
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 EDUsta. All rights reserved.
//

import Foundation

public enum Suit: String, CaseIterable {
    case spades, hearts, diamonds, clubs
}
public enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
}

public struct Card: Hashable, Equatable {
    public let suit: Suit
    public let rank: Rank
    
    public init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}
