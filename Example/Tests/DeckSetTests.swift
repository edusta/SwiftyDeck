//
//  DeckSetTests.swift
//  SwiftyDeck_Tests
//
//  Created by engin on 14.07.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftyDeck

class DeckSetTests: QuickSpec {
    override func spec() {        
        describe("deckSet initialization") {
            (1...100).forEach { index in
                let newDeck = DeckSet(deckCount: index, shuffled: true)
                
                expect(newDeck.count) == SwiftyDeckTests.trueDeckCount * index
            }
        }
    }
}
