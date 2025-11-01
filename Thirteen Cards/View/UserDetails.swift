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
import CoreLocation
import _MapKit_SwiftUI

struct UserDetails: View {
    var acc: Accounts
    
    var body: some View {
        ZStack{
            BackgroundPage()
            BackgroundIcon()
            ScrollView {
                VStack{
                    HStack{
                        Image("\(acc.name)")
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
                                Text(acc.name)
                                    .modifier(AlphabetStyle())
                                Spacer()
                            }
                            HStack{
                                Text("coin-str \(String(acc.coin))")
                                    .modifier(scoreCapsuleStyle())
                                    .modifier(scoreNumberStyle())
                                    .offset(y: -5)
                                    .padding(.leading, -10)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 40)
                    Divider()
                    HStack {
                        Text("ID-str: \(acc.ID)")
                            .modifier(AlphabetStyle1())
                            .padding()
                        Text("Sex-str")
                            .modifier(AlphabetStyle1())
                            .padding(.leading)
                        Text(acc.sex == "male" ? "male-str" : "female-str")
                            .modifier(AlphabetStyle1())
                        Spacer()
                    }
                    HStack {
                        Text("win-str: \(String(acc.win))")
                            .modifier(AlphabetStyle1())
                            .padding()
                        Text("lose-str: \(String(acc.lose))")
                            .modifier(AlphabetStyle1())
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Text("hightest-str: \(String(acc.highestCoin))")
                            .modifier(AlphabetStyle1())
                            .padding()
                        Spacer()
                    }
                    Divider()
                    Text("achievements-str")
                        .modifier(AlphabetStyle())
                        .padding()
                    VStack {
                        HStack{
                            if acc.trophy.count > 0 {
                                ForEach(0 ..< 2){ i in
                                    if i < acc.trophy.count {
                                        Achievements(achieve: acc.trophy[i])
                                            .padding()
                                    }
                                }
                            }
                        }
                        HStack{
                            if acc.trophy.count > 0 {
                                ForEach(2 ..< 4){ i in
                                    if i < acc.trophy.count {
                                        Achievements(achieve: acc.trophy[i])
                                            .padding()
                                    }
                                }
                            }
                        }
                        HStack{
                            if acc.trophy.count > 0 {
                                ForEach(4 ..< 6){ i in
                                    if i < acc.trophy.count {
                                        Achievements(achieve: acc.trophy[i])
                                            .padding()
                                    }
                                }
                            }
                        }
                        HStack{
                            if acc.trophy.count > 0 {
                                ForEach(6 ..< 8){ i in
                                    if i < acc.trophy.count {
                                        Achievements(achieve: acc.trophy[i])
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UserDetails_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        UserDetails(acc: modelData.account[7])
            .environmentObject(modelData)
    }
}
