//
//  DeckTests.swift
//  SwiftyDeck_Example
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftyDeck

class DeckTests: QuickSpec {
    override func spec() {
        describe("standard decks") {
            it("should pass the single deck test") {
                let shuffledDeck = Deck.standard()
                let sortedDeck = Deck.standard(shuffled: false)
                
                for deck in [shuffledDeck, sortedDeck] {
                    self.testSingleDeck(deck)
                }
            }
        }
        
        describe("deck deal") {
            it("should pass all of dem") {
                var deck = Deck.standard()
                var emptyShoe: [Card] = []
                (0..<SwiftyDeckTests.trueDeckCount).forEach { (_) in
                    let draw = deck.deal()
                    
                    switch draw {
                    case .success(let card):
                        emptyShoe.append(card)
                    case .failure(let error):
                        fail("Should've not thrown \(error).")
                    }
                }
                expect(deck.count) == 0
                expect(emptyShoe).to(haveCount(SwiftyDeckTests.trueDeckCount))
                expect(Set(Deck.standard().cards)) == Set(emptyShoe)
                
                // Error: Drawing on empty deck
                let expectedError = DeckError.notEnoughCards(deckCount: 0, drawCount: 1)
                let result = deck.deal()
                self.testSingleError(on: result, expectedError: expectedError)
            }
        }
    }
}

extension DeckTests {
    private func testSingleDeck(_ deck: Deck) {
        expect(deck.count) == SwiftyDeckTests.trueDeckCount

        // Rank test: Every deck has to have <trueSuitCount> cards of the same rank.
        for rank in Rank.allCases {
            expect(deck.cards.filter({ (card) -> Bool in
                return card.rank == rank
            }).count) == SwiftyDeckTests.trueSuitCount
        }
        
        // Suit test: Every deck has to have <trueRankCount> cards of the same suit.
        for suit in Suit.allCases {
            expect(deck.cards.filter({ (card) -> Bool in
                return card.suit == suit
            }).count) == SwiftyDeckTests.trueRankCount
        }
        
        // Duplication test: Every deck has to have <trueDeckCount> cards, without duplication.
        let cardSet = Set(deck.cards)
        expect(cardSet.count) == SwiftyDeckTests.trueDeckCount
    }
    private func testSingleError<T: Any>(on result: Result<T, Error>, expectedError: DeckError) {
        switch result {
        case .success:
            fail("Test should fail with \(expectedError).")
        case .failure(let error):
            expect(error).to(matchError(expectedError))
        }
    }
}
