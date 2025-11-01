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

struct BackgroundPage: View {
    @AppStorage("isDark") var isDark = false
    
    var body: some View {
        if isDark {
            LinearGradient(gradient: Gradient(colors: [Color("DarkSet1"),Color("DarkSet2"),Color("DarkSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        } else {
            LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct BackgroundPage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundPage()
    }
}

