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

enum Rank: Int, CaseIterable, Comparable {
    case Three = 1, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace, Two
    
    static func < (lhs:Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

enum Suit: Int, CaseIterable, Comparable {
    case Spades = 1, Clubs, Diamonds, Hearts
    
    static func < (lhs:Suit, rhs: Suit) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

enum HandType {
    case Invalid, Single, Pair, Straight, ThreeLeaves, ThreeConsecutivePair, Quads, FourConsecutivePair, ADragon
    init(_ cards: Stack) {
        var returnType: Self = .Invalid
        
        if cards.count == 1{
            returnType = .Single
        }
        
        if cards.count == 2{
            if cards[0].rank == cards[1].rank{
                returnType = .Pair
            }
        }
        
        if cards.count == 3{
            if cards[0].rank == cards[1].rank && cards[1].rank == cards[2].rank{
                returnType = .ThreeLeaves
            }
        }
        
        if cards.count == 4{
            if cards[0].rank == cards[1].rank && cards[1].rank == cards[2].rank && cards[2].rank == cards[3].rank{
                returnType = .Quads
            }
        }
        
        if cards.count >= 3 {
            let sortCards = cards.sortByRank()
            var isStraight = true
            var isThreeConsecutivePair = false
            var isFourConsecutivePair = false
            
            for i in 0 ..< sortCards.count {
                if sortCards[i].rank != .Two && i + 1 < sortCards.count {
                    if sortCards[i].rank.rawValue - sortCards[i + 1].rank.rawValue != -1 {
                        isStraight = false
                        break
                    }
                }
            }
            
            if sortCards.count == 6 {
                if (sortCards[0].rank == sortCards[1].rank) && (sortCards[2].rank == sortCards[3].rank) && (sortCards[4].rank == sortCards[5].rank) &&
                    (sortCards[1].rank.rawValue - sortCards[2].rank.rawValue == -1) && (sortCards[3].rank.rawValue - sortCards[4].rank.rawValue == -1) {
                    isThreeConsecutivePair = true
                }
            }
            
            if sortCards.count == 8 {
                if (sortCards[0].rank == sortCards[1].rank) && (sortCards[2].rank == sortCards[3].rank) && (sortCards[4].rank == sortCards[5].rank) && (sortCards[6].rank == sortCards[7].rank) &&
                    (sortCards[1].rank.rawValue - sortCards[2].rank.rawValue == -1) && (sortCards[3].rank.rawValue - sortCards[4].rank.rawValue == -1) && (sortCards[5].rank.rawValue - sortCards[6].rank.rawValue == -1) {
                    isFourConsecutivePair = true
                }
            }
            
            if isStraight {
                if sortCards.count == 12 {
                    returnType = .ADragon
                } else {
                    returnType = .Straight
                }
            }
            
            if isThreeConsecutivePair {
                returnType = .ThreeConsecutivePair
            }
            
            if isFourConsecutivePair {
                returnType = .FourConsecutivePair
            }
            
        }
        
        self = returnType
    }
}

struct Card: Identifiable {
    var rank: Rank
    var suit: Suit
    var back: Bool = true
    var selected = false
    var imageName: String {
        if !back {
            return "\(suit)\(rank)"
        } else {
            return "Hidden"
        }
    }
    var id = UUID()
}

typealias Stack = [Card]

extension Stack where Element == Card {
    func sortByRank() -> Self{
        var sortedHand = Stack()
        var remainingCards = self
        if remainingCards.count >= 1 {
            for _ in 1 ... remainingCards.count{
                var highestCardIndex = 0
                for (i, _) in remainingCards.enumerated() {
                    if i + 1 < remainingCards.count{
                        if remainingCards[i + 1].rank > remainingCards[highestCardIndex].rank || (remainingCards[i + 1].rank == remainingCards[highestCardIndex].rank && remainingCards[i + 1].suit > remainingCards[highestCardIndex].suit){
                            highestCardIndex = i + 1
                        }
                    }
                }
                let hightestCard = remainingCards.remove(at: highestCardIndex)
                sortedHand.append(hightestCard)
            }
            sortedHand.reverse()
        }
        return sortedHand
    }
}

struct Player: Identifiable {
    var cards = Stack()
    var name = ""
    var playerIsMe = false
    var activePlay = false
    var incircle = true
    var inDifficulty = true
    var id = UUID()
}

struct Deck {
    private var cards = Stack()
    
    mutating func createFullDesk(){
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                cards.append(Card(rank: rank, suit: suit))
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func drawCard()-> Card {
        return cards.removeLast()
    }
    
    func cardRemaining() -> Int {
        return cards.count
    }
}

struct DiscardHand: Identifiable {
    var hand: Stack
    var handOwner: Player
    var id = UUID()
}



struct DivideCard {
    private(set) var discardedHands = [DiscardHand]()
    private(set) var players: [Player]

    init() {
        let opponents = [
            Player(name: "John"),
            Player(name: "Dorothy"),
            Player(name: "Lily")
        ]
        
        players = opponents
        players.append(Player(name: "Hoàng", playerIsMe: true))
        
        var deck = Deck()
        deck.createFullDesk()
        deck.shuffle()
        
        let randomStartingPlayerIndex = Int(arc4random()) % players.count
        
        while (deck.cardRemaining() > 0) {
            for p in randomStartingPlayerIndex...randomStartingPlayerIndex + (players.count - 1){
                let i = p % players.count
                var card = deck.drawCard()
                if players[i].playerIsMe {
                    card.back = false
                }
                players[i].cards.append(card)
            }
        }
        
        let tmp = players[0].cards.sortByRank()
        players[0].cards.removeAll()
        
        for t in tmp{
            players[0].cards.append(t)
        }
        
        let tmp1 = players[1].cards.sortByRank()
        players[1].cards.removeAll()
        
        for t in tmp1{
            players[1].cards.append(t)
        }
        
        let tmp2 = players[2].cards.sortByRank()
        players[2].cards.removeAll()
        
        for t in tmp2{
            players[2].cards.append(t)
        }
        
        let tmp3 = players[3].cards.sortByRank()
        players[3].cards.removeAll()
        
        for t in tmp3{
            players[3].cards.append(t)
        }
    }
    
    mutating func select(_ card: Card, in player: Player){
        if let cardIndex = player.cards.firstIndex(where: {$0.id == card.id}){
            if let playerIndex = players.firstIndex(where: {$0.id == player.id}){
                players[playerIndex].cards[cardIndex].selected.toggle()
            }
        }
    }
    
    mutating func playSelectCard(of player: Player){
        if let playerIndex = players.firstIndex(where: { $0.id == player.id }){
            var playerHand = players[playerIndex].cards.filter { $0.selected == true }
            let remainingCards = players[playerIndex].cards.filter { $0.selected == false }
            
            for i in 0 ..< playerHand.count {
                playerHand[i].back = false
            }
            discardedHands.append(DiscardHand(hand: playerHand, handOwner: player))
            players[playerIndex].cards = remainingCards
        }
    }
    
    mutating func getNextPlayerFromCurrent() -> Player{
        var nextActivePlayer = Player()
        
        for i in 0...3 {
            if !players[i].inDifficulty {
                NotInCircle(players[i])
            }
        }
        
        if let activePlayerIndex = players.firstIndex(where: { $0.activePlay == true}){
            for i in 1 ... 3{
                if players[(activePlayerIndex + i) % players.count].incircle && players[(activePlayerIndex + i) % players.count].inDifficulty{
                    let nextplayerIndex = ((activePlayerIndex + i) % players.count)
                    nextActivePlayer = players[nextplayerIndex]
                    // Deactivate current active player
                    players[activePlayerIndex].activePlay = false
                    //activatePlayer(nextActivePlayer)
                    break
                }
            }
        }
        var count = 0
        for player in players {
            if !player.incircle {
                count += 1
            }
        }
        if count == 3 {
            InCircle(players[0])
            InCircle(players[1])
            InCircle(players[2])
            InCircle(players[3])
        }
        return nextActivePlayer
    }
    
    
    mutating func activatePlayer(_ player: Player){
        if let playerIndex = players.firstIndex(where: {$0.id == player.id}){
            players[playerIndex].activePlay = true
        }
    }
    
    mutating func NotInCircle(_ player: Player){
        if let playerIndex = players.firstIndex(where: {$0.id == player.id}){
            players[playerIndex].incircle = false
        }
    }
    
    mutating func InCircle(_ player: Player){
        if let playerIndex = players.firstIndex(where: {$0.id == player.id}){
            players[playerIndex].incircle = true
        }
    }
    
    mutating func NotInDifficulty(_ player: Player){
        if let playerIndex = players.firstIndex(where: {$0.id == player.id}){
            players[playerIndex].inDifficulty = false
        }
    }
    
    func findStartingPlayer() -> Player {
        var score = reversedHandScore(players[3].cards)
        var index = 3
        for i in 0...2 {
            if players[i].inDifficulty {
                if score > reversedHandScore(players[i].cards) {
                    score = reversedHandScore(players[i].cards)
                    index = i
                }
            }
        }
        return players[index]
    }
    
    mutating func getCPUHand(of player: Player) -> Stack {
        let playerCardsByRank = player.cards.sortByRank()
        
        //Singles
        var validHands = combinations(playerCardsByRank, k: 1)
        
        //Pair, Threeleaves, Quads
        for i in 2...4 {
            if playerCardsByRank.count >= i {
                let possibleHands = combinations(playerCardsByRank, k: i)
                
                for j in 0 ..< possibleHands.count {
                    if HandType(possibleHands[j]) == .Pair {
                        validHands.append(possibleHands[j])
                    }
                    
                    if HandType(possibleHands[j]) == .ThreeLeaves {
                        validHands.append(possibleHands[j])
                    }
                    
                    if HandType(possibleHands[j]) == .Quads {
                        validHands.append(possibleHands[j])
                    }
                }
            } else {
                break
            }
        }
        
        //Straight, ThreeConsecutivePair, FourConsecutivePair, ADragon
        var possibleCombination = Stack()
        for card in playerCardsByRank{
            if card.rank != .Two {
                possibleCombination.append(card)
            }
        }
        for i in 0...9 {
            if possibleCombination.count >= i + 3 {
                let possibleHands = combinations(possibleCombination, k: possibleCombination.count - i)
                
                for j in 0 ..< possibleHands.count {
                    
                    if HandType(possibleHands[j]) == .Straight {
                        validHands.append(possibleHands[j])
                    }
                    
                    if HandType(possibleHands[j]) == .ThreeConsecutivePair {
                        validHands.append(possibleHands[j])
                    }
                    
                    if HandType(possibleHands[j]) == .FourConsecutivePair {
                        validHands.append(possibleHands[j])
                    }
                    
                    if HandType(possibleHands[j]) == .ADragon {
                        validHands.append(possibleHands[j])
                    }
                }
            } else {
                break
            }
        }
        
        var returnHand = Stack()

        
        if let lastDiscardHand = discardedHands.last {
            //Compare if hand is higher thann last discarded hand
            if !(player.id == lastDiscardHand.handOwner.id) {
                if lastDiscardHand.hand[0].rank == .Two {
                    let specialHand = priorityCardHands(validHands, type: "special")
                    for hand in specialHand {
                        if lastDiscardHand.hand.count == 1 && (HandType(hand) == .ThreeConsecutivePair || HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair) {
                            returnHand = hand
                        }
                        if lastDiscardHand.hand.count == 2 && (HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair) {
                            returnHand = hand
                        }
                    }
                }
                if HandType(lastDiscardHand.hand) == .ThreeConsecutivePair {
                    let specialHand = priorityCardHands(validHands, type: "special")
                    for hand in specialHand {
                        if ((HandType(hand) == .ThreeConsecutivePair && handScore(hand) > handScore(lastDiscardHand.hand)) || HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair) {
                            returnHand = hand
                        }
                    }
                }
                if HandType(lastDiscardHand.hand) == .Quads {
                    let specialHand = priorityCardHands(validHands, type: "special")
                    for hand in specialHand {
                        if ((HandType(hand) == .Quads && handScore(hand) > handScore(lastDiscardHand.hand)) || HandType(hand) == .FourConsecutivePair){
                            returnHand = hand
                        }
                    }
                }
                if HandType(lastDiscardHand.hand) == .FourConsecutivePair {
                    let specialHand = priorityCardHands(validHands, type: "special")
                    for hand in specialHand {
                        if (HandType(hand) == .FourConsecutivePair) && handScore(lastDiscardHand.hand) < handScore(hand){
                            returnHand = hand
                        }
                    }
                }
                if HandType(lastDiscardHand.hand) == .Single{
                    let singleHand = priorityCardHands(validHands, type: "verySingle").count != 0 ? priorityCardHands(validHands, type: "verySingle") : priorityCardHands(validHands, type: "single")
                    for hand in singleHand {
                        if handScore(hand) > handScore(lastDiscardHand.hand) {
                            returnHand = hand
                        }
                    }
                } else if HandType(lastDiscardHand.hand) == .Pair {
                    let pairHand = priorityCardHands(validHands, type: "pair")
                    for hand in pairHand {
                        if handScore(hand) > handScore(lastDiscardHand.hand) {
                            returnHand = hand
                        }
                    }
                } else if HandType(lastDiscardHand.hand) == .ThreeLeaves {
                    let threeLeavesHand = priorityCardHands(validHands, type: "threeLeaves")
                    for hand in threeLeavesHand {
                        if handScore(hand) > handScore(lastDiscardHand.hand){
                            returnHand = hand
                        }
                    }
                } else if HandType(lastDiscardHand.hand) == .Straight || HandType(lastDiscardHand.hand) == .ADragon {
                    let straightHand = priorityCardHands(validHands, type: "validStraight").reversed()
                    for hand in straightHand {
                        if handScore(hand) > handScore(lastDiscardHand.hand) && hand.count == lastDiscardHand.hand.count {
                            returnHand = hand
                        }
                    }
                }
            } else {
                let singleHand = priorityCardHands(validHands, type: "verySingle")
                let pairHand = priorityCardHands(validHands, type: "pair")
                let threeLeavesHand = priorityCardHands(validHands, type: "threeLeaves")
                let straightHand = priorityCardHands(validHands, type: "straight")
                let specialHand = priorityCardHands(validHands, type: "special")
                if singleHand.count == 0 && pairHand.count == 0 && threeLeavesHand.count == 0 && straightHand.count == 0 && specialHand.count != 0 {
                    for hand in specialHand {
                        returnHand = hand
                        break
                    }
                } else {
                    var randomHand = singleHand
                    for hand in pairHand {
                        randomHand.append(hand)
                    }
                    for hand in threeLeavesHand {
                        randomHand.append(hand)
                    }
                    for hand in straightHand {
                        randomHand.append(hand)
                    }
                    randomHand.shuffle()  // Randome hands
                    var status = false
                    for hand in randomHand {
                        if handScore(hand) <= 36 {
                            status = true
                            returnHand = hand
                            break
                        }
                    }
                    if !status {
                        for hand in randomHand {
                            if player.cards.count > 7 && specialHand.count == 0{
                                let randomInt = Int.random(in: 0..<3)
                                if randomInt == 0 || randomInt == 1{
                                    if hand[0].rank != .Two {
                                        returnHand = hand
                                        break
                                    }
                                } else {
                                    returnHand = hand
                                    break
                                }
                            } else {
                                returnHand = hand
                                break
                            }
                        }
                    }
                }
            }
        } else {
            var status = false
            for hand in validHands {
                if hand.contains(where: { $0.rank == Rank.Three && $0.suit == Suit.Spades}){
                    returnHand = hand
                    status = true
                }
            }
            if !status {
                let singleHand = priorityCardHands(validHands, type: "verySingle")
                let pairHand = priorityCardHands(validHands, type: "pair")
                let threeLeavesHand = priorityCardHands(validHands, type: "threeLeaves")
                let straightHand = priorityCardHands(validHands, type: "straight")
                var randomHand = singleHand
                for hand in pairHand {
                    randomHand.append(hand)
                }
                for hand in threeLeavesHand {
                    randomHand.append(hand)
                }
                for hand in straightHand {
                    randomHand.append(hand)
                }
                randomHand.shuffle()  // Randome hands
                for hand in randomHand {
                    if(handScore(hand) < 33 || HandType(hand) == .Straight && hand.count >= 6){
                        returnHand = hand
                        status = true
                        break
                    }
                }
            }
            if !status {
                let singleHand = priorityCardHands(validHands, type: "verySingle")
                let pairHand = priorityCardHands(validHands, type: "pair")
                let threeLeavesHand = priorityCardHands(validHands, type: "threeLeaves")
                let straightHand = priorityCardHands(validHands, type: "straight")
                var randomHand = singleHand
                for hand in pairHand {
                    randomHand.append(hand)
                }
                for hand in threeLeavesHand {
                    randomHand.append(hand)
                }
                for hand in straightHand {
                    randomHand.append(hand)
                }
                randomHand.shuffle()  // Randome hands
                for hand in randomHand {
                    if(hand[0].rank != .Two){
                        returnHand = hand
                        break
                    }
                }
            }
        }
        
        if returnHand.count == 0 {
            NotInCircle(player)
        }
        return returnHand
    }
    
    
    func playable(_ hand: Stack, of player: Player) -> Bool{
        var able = false
        
        if let lastDiscardHand = discardedHands.last {
            //Compare if hand is higher thann last discarded hand
            if HandType(hand) != .Invalid {
                if ((handScore(hand) > handScore(lastDiscardHand.hand)) && (hand.count == lastDiscardHand.hand.count) && (HandType(hand) == HandType(lastDiscardHand.hand))) ||
                    ((lastDiscardHand.hand[0].rank == .Two) && (lastDiscardHand.hand.count == 1) && (HandType(hand) == .ThreeConsecutivePair || HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair)) ||
                    ((lastDiscardHand.hand[0].rank == .Two) && (lastDiscardHand.hand.count == 2) && (HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair)) ||
                    HandType(lastDiscardHand.hand) == .ThreeConsecutivePair && ((HandType(hand) == .ThreeConsecutivePair && handScore(hand) > handScore(lastDiscardHand.hand)) || HandType(hand) == .Quads || HandType(hand) == .FourConsecutivePair) ||
                    HandType(lastDiscardHand.hand) == .Quads && ((HandType(hand) == .Quads && handScore(hand) > handScore(lastDiscardHand.hand)) || HandType(hand) == .FourConsecutivePair) ||
                    HandType(lastDiscardHand.hand) == .FourConsecutivePair && HandType(hand) == .FourConsecutivePair && handScore(hand) > handScore(lastDiscardHand.hand) ||
                    player.id == lastDiscardHand.handOwner.id {
                    able = true
                }
            }
        } else {
            if HandType(hand) != .Invalid {
                if players[3].cards.contains(where: {$0.rank == Rank.Three && $0.suit == Suit.Spades}){
                    if hand.contains(where: { $0.rank == Rank.Three && $0.suit == Suit.Spades}){
                        able = true
                    }
                } else {
                    able = true
                }
            }
        }
        
        return able
    }
    
    func priorityCardHands(_ unsortedHands: [Stack], type: String) -> [Stack] {
        var sortedHands = [Stack]()
        let remainingHands = unsortedHands
        
        var pairHands = [Stack]()
        var straightHands = [Stack]()
        var validStraightHands = [Stack]()
        var threeLeavesHands = [Stack]()
        var specialHands = [Stack]()
        var verySingleHands = [Stack]()
        var singleHands = [Stack]()
        var containsHands = [Card]()
        var containsNormalHands = [Card]()
        
        // ThreeConsecutivePair, FourConsecutivePair, Quads
        for i in 0 ..< remainingHands.count {
            if HandType(remainingHands[i]) == .ThreeConsecutivePair || HandType(remainingHands[i]) == .FourConsecutivePair || HandType(remainingHands[i]) == .Quads {
                specialHands.append(remainingHands[i])
                for j in 0 ..< remainingHands[i].count {
                    containsHands.append(remainingHands[i][j])
                    containsNormalHands.append(remainingHands[i][j])
                }
            }
        }
        
        // validStraight
        if remainingHands.count > 0 {
            for i in 0 ..< remainingHands.count {
                if HandType(remainingHands[i]) == .Straight || HandType(remainingHands[i]) == .ADragon{
                    if containsHands.count == 0 {
                        validStraightHands.append(remainingHands[i])
                        for j in 0 ..< remainingHands[i].count {
                            containsNormalHands.append(remainingHands[i][j])
                        }
                    } else {
                        var isAppear = false
                        for j in 0 ..< remainingHands[i].count {
                            for k in 0 ..< containsHands.count {
                                if remainingHands[i][j].rank == containsHands[k].rank && remainingHands[i][j].suit == containsHands[k].suit {
                                    isAppear = true
                                    break
                                }
                            }
                            if isAppear {
                                break
                            }
                        }
                        if isAppear {
                            continue
                        } else {
                            validStraightHands.append(remainingHands[i])
                            for j in 0 ..< remainingHands[i].count {
                                containsNormalHands.append(remainingHands[i][j])
                            }
                        }
                    }
                }
            }
        }
        
        // Straight
        if remainingHands.count > 0 {
            var contains = containsHands
            for i in 0...9 {
                for j in 0 ..< remainingHands.count {
                    if HandType(remainingHands[j]) == .Straight || HandType(remainingHands[j]) == .ADragon {
                        if remainingHands[j].count == 12 - i {
                            if contains.count == 0 {
                                straightHands.append(remainingHands[j])
                                for k in 0 ..< remainingHands[j].count {
                                    contains.append(remainingHands[j][k])
                                }
                            } else {
                                var isAppear = false
                                for l in 0 ..< contains.count {
                                    for k in 0 ..< remainingHands[j].count {
                                        if contains[l].rank == remainingHands[j][k].rank && contains[l].suit == remainingHands[j][k].suit {
                                            isAppear = true
                                            break
                                        }
                                    }
                                    if isAppear {
                                        break
                                    }
                                }
                                if isAppear {
                                    continue
                                } else {
                                    straightHands.append(remainingHands[j])
                                    for k in 0 ..< remainingHands[j].count {
                                        contains.append(remainingHands[j][k])
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Pair
        if remainingHands.count > 0 {
            for i in 0 ..< remainingHands.count {
                if HandType(remainingHands[i]) == .Pair {
                    if containsHands.count == 0 {
                        pairHands.append(remainingHands[i])
                        for j in 0 ..< remainingHands[i].count {
                            if remainingHands[i][j].rank != .Two {
                                containsNormalHands.append(remainingHands[i][j])
                            }
                        }
                    } else {
                        var isAppear = false
                        for j in 0 ..< remainingHands[i].count {
                            for k in 0 ..< containsHands.count {
                                if remainingHands[i][j].rank == containsHands[k].rank && remainingHands[i][j].suit == containsHands[k].suit {
                                    isAppear = true
                                    break
                                }
                            }
                            if isAppear {
                                break
                            }
                        }
                        if isAppear {
                            continue
                        } else {
                            pairHands.append(remainingHands[i])
                            for j in 0 ..< remainingHands[i].count {
                                if remainingHands[i][j].rank != .Two {
                                    containsNormalHands.append(remainingHands[i][j])
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // ThreeLeaves
        if remainingHands.count > 0 {
            for i in 0 ..< remainingHands.count {
                if HandType(remainingHands[i]) == .ThreeLeaves {
                    if containsHands.count == 0 {
                        threeLeavesHands.append(remainingHands[i])
                        for j in 0 ..< remainingHands[i].count {
                            if remainingHands[i][j].rank != .Two {
                                containsNormalHands.append(remainingHands[i][j])
                            }
                        }
                    } else {
                        var isAppear = false
                        for j in 0 ..< remainingHands[i].count {
                            for k in 0 ..< containsHands.count {
                                if remainingHands[i][j].rank == containsHands[k].rank && remainingHands[i][j].suit == containsHands[k].suit {
                                    isAppear = true
                                    break
                                }
                            }
                            if isAppear {
                                break
                            }
                        }
                        if isAppear {
                            continue
                        } else {
                            threeLeavesHands.append(remainingHands[i])
                            for j in 0 ..< remainingHands[i].count {
                                if remainingHands[i][j].rank != .Two {
                                    containsNormalHands.append(remainingHands[i][j])
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Single without containing any other type
        if remainingHands.count > 0 {
            for i in 0 ..< remainingHands.count {
                if HandType(remainingHands[i]) == .Single {
                    if containsNormalHands.count == 0 {
                        verySingleHands.append(remainingHands[i])
                    } else {
                        var isAppear = false
                        for j in 0 ..< remainingHands[i].count {
                            for k in 0 ..< containsNormalHands.count {
                                if remainingHands[i][j].rank == containsNormalHands[k].rank && remainingHands[i][j].suit == containsNormalHands[k].suit {
                                    isAppear = true
                                    break
                                }
                            }
                            if isAppear {
                                break
                            }
                        }
                        if isAppear {
                            continue
                        } else {
                            verySingleHands.append(remainingHands[i])
                        }
                    }
                }
            }
        }
        
        // VerySingle without contain special type
        if remainingHands.count > 0 {
            for i in 0 ..< remainingHands.count {
                if HandType(remainingHands[i]) == .Single {
                    if containsHands.count == 0 {
                        singleHands.append(remainingHands[i])
                    } else {
                        var isAppear = false
                        for j in 0 ..< remainingHands[i].count {
                            for k in 0 ..< containsHands.count {
                                if remainingHands[i][j].rank == containsHands[k].rank && remainingHands[i][j].suit == containsHands[k].suit {
                                    isAppear = true
                                    break
                                }
                            }
                            if isAppear {
                                break
                            }
                        }
                        if isAppear {
                            continue
                        } else {
                            singleHands.append(remainingHands[i])
                        }
                    }
                }
            }
        }
        if type == "single"{
            sortedHands = singleHands
        } else if type == "verySingle" {
            sortedHands = verySingleHands
        } else if type == "pair" {
            sortedHands = pairHands
        } else if type == "threeLeaves" {
            sortedHands = threeLeavesHands
        }else if type == "validStraight" {
            sortedHands = validStraightHands
        } else if type == "straight" {
            sortedHands = straightHands
        } else {
            sortedHands = specialHands
        }
        
        return sortedHands
    }
    
    func handScore(_ hand: Stack) -> Int {
        var score = 0
        let handsort = hand.sortByRank()
        if handsort.count > 0 {
            let rank = handsort[handsort.count - 1].rank.rawValue
            let suit = handsort[handsort.count - 1].suit.rawValue
            
            score = 4 * (rank - 1) + suit
        }
        return score
    }
    
    func reversedHandScore(_ hand: Stack) -> Int {
        var score = 0
        let handsort = hand.sortByRank().reversed()
        if handsort.count > 0 {
            var rank = 0
            var suit = 0
            for i in handsort {
                rank = i.rank.rawValue
                suit = i.suit.rawValue
            }
            
            score = 4 * (rank - 1) + suit
        }
        return score
    }
    
    func combinations(_ cardArray: Stack, k: Int) -> [Stack] {
        var sub = [Stack]()
        var ret = [Stack]()
        var next = Stack()
        
        for i in 0 ..< cardArray.count {
            if k == 1 {
                var tempHand = Stack()
                tempHand.append(cardArray[i])
                ret.append(tempHand)
            } else {
                sub = combinations(sliceArray(cardArray, x1: i + 1, x2: cardArray.count - 1), k: k - 1)
                
                for subI in 0 ..< sub.count {
                    next = sub[subI]
                    next.append(cardArray[i])
                    ret.append(next)
                }
            }
        }
        
        return ret
    }
    
    func sliceArray(_ cardArray: Stack, x1: Int, x2: Int) -> Stack {
        var sliced = Stack()
        
        if x1 <= x2 {
            for i in x1 ... x2 {
                sliced.append(cardArray[i])
            }
        }
        
        return sliced
    }
    
    mutating func restart(){
        self = DivideCard()
    }
}
