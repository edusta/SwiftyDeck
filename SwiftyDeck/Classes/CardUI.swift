//
//  CardUI.swift
//  SwiftyDeck
//
//  Created by engin on 17.07.2019.
//

import UIKit

public final class CardUI: NSObject {
    private static var bundle: Bundle {
        return Bundle(for: CardUI.self)
    }
    
    public static func imageOf(card: Card) -> UIImage? {
        return UIImage(named: card.imageName, in: bundle, compatibleWith: nil)
    }
}
