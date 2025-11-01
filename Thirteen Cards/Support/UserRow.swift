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

struct UserRow: View {
    var account: Accounts
    var num: Int
    
    var body: some View {
            HStack{
                Image("\(account.name)")
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
                        Text(account.name)
                            .modifier(AlphabetStyle())
                        Spacer()
                    }
                    HStack{
                        Text("coin-str \(String(account.coin))")
                            .modifier(scoreCapsuleStyle())
                            .modifier(scoreNumberStyle())
                            .offset(y: -5)
                            .padding(.leading, -10)
                        Spacer()
                    }
                }
                Spacer()
                if num > 3 {
                    Text("\(num)")
                        .modifier(AlphabetStyle())
                        .padding()
                } else if num == 1 {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .padding()
                        .foregroundColor(Color("Gold"))
                } else if num == 2 {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .padding()
                        .foregroundColor(Color("Silver"))
                } else if num == 3 {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .padding()
                        .foregroundColor(Color("Copper"))
                }
            }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var accounts = ModelData().account
    
    static var previews: some View {
        Group{
            UserRow(account: accounts[10], num: 2)
        }
        .previewLayout(.fixed(width: 300, height: 120))
    }
}
