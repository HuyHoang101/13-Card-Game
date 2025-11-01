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

struct Achievements: View {
    @State private var isTapped = false
    var achieve: String
    @Namespace var nameSpace
    var body: some View {
        ZStack{
            let text: LocalizedStringKey = achieve == "First" ? "first-str" : achieve == "Second" ? "second-str" : achieve == "Third" ? "third-str" : achieve == "Richest" ? "richest-str" : achieve == "Rich" ? "rich-str" : achieve == "Proficiency" ? "proficiency-str" : achieve == "Master" ? "master-str" : "patience-str"
            if !isTapped {
                Color("PurpleSet3")
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                VStack{
                    Image(achieve)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .matchedGeometryEffect(id: "image", in: nameSpace)
                    if achieve == "Proficiency"{
                        Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                            .matchedGeometryEffect(id: "text", in: nameSpace)
                    } else {
                        Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .matchedGeometryEffect(id: "text", in: nameSpace)
                    }
                }
                .frame(width: 100, height: 100)
                .matchedGeometryEffect(id: "Card", in: nameSpace)
            } else {
                Color("PurpleSet3")
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                VStack{
                    Image(achieve)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .padding(.top)
                        .matchedGeometryEffect(id: "image", in: nameSpace)
                    if achieve == "Proficiency"{
                        Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                            .matchedGeometryEffect(id: "text", in: nameSpace)
                    } else {
                        Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .matchedGeometryEffect(id: "text", in: nameSpace)
                    }
                    if achieve == "First" {
                        HStack{
                            Text("firstString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("firstString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Second" {
                        HStack{
                            Text("secondString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("secondString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Third" {
                        HStack{
                            Text("thirdString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("thirdString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Richest" {
                        HStack{
                            Text("richestString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("richestString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Rich" {
                        HStack{
                            Text("richString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("richString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Proficiency" {
                        HStack{
                            Text("proficiencyString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("proficiencyString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Master" {
                        HStack{
                            Text("masterString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("masterString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    } else if achieve == "Patience" {
                        HStack{
                            Text("patienceString1-str")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .padding(.leading)
                                .offset(y: 10)
                                .matchedGeometryEffect(id: "text1", in: nameSpace)
                            Spacer()
                        }
                        HStack{
                            Text("patienceString2-str")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.leading)
                                .offset(y: 10)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: 200, height: 200)
                .matchedGeometryEffect(id: "Card", in: nameSpace)
            }
        }
        .shadow(radius: 7)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.7)) {
                isTapped.toggle()
            }
        }
    }
}

struct Achievements_Previews: PreviewProvider {
    static var previews: some View {
        Achievements(achieve: "Richest")
    }
}
