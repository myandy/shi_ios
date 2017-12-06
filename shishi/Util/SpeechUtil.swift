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
    
    fileprivate(set) var text: String?
    
    public func speech(texts: [String]) {
        //中间断开，朗读的时候会停顿
        let text = texts.joined(separator: "\n\n")
        self.speech(text: text)
    }
    
    public var speakingText: String? {
        if !self.synth.isSpeaking {
            return nil
        }
        return self.text
    }
    
    public func speech(text: String) {
        //如果在朗读的内容不是当前要读的内容，先停止，如果内容相同，不再继续
        if self.synth.isSpeaking {
            let needContinue = self.text != text
            self.stop()
            if !needContinue {
                return
            }
        }
        
        self.text = text
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.3
//        utterance.postUtteranceDelay = 1
        synth.speak(utterance)
    }
    
    public func stop() {
        self.text = nil
        self.synth.stopSpeaking(at: .immediate)
    }
}
