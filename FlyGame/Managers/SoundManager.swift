//
//  SoundManager.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import UIKit
import AVFoundation

class SoundManager: NSObject, AVAudioPlayerDelegate {
    
    static let shared = SoundManager()
    
    private override init() {}
    
    private var player: AVAudioPlayer?
    private var isSoundOn: Bool = false
    
    enum Sounds: String {
        case won = "Win",
        loose = "Defeat",
        click = "Click",
        hit = "Hit",
        trophy = "Trophy",
        shot = "Shot"
    }
      
    func playSound(for name: Sounds) {
        isSoundOn = UserDefaultsManager.shared.isSoundEnabled
        
        if isSoundOn {
            if let url = Bundle.main.url(forResource: name.rawValue, withExtension: "mp3") {
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.delegate = self
                    player?.numberOfLoops = 0
                    player?.play()
                } catch {
                    print("music error")
                }
            }
        } else {
            player?.stop()
            player = nil
        }
    }
}
