//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 300 , "Medium" : 420 , "Hard" : 720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //Stop and cancel timer and reset progress bar
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        
        //retrieve hardness from button title
        let hardness = sender.currentTitle!
        titleLabel.text = "Waiting for your \(hardness.lowercased()) eggs to finish..."
        
        totalTime = eggTimes[hardness]!
        
        //start a new timer with 1 second interval method calls to updateCounter
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            

            
        }else{
            timer.invalidate()
            playSound(soundName: "eggTimerDone")
            titleLabel.text = "DONE!"
            
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    
}
