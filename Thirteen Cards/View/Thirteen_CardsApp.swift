/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Huy Hoang
  ID: s3914298
  Created  date: 27/08/2023
  Last modified: 06/09/2023
*/

import SwiftUI

@main
struct Thirteen_CardasApp: App {
    @StateObject var modelData = ModelData()
    @AppStorage("lang") var lang = "en"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environment(\.locale, Locale.init(identifier: lang))
        }
    }
}
