//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func redButton(_ sender: Any) {
        simonSaysGame.guessRed()
        checkWin()
    }
    @IBAction func greenButton(_ sender: Any) {
        simonSaysGame.guessGreen()
        checkWin()
    }
    @IBAction func yellowButton(_ sender: Any) {
        simonSaysGame.guessYellow()
        checkWin()
    }
    @IBAction func blueButton(_ sender: Any) {
        simonSaysGame.guessBlue()
        checkWin()
    }
    
    func checkWin() {
        if buttonsClicked == 4 {
            if simonSaysGame.wonGame() {
                winLabel.isHidden = false
                winLabel.text = "You Won!"
                restartGame()
            } else {
                winLabel.isHidden = false
                winLabel.text = "Nope, try again."
                restartGame()
            }
        }
        buttonsClicked += 1
        print(buttonsClicked)
    }
    func restartGame() {
        simonSaysGame = SimonSays()
        startGameButton.isHidden = false
    }
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
        print(buttonsClicked)
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            self.winLabel.isHidden = true
            self.buttonsClicked = 0
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
