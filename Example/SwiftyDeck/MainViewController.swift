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
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var cardContainerView: UIView!
    
    private let interactor = MainInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupInteractor()
        self.setupCardContainerView()
    }
    
    private func setupInteractor() {
        self.interactor.delegate = self
    }
    
    private func setupCardContainerView() {
        self.cardContainerView.layer.borderColor = UIColor.black.cgColor
        self.cardContainerView.layer.borderWidth = 1
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
                self.setCardImage(nil)
            case .dealtHand(let cardInfo, let image):
                self.setLabelText(cardInfo)
                self.setCardImage(image)
            case .errored(let errorInfo):
                self.setLabelText(errorInfo)
                self.setCardImage(nil)
            }
        }
    }
    
    private func setLabelText(_ text: String) {
        self.informationLabel.text = text
    }
    
    private func setCardImage(_ image: UIImage?) {
        self.cardImageView.image = image
    }
}
