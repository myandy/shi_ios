//
//  SpeechUtil.swift
//  shishi
//
//  Created by tb on 2017/8/27.
//  Copyright © 2017年 andymao. All rights reserved.
//

import AVFoundation

class SpeechUtil: NSObject {
    public static let `default`: SpeechUtil = {
        return SpeechUtil()
    }()
    
    fileprivate let synth = AVSpeechSynthesizer()
    
    public func speech(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3
        synth.speak(utterance)
    }
    
    public func stop() {
        self.synth.stopSpeaking(at: .immediate)
    }
}
