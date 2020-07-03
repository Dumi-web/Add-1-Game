//
//  ViewController.swift
//  Add 1
//
//  Created by Clive Ngobeni on 2020/07/03.
//  Copyright © 2020 Clive Ngobeni. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    var score = 0
    
    var timer: Timer?
    var time = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedScoreLabel()
        updateNumberLabel()
        updateTimeLabel()

    }
    func updatedScoreLabel(){
        scoreLabel?.text = String(score)
    }
    func updateNumberLabel(){
        numberLabel?.text = String.randomNumber(length: 4)
    }
    func updateTimeLabel(){
        let min = Int(time / 60) % 60
        let sec = Int(time) % 60
        timeLabel?.text = String(format: "%02i:%02i", min, sec)
    }

    @IBAction func inputFieldDidChange(){
        guard let numberText = numberLabel?.text, let inputText = inputField?.text else{
            return
        }
        guard inputText.count == 4 else {
            return
        }
        
        var isCorrect = true
        for n in 0..<4 {
            var input = inputText.integer(at: n)
            let number  = numberText.integer(at: n)
            
            if input == 0{
                input = 10
            }
            if input != number + 1 {
                isCorrect = false
                break
            }
        }
        if isCorrect {
            score += 1
            
        } else {
            score -= 1
        }
        updatedScoreLabel()
        updateNumberLabel()
        inputField?.text = ""
        
        if timer == nil{
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){
                timer in
                if self.time == 0 {
                    self.finishGame()
                    
                }else if self.time <= 60 {
                    self.time -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
    
    func finishGame(){
        timer?.invalidate()
        timer = nil
        if self.score <= 10{
            let alert = UIAlertController(title: "Time's Up!", message: "Game Over! You got a score of \(score) points.😥" + " " + "Would you like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if self.score >= 10{
            let alert = UIAlertController(title: "Time's Up!", message: "Game Over! You got a score of \(score) points. Awesome!😎" + " " + "Would you like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        score = 0
        time = 60
        
        updatedScoreLabel()
        updateNumberLabel()
        updateTimeLabel()
    }
}


