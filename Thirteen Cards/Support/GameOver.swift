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

struct GameOver: View {
    var playerName: String
    @AppStorage("isDark") var isDark = false
    @State var scale : Bool = false
    var body: some View {
            VStack {
                if playerName == "Hoàng" {
                    ZStack{
                        Image("playing-card")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Winning")
                            .foregroundColor(Color.red)
                            .font(Font.custom("RubikIso-Regular", size: 37))
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 17)
                                    .stroke(Color.red, style: StrokeStyle(lineWidth: 3, dash: [5]))
                                    )
                            .offset(y: 63)
                    }
                    .frame(width: 200, height: 200)
                    .offset(y: -30)
                    Text("winner-str")
                        .offset(y: -40)
                        .foregroundColor(Color.red)
                } else {
                    Image("GameOver")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("loser-str \(playerName)")
                        .offset(y: -60)
                        .foregroundColor(Color("Purple"))
                }
            }
            .scaleEffect(scale ? 0.8 : 1)
            .onAppear(){
                withAnimation(.easeInOut(duration: 1.5).repeatForever()){
                    scale = true
                }
            }
            .modifier(ShadowModifier())
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver(playerName: "Hoàng")
    }
}
