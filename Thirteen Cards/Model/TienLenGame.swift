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

class TienLenGame: ObservableObject{
    
    @Published private var model = DivideCard()
    
    @Published private(set) var activePlayer = Player()
    
    @Published private(set) var gameOver = false
    
    var players: [Player]{
        return model.players
    }
    
    var discardedHands: [DiscardHand] {
        return model.discardedHands
    }
    
    func select(_ card: Card, in player: Player){
        model.select(card, in: player)
    }
    
    func evaluateHand(_ cards: Stack) -> HandType {
        return HandType(cards)
    }
    
    func findStartingPlayer() -> Player {
        return model.findStartingPlayer()
    }
    
    
    func activatePlayer(_ player: Player) {
        model.activatePlayer(player)
        if let activePlayerIndex = players.firstIndex(where: { $0.activePlay == true}){
            activePlayer = players[activePlayerIndex]
        }
    }
    
    func NotInCircle(_ player: Player) {
        model.NotInCircle(player)
    }
    
    func NotInDifficulty(_ player: Player){
        model.NotInDifficulty(player)
    }
    
    func getNextPlayer() -> Player {
        model.getNextPlayerFromCurrent()
    }
    
    func getCPUHand(of player: Player) ->Stack {
        return model.getCPUHand(of: player)
    }
    
    func playSelectedCard(of player: Player) {
        model.playSelectCard(of: player)
        if let activePlayerIndex = players.firstIndex(where: { $0.activePlay == true}){
            gameOver = players[activePlayerIndex].cards.count == 0
        }
    }
    
    func playable(_ hand: Stack, of player: Player) -> Bool {
        return model.playable(hand, of: player)
    }
    
    func restart(){
        model.restart()
        gameOver = false
        activePlayer = Player()
    }
}
