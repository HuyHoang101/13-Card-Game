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
import Foundation
import CoreLocation
import SwiftUI

struct Accounts: Identifiable, Codable {
    var id: Int
    var name: String
    var sex: String
    var ID: String
    var coin: Int
    var win: Int
    var lose: Int
    var highestCoin: Int
    var trophy = [String]()
}
