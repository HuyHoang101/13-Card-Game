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

struct SettingsView: View {
    @AppStorage("difficult") var dif = "easy"
    @Environment(\.dismiss) var dismiss
    @AppStorage("sound") var sound = true
    @AppStorage("music") var music = true
    @State private var language = "English"
    @AppStorage("lang") var lang = "en"
    @AppStorage("myCoin") var myCoin = 500
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("isDark") var isDark = false
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack{
            BackgroundPage()
            BackgroundIcon()
            VStack{
                HStack{
                    Text("difficult-str")
                        .modifier(AlphabetStyle())
                    Menu{
                        Button("easy-str"){
                            dif = "easy"
                        }
                        Button("medium-str"){
                            dif = "medium"
                        }
                        Button("hard-str"){
                            dif = "hard"
                        }
                    } label: {
                        let color = isDark ? LinearGradient(gradient: Gradient(colors: [Color("DarkSet1"),Color("DarkSet2"),Color("DarkSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        let text: LocalizedStringKey = dif == "easy" ? "easy-str" : dif == "medium" ? "medium-str" : "hard-str"
                        Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("BlueSet3"), lineWidth: 1)
                                    
                            ).background(RoundedRectangle(cornerRadius: 25).fill(color))
                    }
                    .menuOrder(.fixed)
                }
                .padding(.top, 180)
                .padding()
                HStack{
                    Text("language-str")
                        .modifier(AlphabetStyle())
                    Menu{
                        Button("English"){
                            language = "English"
                            lang = "en"
                        }
                        Button("Vietnamese"){
                            language = "Việt Nam"
                            lang = "vi"
                        }
                        Button("日本の (Japanese)"){
                            language = "日本の"
                            lang = "ja"
                        }
                    } label: {
                        let color = isDark ? LinearGradient(gradient: Gradient(colors: [Color("DarkSet1"),Color("DarkSet2"),Color("DarkSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        Text(lang == "en" ? "English" : lang == "vi" ? "Việt Nam" : "日本の")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("BlueSet3"), lineWidth: 1)
                                    
                            ).background(RoundedRectangle(cornerRadius: 25).fill(color))
                    }
                    .menuOrder(.fixed)
                    
                }
                .padding()
                
                HStack{
                    var isSound = sound ? "speaker.wave.2.fill" : "speaker.slash.fill"
                    Text("sound-str")
                        .modifier(AlphabetStyle())
                    Button{
                        sound.toggle()
                    } label: {
                        Image(systemName: isSound)
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    .onChange(of: sound){ newvalue in
                        withAnimation(.easeInOut(duration: 0.5)){
                            isSound = sound ? "speaker.wave.2.fill" : "speaker.slash.fill"
                        }
                    }
                }
                .padding()
                
                HStack{
                    var isSound = music ? "speaker.wave.2.fill" : "speaker.slash.fill"
                    if lang == "en"{
                        Text("Music:  ")
                            .modifier(AlphabetStyle())
                    } else if lang == "vi" {
                        Text("Âm nhạc:  ")
                            .modifier(AlphabetStyle())
                    } else {
                        Text("音楽:  ")
                            .modifier(AlphabetStyle())
                    }
                    Button{
                        music.toggle()
                        if !music {
                            audioPlayer?.stop()
                        } else {
                            playSound(sound: "Robot_meme", type: "mp3")
                        }
                    } label: {
                        Image(systemName: isSound)
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    .onChange(of: music){ newvalue in
                        withAnimation(.easeInOut(duration: 0.5)){
                            isSound = music ? "speaker.wave.2.fill" : "speaker.slash.fill"
                        }
                    }
                }
                .padding()
                
                HStack{
                    var dark = isDark ? "moon.fill" : "sun.max.fill"
                    Text("dark-str")
                        .modifier(AlphabetStyle())
                    Button{
                        isDark.toggle()
                    } label: {
                        Image(systemName: dark)
                            .font(.title)
                    }
                    .foregroundColor(.white)
                    .onChange(of: isDark){ newvalue in
                        withAnimation(.easeInOut(duration: 0.5)){
                            dark = isDark ? "moon.fill" : "sun.max.fill"
                        }
                    }
                }
                .padding()
                
                Button {
                    myCoin = 500
                    win = 0
                    lose = 0
                    modelData.resetAccount()
                } label: {
                    let color = isDark ? LinearGradient(gradient: Gradient(colors: [Color("DarkSet1"),Color("DarkSet2"),Color("DarkSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    Text("reset-str")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .modifier(AlphabetStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("BlueSet3"), lineWidth: 1)
                        ).background(RoundedRectangle(cornerRadius: 25).fill(color))
                }
                .padding(.top, 80)
                
                Spacer()
            }
            
        }
        .environment(\.locale, Locale.init(identifier: lang))
        .environment(\.colorScheme, isDark ? .dark : .light)
        .overlay(
          Button(action: {
            dismiss()
          }) {
            Image(systemName: "xmark.circle")
              .font(.title)
          }
          .foregroundColor(.white)
          .padding(.top, 50)
          .padding(.trailing, 20),
          alignment: .topTrailing
          )
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
