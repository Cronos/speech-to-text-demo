//
//  ContentView.swift
//  SpeechToTextDemo
//
//  Created by Altynbek Usenbekov on 1/8/20.
//  Copyright © 2020 Altynbek Usenbekov. All rights reserved.
//

import SwiftUI
import Speech

struct ContentView: View {
    @ObservedObject var speechRec = SpeechRec()
    var body: some View {
        Text(speechRec.recognizedText)
            .font(.largeTitle)
            .onAppear {
                self.speechRec.start()
        }
    }
}

class SpeechRec: ObservableObject {
    @Published private(set) var recognizedText = ""
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU")) // Use Russian
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    func start() {
        self.recognizedText = "Слушаю..."
        SFSpeechRecognizer.requestAuthorization { status in
            self.startRecognition()
        }
    }
    
    func startRecognition() {
        do {
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                }
            }
            
            let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
            audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
        }
        
        catch {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
