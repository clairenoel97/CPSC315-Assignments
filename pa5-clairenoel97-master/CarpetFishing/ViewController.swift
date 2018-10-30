//
//  ViewController.swift
//  CarpetFishing
//
//  This file holds all of the information about the carpet fishing game
//      contains the connections to the IB
//      declares actions for the buttons
//      has outlets for the labels
//      allows user to play multiple games
//      makes use of the timer
//      player can only drop one line at a time
//  CPSC 315-01, Fall 2018
//  source for the icon picture
    //<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
//
//  Created by Norman, Claire Noel on 10/11/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]! //an array of button objects
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var newGame: UIButton!
    
    var lineDropped = Bool()
    var sea = CarpetSea()
    
    //setting up the timer
    var timer: Timer? = nil
    var seconds = 60 {
        didSet {
            secondsLabel.text = "Seconds: \(seconds)"
        }
    }
    
    //setting up the points
    var points = 0 {
        didSet {
            pointsLabel.text = "Points: \(points)"
        }
    }
    
    //overriding so that the alert with instructions will be the first thing to appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) //calling super class
        startAlert()
        
    }
    
    //function quites the game completely if the user doesn't want to play
    func exitGame(alert: UIAlertAction) {
        exit(0)
    }

    //loads the beginning screen
    //sets the main buttons to a blue color
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            button.backgroundColor = UIColor(red: 0.60, green: 0.88, blue: 1.00, alpha: 1.0)
        }
    }

    //starts the timer and makes sure that the seconds stop at 0
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(timer) -> Void in
            self.seconds -= 1
            
            //if a line is dropped, this reels in the line on the second that follows
            //this leads to what can look like as inconsistent times,
            //however, this only is applied on each second
            //if the user presses a button half way between 2 seconds, then the line will be reeled in on the latter second
            //
            if(self.lineDropped) {
                //print(self.sea.description)
                self.reelInLine()
            }
            if (self.seconds <= 0) {
                timer.invalidate()
                self.seconds = self.sea.S
                self.gameOver()
            }
        })
        
        sea.randomlyPlaceFish()
        print(sea.description)
    }

    //looks at the button that was pressed
    //will be the button that the line is dropped
    func setButton(_ tag: Int) -> String {
        let row = tag / 10
        let col = tag - (row * 10)
        return sea.grid[row][col].description
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        print("new game start")
        startNewGame()
    }
    
    //should include functionality for dropping a line into the cell
    //disables button after one button is pressed
    //this only allows one line at a time
    @IBAction func buttonPressed(_ sender: UIButton) {
        sea.dropFishingLine(tag: sender.tag)
        self.lineDropped = true;
        for i in self.buttons {
            i.isEnabled = false
            i.backgroundColor = UIColor.lightGray
            i.setTitle(self.setButton(i.tag), for: .normal)
        }
    }
    
    
    //shows the user what they caught after line is dropped
    //changes the label on the buttons to show where the fish was and where the line was dropped
    func reelInLine() {
        if(sea.availableFish[sea.checkFishCaught()] == nil) {
            badCatch()
        } else {
            goodCatch()
            points += sea.availableFish[sea.checkFishCaught()]!
        }
        self.lineDropped = false
        sea.reset()
        sea.randomlyPlaceFish()
        print(sea.description)
        
    }
    
    //the instructions for the game that will be presented to the user
    func startAlert() {
        let sorted = sea.availableFish.sorted {$0.1 < $1.1}
        var pointsAdded = ""
        for(key, value) in sorted {
            pointsAdded += "\n\(key!) is \(value) points"
        }
        let message = "STEP RIGHT UP, STEP RIGHT UP if you like staring at the carpet. The rules are as follows. \n\n You will see a grid on the screen and one of the cells will be holding a fish... but you don't know which one. You will drop a fishing line  into one of the cells. Your line will be reeled in after 1 second. If you caught a fish, you will see  🎣 appear in the cell. Each fish is worth a different amount of points: \(pointsAdded) \n Each round will last only 60 seconds. \n\n ARE YOU READY?"
        
        //making the alert
        let alert = UIAlertController(title: "CARPET FISHING", message: message, preferredStyle: .alert)
        
        //we put the start time here after the
        let okayAction = UIAlertAction(title: "READY!", style: .default, handler: {(action) -> Void in self.startTimer()})
        let noAction = UIAlertAction(title: "No...cause i'm lame", style: .cancel, handler: exitGame)
        
        alert.addAction(okayAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }

    //alert to let the player know that they have caught a fish
    func goodCatch() {
        let message = "WOW, look what you caught! Very impressive. \(String(describing: sea.checkFishCaught())). That is \(sea.availableFish[sea.checkFishCaught()]!) points!"
        let caughtAlert = UIAlertController(title: "EARNINGS", message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Continue", style: .default, handler: {(action) -> Void in
            for i in self.buttons {
                i.isEnabled = true
                i.backgroundColor = UIColor(red: 0.60, green: 0.88, blue: 1.00, alpha: 1.0)
                i.setTitle("", for: .normal)
            }
        })
        caughtAlert.addAction(yesAction)
        self.present(caughtAlert, animated: true, completion: nil)
    }
    
    //alert to let the player know that they didn't catch a fish
    func badCatch() {
        let message = "Ummm... you got nothing... Better luck next time"
        let caughtAlert = UIAlertController(title: "UH OH, OH NO", message: message, preferredStyle: .alert)
        
        //you can only fish one line at a time
        let yesAction = UIAlertAction(title: "Continue", style: .default, handler: {(action) -> Void in
            for i in self.buttons {
                i.isEnabled = true
                i.backgroundColor = UIColor(red: 0.60, green: 0.88, blue: 1.00, alpha: 1.0)
                i.setTitle("", for: .normal)
            }
        })
        caughtAlert.addAction(yesAction)
        self.present(caughtAlert, animated: true, completion: nil)
    }
    
    //alert to let the player know the game is over
    func gameOver() {
        let message = "GREAT JOB! \n Here are you earned a total of \(points) points! \n Would you like to play again?"
        let gameOverAlert = UIAlertController(title: "Game Over", message: message, preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in self.startTimer()})
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: self.exitGame)
        
        gameOverAlert.addAction(yesAction)
        gameOverAlert.addAction(noAction)
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    func startNewGame() {
        let gameOverAlert = UIAlertController(title: "New Game?", message: "Would you like to start over?", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in
            self.sea = CarpetSea()
            self.seconds = self.sea.S
            self.points = 0
            //self.startTimer()
        })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        gameOverAlert.addAction(yesAction)
        gameOverAlert.addAction(noAction)
        self.present(gameOverAlert, animated: true, completion: nil)
    }
}



