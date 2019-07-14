//
//  MainViewInteractor.swift
//  SwiftyDeck_Example
//
//  Created by engin on 14.07.2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyDeck

enum MainInteractorState {
    case informational(info: String)
    case dealtHand(cardInfo: String)
    case errored(errorInfo: String)
}

protocol MainInteractorDelegate: AnyObject {
    func render(state: MainInteractorState)
}

final class MainInteractor: NSObject {
    var currentDeck: Deck = Deck.standard(shuffled: true)
    
    weak var delegate: MainInteractorDelegate? {
        didSet {
            delegate?.render(state: .informational(info: "<SwiftyDeck>"))
        }
    }

    func setupShuffledDeck() {
        self.currentDeck = Deck.standard(shuffled: true)
        delegate?.render(state: .informational(info: "Shuffled Deck is Ready!"))
    }
    func setupSortedDeck() {
        self.currentDeck = Deck.standard(shuffled: false)
        delegate?.render(state: .informational(info: "Sorted Deck is Ready!"))
    }
    
    func dealNow() {
        let result = self.currentDeck.deal()
        
        switch result {
        case .success(let card):
            delegate?.render(state: .dealtHand(cardInfo: card.description))
        case .failure(let error):
            delegate?.render(state: .errored(errorInfo: error.localizedDescription))
        }
    }
}
