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

struct ChampionView: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage("isDark") var isDark = false
    @AppStorage("music") var music = true
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    ChampionSup()
                        .padding()
                    let accounts = modelData.sort(_account: modelData.account)
                    ForEach(accounts) { acc in
                        NavigationLink{
                            UserDetails(acc: acc)
                        } label: {
                            UserRow(account: acc, num: acc.id)
                        }
                        Divider()
                    }
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
            .navigationTitle("Champions")
            .scrollContentBackground(.hidden)
            .background(isDark ? LinearGradient(gradient: Gradient(colors: [Color("DarkSet1"),Color("DarkSet2"),Color("DarkSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color("BlueSet1"),Color("BlueSet2"),Color("BlueSet3")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .onAppear(){
                if music {
                    playSound(sound: "Here_Forever", type: "mp3")
                }
            }
        }
    }
}

struct ChampionView_Previews: PreviewProvider {
    static var previews: some View {
        ChampionView()
    }
}
