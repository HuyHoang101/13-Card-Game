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

struct MemberPlayer: View {
    @State var progressValue: Float = 1.0
    @State var colour: Color = Color("Green")
    @State var scales: Bool = false
    @AppStorage("isDark") var isDark = false
    var image: String
    var isActive: Bool
    var name: String
    var card: Int
    
    var body: some View {
        ZStack{
            if isActive {
                VStack {
                    ZStack{
                        Group {
                            Circle()
                                .stroke(lineWidth: 8.0)
                                .opacity(0.20)
                                .foregroundColor(Color.gray)
                            Circle()
                                .trim(from: 0.0, to: CGFloat(min(progressValue, 1.0)))
                                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(colour)
                                .rotationEffect(Angle(degrees: 270))
                        }
                        .frame(width: 70, height: 70)
                        .padding(20.0)
                        Image("\(image)")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 62, height: 62)
                    }
                    .modifier(ShadowModifier())
                    Group {
                        Text("name-str \(name)")
                        Text("card-str \(String(card))")
                    }
                    .offset(y: -20)
                    .font(.system(size: 13))
                }
                .scaleEffect(scales ? 1.2 : 1)
                .onAppear(){
                    withAnimation(.easeInOut(duration: 0.5).repeatCount(20).delay(15)){
                        self.scales = true
                    }
                    
                    withAnimation(.easeInOut(duration: 25)){
                        self.progressValue = 0.0
                        self.colour = Color.red
                    }
                }
            } else {
                VStack {
                    ZStack{
                        Group {
                            Circle()
                                .stroke(lineWidth: 8.0)
                                .opacity(0.20)
                                .foregroundColor(Color.gray)
                            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(min(progressValue, 1.0)))
                                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                                .foregroundColor(colour)
                                .rotationEffect(Angle(degrees: 270))
                        }
                        .frame(width: 70, height: 70)
                        .padding(20.0)
                        Image("\(image)")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 62, height: 62)
                    }
                    Group {
                        Text("name-str \(name)")
                        Text("card-str \(String(card))")
                    }
                    .offset(y: -20)
                    .font(.system(size: 13))
                }
                .opacity(0.3)
                .onAppear(){
                    self.progressValue = 1.0
                    self.colour = Color("Green")
                    self.scales = false
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}



struct MemberPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MemberPlayer(image: "Lily", isActive: true, name: "Lily", card: 13)
    }
}
