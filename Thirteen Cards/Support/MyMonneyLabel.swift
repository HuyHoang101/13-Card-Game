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

struct MyMonneyLabel: View {
    var coins: Int
    var minus: Bool
    var add: Bool
    var coin: Int
    @State private var disaspear = false
    @State private var isLeft = false
    
    var body: some View {
        if !add && !minus {
            HStack{
                HStack{
                    Image("dollar")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(coins)K")
                        .modifier(scoreNumberStyle())
                }
                .modifier(scoreCapsuleStyle())
                .padding()
                .onAppear(){
                    isLeft = false
                    disaspear = false
                }
                .shadow(color:Color("ColorBlackTransparent"), radius: 5)
                
                Spacer()
            }
        } else if add {
            HStack{
                ZStack{
                    HStack{
                        Image("dollar")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("\(coins)K")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle())
                    .padding()
                    Text("      +\(coin)K")
                        .modifier(scoreNumberStyle())
                        .opacity(disaspear ? 0 : 1)
                        .offset(y: isLeft ? -16 : -35)
                        .onAppear(){
                            withAnimation(.easeInOut(duration: 1)){
                                isLeft = true
                            }
                            withAnimation(.easeInOut(duration: 0.5).delay(1)){
                                disaspear = true
                            }
                        }
                }
                .shadow(color:Color("ColorBlackTransparent"), radius: 5)
                
                Spacer()
            }
        } else if minus {
            HStack{
                ZStack{
                    HStack{
                        Image("dollar")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("\(coins)K")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle())
                    .padding()
                    Text("      -\(coin)K")
                        .modifier(scoreNumberStyle())
                        .opacity(disaspear ? 0 : 1)
                        .offset(y: isLeft ? -35 : -16)
                        .onAppear(){
                            withAnimation(.easeInOut(duration: 1)){
                                isLeft = true
                            }
                            withAnimation(.easeInOut(duration: 0.5).delay(1)){
                                disaspear = true
                            }
                        }
                }
                .shadow(color:Color("ColorBlackTransparent"), radius: 5)
                
                Spacer()
            }
        }
    }
}

struct MyMonneyLabel_Previews: PreviewProvider {
    static var previews: some View {
        MyMonneyLabel(coins: 200, minus: false, add: true, coin: 50)
    }
}
