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

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}

struct BetCapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .heavy, design: .rounded))
            .modifier(ShadowModifier())
            .background(
                Capsule().fill(LinearGradient(gradient: Gradient(colors: [Color("PurpleSet1"), Color("PurpleSet2"), Color("PurpleSet3")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                    .frame(width: 60, height: 40, alignment: .center)
            )
    }
}

struct CasinoChipModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 40)
            .modifier(ShadowModifier())
    }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .padding(.horizontal, 9)
            .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color("BlueSet2"),Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)))
    }
}

struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 17, weight: .heavy, design: .rounded))
    }
}

struct AlphabetStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 26, weight: .heavy, design: .rounded))
    }
}

struct AlphabetStyle1: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .heavy, design: .rounded))
    }
}

struct buttonStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 18)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("PurpleSet3"), lineWidth: 2)
                    
            ).background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color("BlueSet2"),Color("BlueSet1"),Color("PurpleSet3")]), startPoint: .leading, endPoint: .trailing)))
    }
}


