//
//  Array+Extension.swift
//  SwiftyDeck
//
//  Created by engin on 20.10.2019.
//

extension Array where Element == Card {
    mutating func popRandom() -> Element? {
        guard let element = randomElement() else { return nil }
        guard let elementIndex = firstIndex(where: { $0 == element }) else { return nil }
        
        return remove(at: elementIndex)
    }
}
