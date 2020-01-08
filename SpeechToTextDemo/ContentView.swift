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
        Text(speechRec.recognizedText)
            .font(.largeTitle)
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
