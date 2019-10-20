//
//  DeckTests.swift
//  SwiftyDeck_Tests
//
//  Created by engin on 13.07.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import SwiftyDeck

class DeckTests: QuickSpec {
    override func spec() {
        var deck: Deck!
        var trueCardsSet: Set<Card>!
        beforeEach {
            deck = Deck.standard(shuffled: true)
            trueCardsSet = Set(deck.cards)
        }
        
        describe("standard decks") {
            it("should pass the single deck test") {
                let shuffledDeck = Deck.standard(shuffled: true)
                let sortedDeck = Deck.standard(shuffled: false)
                
                for deck in [shuffledDeck, sortedDeck] {
                    self.testSingleDeck(deck)
                }
            }
        }
        describe("deck deal") {
            it("should pass all of dem") {
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
                expect(Set(emptyShoe)) == trueCardsSet
                
                // Error: Drawing on empty deck
                let expectedError = DeckError.notEnoughCards(deckCount: 0, drawCount: 1)
                print(expectedError.localizedDescription)
                let result = deck.deal()
                self.testSingleError(on: result, expectedError: expectedError)
            }
        }
        
        describe("deck draws") {
            context("randomly") {
                it("should fetch all the deck") {
                    let result = deck.draw(randomly: true, drawCount: SwiftyDeckTests.trueDeckCount)
                    expect {
                        let cards = try result.get()
                        expect(Set(cards)) == trueCardsSet
                        return nil
                    }.notTo(throwError(errorType: DeckError.self))
                }
                it("should not be able to fetch more than the deck has") {
                    let result = deck.draw(randomly: true, drawCount: SwiftyDeckTests.trueDeckCount + 1)
                    expect { try result.get() }.to(throwError(errorType: DeckError.self))
                }
                it("should not be able to fetch < 1 cards") {
                    let result = deck.draw(randomly: true, drawCount: -1)
                    expect { try result.get() }.to(throwError(errorType: DeckError.self))
                }
            }
            context("standard") {
                it("should fetch all the deck") {
                    let result = deck.draw(randomly: false, drawCount: SwiftyDeckTests.trueDeckCount)
                    expect {
                        let cards = try result.get()
                        expect(Set(cards)) == trueCardsSet
                        return nil
                    }.notTo(throwError(errorType: DeckError.self))
                }
                it("should not be able to fetch more than the deck has") {
                    let result = deck.draw(randomly: false, drawCount: SwiftyDeckTests.trueDeckCount + 1)
                    expect { try result.get() }.to(throwError(errorType: DeckError.self))
                }
                it("should not be able to fetch < 1 cards") {
                    let result = deck.draw(randomly: false, drawCount: -1)
                    expect { try result.get() }.to(throwError(errorType: DeckError.self))
                }
            }
        }
    }
}

extension DeckTests {
    private func testSingleDeck(_ deck: Deck) {
        // Count test: Every deck has to have <trueDeckCount> cards.

        expect(deck.count) == SwiftyDeckTests.trueDeckCount

        // Rank test: Every deck has to have <trueSuitCount> cards of the same rank.
        for rank in Rank.allCases {
            expect(deck.cards.filter({ (card) -> Bool in
                return card.rank == rank
            })).to(haveCount(SwiftyDeckTests.trueSuitCount))
        }
        
        // Suit test: Every deck has to have <trueRankCount> cards of the same suit.
        for suit in Suit.allCases {
            expect(deck.cards.filter({ (card) -> Bool in
                return card.suit == suit
            })).to(haveCount(SwiftyDeckTests.trueRankCount))
        }
        
        // Duplication test: Every deck has to have <trueDeckCount> cards, without duplication.
        let cardSet = Set(deck.cards)
        expect(cardSet).to(haveCount(SwiftyDeckTests.trueDeckCount))    
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
