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
    
    let eggTimers = ["softTime": 3, "mediumTime": 4, "hardTime": 7]
    var timer = Timer()
    

    var player: AVAudioPlayer!

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBOutlet var textLabel: UILabel!
    
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let buttonTitle = sender.currentTitle
        var currentTitle: String = ""
        if buttonTitle != nil {
            currentTitle = buttonTitle!
        }
        switch buttonTitle {
        case "Soft":
            invokeTimer(seconds: eggTimers["softTime"]!, currentTitle)
        case "Medium":
            invokeTimer(seconds: eggTimers["mediumTime"]!, currentTitle)
        case "Hard":
            invokeTimer(seconds: eggTimers["hardTime"]!, currentTitle)
        default:
            print("Button text is not found")
        }
    }
    
    
    func invokeTimer(seconds: Int, _ titleText: String) -> Void {
        self.progressBar.setProgress(0.0, animated: true )
        self.textLabel.text = titleText + " egg"
        var timeInSeconds = seconds * 3
        let progressTime = 1.0 / Float(timeInSeconds)
        var newTime: Float = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
            if (timeInSeconds > 0) {
                  timeInSeconds -= 1
                newTime = newTime + progressTime
                self.progressBar.setProgress(newTime, animated: true )
            } else {
                self.timer.invalidate()
                self.textLabel.text = "Done!!!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player.play()
                
            }
        })
    }
    
    
    
}
