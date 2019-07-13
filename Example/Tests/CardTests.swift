//
//  CardTests.swift
//  SwiftyDeck_Example
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftyDeck

class CardTests: QuickSpec {
    override func spec() {
        expect(Rank.allCases).to(haveCount(SwiftyDeckTests.trueRankCount))
        expect(Suit.allCases).to(haveCount(SwiftyDeckTests.trueSuitCount))
    }
}
