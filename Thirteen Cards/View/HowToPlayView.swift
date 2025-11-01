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

struct HowToPlayView: View {
    @AppStorage("isDark") var isDark = false
    @AppStorage("lang") var lang = "en"
    
    var body: some View {
        ZStack{
            BackgroundPage()
            BackgroundIcon()
            VStack(alignment: .center) {
              Image("Background")
                    .resizable()
                    .scaledToFit()
                    
              
              Form {
                Section(header: Text("htp-str")) {
                    Text("first-string")
                    Text("second-string")
                    Text("third-string")
                    Text("fourth-string")
                    Text("fifth-string")
                    Text("sixth-string")
                    Text("seventh-string")
                }
                .listRowBackground(isDark ? Color("DarkSet2") : Color("BlueSet2"))
                  Section(header: Text("appIn-str")) {
                      HStack {
                        Text("appName-str")
                        Spacer()
                        Text("aName-str")
                      }
                      HStack {
                        Text("course-str")
                        Spacer()
                        Text("courseID-str")
                      }
                      HStack {
                        Text("yearPub-str")
                        Spacer()
                        Text("year-str")
                      }
                      HStack {
                        Text("local-str")
                        Spacer()
                          if lang == "en" {
                              Text("Saigon South Campus")
                          } else if lang == "vi" {
                              Text("Cơ sở nam Saigon")
                          } else {
                              Text("サイゴン南キャンパス")
                          }
                      }
                  }
                  .listRowBackground(isDark ? Color("DarkSet2") : Color("BlueSet2"))
              }
              .scrollContentBackground(.hidden)
              .font(.system(.body, design: .rounded))
              .offset(y: -5)
              .padding(.bottom, -20)
              .foregroundColor(isDark ? .white : Color("GreyWhite"))
            }

        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
