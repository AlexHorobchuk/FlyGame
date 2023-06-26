//
//  MusicManager.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import Foundation
import AVFAudio

class MusicManager {
    
    static let shared = MusicManager()
    
    private init() {}
    
    var player: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let isMusicOn = UserDefaultsManager.shared.isMusicEnabled
        if isMusicOn {
            if let url = Bundle.main.url(forResource: "GameMusic", withExtension: "mp3") {
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.numberOfLoops = -1
                    player?.play()
                    
                } catch {
                    print("mussic error")
                }
            }
        } else {
            player?.stop()
            player = nil
        }
    }
}
