//
//  ContentView.swift
//  SpeechToTextDemo
//
//  Created by Altynbek Usenbekov on 1/8/20.
//  Copyright © 2020 Altynbek Usenbekov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var speechRec = SpeechRec()
    var body: some View {
        VStack {
            Text(speechRec.recognizedText)
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                if self.speechRec.isRunning {
                    self.speechRec.stop()
                } else {
                    self.speechRec.start()
                }
            }) {
                Text(self.speechRec.isRunning ? "Stop" : "Start")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            self.speechRec.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
