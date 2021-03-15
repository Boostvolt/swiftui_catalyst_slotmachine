//
//  AudioExtension.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import AVFoundation

private var audioPlayer: AVAudioPlayer?

func playSound(name: String, format: String) {
    
    if let path = Bundle.main.path(forResource: name, ofType: format) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("File not found.")
        }
    }
}
