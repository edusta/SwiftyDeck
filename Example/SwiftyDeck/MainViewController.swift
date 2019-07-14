//
//  MainViewController.swift
//  SwiftyDeck
//
//  Created by Engin Deniz Usta on 07/13/2019.
//  Copyright (c) 2019 Engin Deniz Usta. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var informationLabel: UILabel!

    private let interactor = MainInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.interactor.delegate = self
    }
    
    @IBAction private func shuffledDeckAction(_ sender: UIBarButtonItem) {
        self.interactor.setupShuffledDeck()
    }
    @IBAction private func sortedDeckAction(_ sender: UIBarButtonItem) {
        self.interactor.setupSortedDeck()
    }
    @IBAction private func dealAction(_ sender: UIButton) {
        interactor.dealNow()
    }
}

extension MainViewController: MainInteractorDelegate {
    func render(state: MainInteractorState) {
        DispatchQueue.main.async {
            switch state {
            case .informational(let info):
                self.setLabelText(info)
            case .dealtHand(let cardInfo):
                self.setLabelText(cardInfo)
            case .errored(let errorInfo):
                self.setLabelText(errorInfo)
            }
        }
    }
    
    private func setLabelText(_ text: String) {
        self.informationLabel.text = text
    }
}
