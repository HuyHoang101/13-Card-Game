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

struct ChampionSup: View {
    var body: some View {
        ZStack{
            Image("trophy")
                .resizable()
                .scaledToFit()
                .frame(width: 130)
            Text("champion-str")
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .offset(y: 70)
                .foregroundColor(.white)
        }
        .padding()
        .scaledToFit()
        .frame(width: 150)
    }
}

struct ChampionSup_Previews: PreviewProvider {
    static var previews: some View {
        ChampionSup()
    }
}
