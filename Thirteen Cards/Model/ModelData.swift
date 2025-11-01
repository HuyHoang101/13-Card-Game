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

final class ModelData: ObservableObject {
    @Published var account: [Accounts] = decodeJsonFromJsonFile(jsonFileName: "Account.json")
    
    func sort(_account: [Accounts]) -> [Accounts] {
        var acc = account
        var sort = [Accounts]()
        while acc.count > 0 {
            var max = acc[0]
            var index = 0
            var trueIndex = 0
            for a in acc {
                if max.coin < a.coin {
                    max = a
                    trueIndex = index
                }
                index += 1
            }
            sort.append(max)
            acc.remove(at: trueIndex)
        }
        var count = 1
        for i in 0 ..< sort.count{
            sort[i].id = count
            count += 1
        }
        
        return sort
    }
    
    func resetAccount(){
        account[0].coin = 500
        account[0].win = 0
        account[0].lose = 0
        account[0].highestCoin = 500
        account[0].trophy.removeAll()
    }
    
    func updateAccount(coin: Int, win: Int, lose: Int){
        account[0].coin = coin
        account[0].win = win
        account[0].lose = lose
        if account[0].coin > account[0].highestCoin {
            account[0].highestCoin = account[0].coin
        }
        
        let acc = sort(_account: account)
        
        if acc[0].name == "Hoàng" {
            var check = true
            var check1 = true
            for i in acc[0].trophy {
                if i == "First" {
                    check = false
                    break
                }
                if i == "Richest" {
                    check1 = false
                    break
                }
            }
            if check {
                account[0].trophy.append("First")
            }
            if check1 {
                account[0].trophy.append("Richest")
            }
        }
        
        if acc[1].name == "Hoàng" {
            var check = true
            for i in acc[1].trophy {
                if i == "Second" {
                    check = false
                    break
                }
            }
            if check {
                account[0].trophy.append("Second")
            }
        }
        
        if acc[2].name == "Hoàng" {
            var check = true
            for i in acc[2].trophy {
                if i == "Third" {
                    check = false
                    break
                }
            }
            if check {
                account[2].trophy.append("Third")
            }
        }
        
        if account[0].coin >= 2000 {
            var check = true
            for i in account[0].trophy {
                if i == "Rich" {
                    check = false
                    break
                }
            }
            if check {
                account[0].trophy.append("Rich")
            }
        }
        
        if account[0].win >= 100 {
            var check = true
            for i in account[0].trophy {
                if i == "Proficiency" {
                    check = false
                    break
                }
            }
            if check {
                account[0].trophy.append("Proficiency")
            }
        }
        
        if account[0].win >= 200 {
            var check = true
            for i in account[0].trophy {
                if i == "Master" {
                    check = false
                    break
                }
            }
            if check {
                account[0].trophy.append("Master")
            }
        }
        
        if account[0].lose >= 100 {
            var check = true
            for i in account[0].trophy {
                if i == "Patience" {
                    check = false
                    break
                }
            }
            if check {
                account[0].trophy.append("Patience")
            }
        }
    }
}

var account1: [Accounts] = decodeJsonFromJsonFile(jsonFileName: "Account.json")

// How to decode a json file into a struct
func decodeJsonFromJsonFile(jsonFileName: String) -> [Accounts] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Accounts].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Accounts]
}
