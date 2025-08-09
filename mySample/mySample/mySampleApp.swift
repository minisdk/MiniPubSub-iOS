//
//  mySampleApp.swift
//  mySample
//
//  Created by sangmin park on 7/23/24.
//

import SwiftUI

@main
struct mySampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init(){
        PubSubTester()
    }
}
