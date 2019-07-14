//
//  Drawable.swift
//  SwiftyDeck
//
//  Created by engin on 14.07.2019.
//  Copyright © 2019 EDUsta. All rights reserved.
//

import Foundation

public protocol Drawable {
    var count: Int { get }
    var cards: [Card] { get }
    
    mutating func deal() -> Result<Card, Error>
}
