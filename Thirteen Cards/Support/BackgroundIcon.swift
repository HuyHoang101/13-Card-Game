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

struct BackgroundIcon: View {
    var body: some View {
        Image("cardIcon")
            .resizable()
            .scaledToFit()
            .frame(height: 350)
            .opacity(0.15)
            .offset(y: -100)
    }
}

struct BackgroundIcon_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundIcon()
    }
}
