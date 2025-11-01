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

struct ContentView: View {
    @State private var show = false
    @State private var show1 = false
    @State private var show2 = false
    @State private var showingSheet = false
    @EnvironmentObject var modelData: ModelData
    @AppStorage("myCoin") var myCoin = 500
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("lang") var lang = "en"
    @AppStorage("isDark") var isDark = false
    @AppStorage("music") var music = true
    
    
    func rand() -> [Int] {
        var int = [Int]()
        while true {
            let rand = Int.random(in: 0..<11)
            var status = true
            for i in int{
                if i == rand {
                    status = false
                }
            }
            if status {
                int.append(rand)
            }
            if int.count > 3 {
                break
            }
        }
        return int
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundPage()
                BackgroundIcon()
                
                VStack{
                    HStack{
                        NavigationLink(destination: UserDetails(acc: modelData.account[0])){
                            Image(modelData.account[0].name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10).stroke(Color("PurpleSet3"), lineWidth: 3)
                                }
                                .padding()
                            VStack{
                                HStack{
                                    Text(modelData.account[0].name)
                                        .modifier(AlphabetStyle())
                                    Spacer()
                                }
                                HStack{
                                    Text("coin-str \(String(modelData.account[0].coin))")
                                        .modifier(scoreCapsuleStyle())
                                        .modifier(scoreNumberStyle())
                                        .offset(y: -5)
                                        .padding(.leading, -10)
                                    Spacer()
                                }
                            }
                        }
                        .onAppear{
                            modelData.updateAccount(coin: myCoin, win: win, lose: lose)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Image("cog")
                              .resizable()
                              .scaledToFit()
                              .frame(height: 30)
                              .bold()
                        }
                        .sheet(isPresented: $showingSheet) {
                                    SettingsView()
                                }
                        .frame(height: 40)
                        .padding()
                    }
                    .offset(y: 10)
                    Divider()
                        .padding()
                        .modifier(ShadowModifier())
                    ZStack(){
                        Text("thirteen-str")
                            .font(.system(size: 44, weight: .heavy, design: .rounded))
                            .offset(y: 50)
                        LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"), Color("BlueSet2"), Color("BlueSet3"), Color("PurpleSet1"), Color("PurpleSet2"), Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: 334, height: 100)
                            .offset(y: 50)
                            .mask {
                                Text("thirteen-str")
                                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                                    .offset(y: 50)
                            }
                            
                    }
                    .frame(width: 200, height: 50)
                    .modifier(ShadowModifier())
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack{
                            let num = rand()
                            NavigationLink(destination: CardPlayerView(num1: num[0], num2: num[1], num3: num[2])){
                                ZStack{
                                    Image("playing-cards")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300)
                                        .padding(.vertical, 40)
                                        .padding(.horizontal, 40)
                                    Text("play-str")
                                        .font(.system(size: 120, weight: .heavy, design: .rounded))
                                        .offset(y: 100)
                                    LinearGradient(gradient: Gradient(colors: [Color("PurpleSet1"), Color("PurpleSet2"), Color("BlueSet2"), Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)
                                        .frame(width: 390, height: 300)
                                        .offset(y: 130)
                                        .rotationEffect(.init(degrees: 20))
                                        .offset(x: self.show ? 105 : -25)
                                        .mask {
                                            Text("play-str")
                                                .font(.system(size: 120, weight: .heavy, design: .rounded))
                                                .offset(y: 100)
                                        }
                                        .onAppear(){
                                            withAnimation(.easeInOut(duration: 2).delay(0).repeatForever(autoreverses: false)){
                                                self.show.toggle()
                                            }
                                        }
                                }
                            }
                            .modifier(ShadowModifier())
                            .padding(.vertical, 100)
                            .frame(width: 400)
                            
                            NavigationLink(destination: ChampionView()){
                                ZStack{
                                    Image("trophy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300)
                                        .padding(.vertical, 40)
                                        .padding(.horizontal, 20)
                                    Text("champion-str")
                                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                                        .offset(y: 140)
                                    LinearGradient(gradient: Gradient(colors: [Color("PurpleSet1"), Color("PurpleSet2"), Color("BlueSet2"), Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)
                                        .frame(width: 450, height: 200)
                                        .offset(y: 140)
                                        .rotationEffect(.init(degrees: 0))
                                        .offset(x: self.show1 ? 100 : -100)
                                        .mask {
                                            Text("champion-str")
                                                .font(.system(size: 44, weight: .heavy, design: .rounded))
                                                .offset(y: 140)
                                        }
                                        .onAppear(){
                                            withAnimation(.easeInOut(duration: 2).delay(0).repeatForever(autoreverses: false)){
                                                self.show1.toggle()
                                            }
                                        }
                                }
                            }
                            .padding(.vertical, 100)
                            .frame(width: 400)
                            .modifier(ShadowModifier())
                            
                            NavigationLink(destination: HowToPlayView()){
                                ZStack{
                                    Image("video-game")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300)
                                        .padding(.vertical, 40)
                                        .padding(.horizontal, 15)
                                    Text("htp-str")
                                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                                        .offset(y: 140)
                                    LinearGradient(gradient: Gradient(colors: [Color("PurpleSet1"), Color("PurpleSet2"), Color("BlueSet2"), Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)
                                        .frame(width: 500, height: 200)
                                        .offset(y: 140)
                                        .rotationEffect(.init(degrees: 0))
                                        .offset(x: self.show2 ? 100 : -100)
                                        .mask {
                                            Text("htp-str")
                                                .font(.system(size: 44, weight: .heavy, design: .rounded))
                                                .offset(y: 140)
                                        }
                                        .onAppear(){
                                            withAnimation(.easeInOut(duration: 2).delay(0).repeatForever(autoreverses: false)){
                                                self.show2.toggle()
                                            }
                                        }
                                }
                            }
                            .padding(.vertical, 100)
                            .frame(width: 400)
                            .modifier(ShadowModifier())
                        }
                    }
                    
                    Divider()
                        .padding()
                        .modifier(ShadowModifier())
                    
                    HStack {
                        NavigationLink(destination: ChampionView()){
                            ZStack{
                                Image("trophy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                                Text("champion-str")
                                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                                    .offset(y: 30)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding()
                        .scaledToFit()
                        .frame(width: 120)
                        
                        Spacer()
                        
                        let num = rand()
                        NavigationLink(destination: CardPlayerView(num1: num[0], num2: num[1], num3: num[2])){
                            ZStack{
                                Image("playing-cards")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                                Text("play-str")
                                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                                    .offset(y: 30)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding()
                        .scaledToFit()
                        .frame(width: 120)
                        
                        Spacer()
                        
                        NavigationLink(destination: HowToPlayView()){
                            ZStack{
                                Image("video-game")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                                Text("htp-str")
                                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                                    .offset(y: 20)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding()
                        .scaledToFit()
                        .frame(width: 120)
                    }
                }
            }
            .environment(\.locale, Locale.init(identifier: lang))
            .environment(\.colorScheme, isDark ? .dark : .light)
            .onAppear(){
                if music {
                    playSound(sound: "Robot_meme", type: "mp3")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
