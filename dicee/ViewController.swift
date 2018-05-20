//
//  ViewController.swift
//  dicee
//
//  Created by Clement Wekesa on 18/05/2018.
//  Copyright © 2018 Clement Wekesa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    var players = ["player1", "player2"]
    var opponent: Bool = true
    
    
    @IBOutlet weak var activePlayerLabel: UILabel!
    @IBOutlet weak var player1Lable: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player1RoundsCount: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player2RoundsCount: UILabel!
    
    
    @IBOutlet weak var roundTotalLabel: UILabel!
    @IBOutlet weak var roundTotal: UILabel!
    
    var randomDiceIndex1 = 0
    var randomDiceIndex2 = 0
    var player1Score: Int = 0
    var player2Score: Int = 0
    var player1Rounds: Int = 0
    var player2Rounds: Int = 0
    var activePlayer: String = "player1"
    
    var tempTotal: Int = 0
    var tempRoundCount: Int = 0
    
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if opponent {
            players[1] = "Comp"
            player2Label.text = players[1]
        }
        updateLabels()
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        updateDiceImages()
    }
    
    @IBAction func shiftPlayer(_ sender: UIButton) {
        updateShiftPlayer()
    }
    
    func updateDiceImages() {
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
        tempTotal += (randomDiceIndex1 + randomDiceIndex2 + 2)
        
        if randomDiceIndex1 == 0 && randomDiceIndex2 == 0 {
            if activePlayer == players[0] {
                player1Score = 0
                tempTotal = 0
            } else if activePlayer == players[1] {
                player2Score = 0
                tempTotal = 0
            }
            updateShiftPlayer()
        } else if randomDiceIndex1 == 0 || randomDiceIndex2 == 0 {
            tempTotal = 0
            updateShiftPlayer()
        }
        tempRoundCount += 1
        updateLabels()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    func updateLabels() {
        player1ScoreLabel.text = "\(player1Score)"
        player2ScoreLabel.text = "\(player2Score)"
        player1RoundsCount.text = "\(player1Rounds)"
        player2RoundsCount.text = "\(player2Rounds)"
        activePlayerLabel.text = activePlayer
        roundTotal.text = "\(tempTotal)"
    }
    
    func updateShiftPlayer() {
        // add score to total
        if activePlayer == players[0] {
            player1Score += tempTotal
            player1Rounds += tempRoundCount
        } else {
            player2Score += tempTotal
            player2Rounds += tempRoundCount
        }
        tempTotal = 0
        tempRoundCount = 0
        updateLabels()
        // change player
        if activePlayer == players[0] {
            activePlayer = players[1]
            activePlayerLabel.text = activePlayer
        } else {
            activePlayer = players[0]
            activePlayerLabel.text = activePlayer
        }
        // if comp play
        if activePlayer == "Comp" {
            updateDiceImages()
            updateShiftPlayer()
        }
    }

}

