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

struct CardPlayerView: View {
    @ObservedObject var Thirdteen = TienLenGame()
    @State private var counter = 0
    @State private var buttonText:LocalizedStringKey = "pass-str"
    @State private var isSelect = false
    @State private var isReset = false
    @State private var Bet50 = 50
    @State private var Bet10 = 10
    @State private var isChooseBet50 = false
    @State private var isChooseBet10 = true
    @State private var disapear = false
    @State private var isDisapear = false
    @State private var minus = false
    @State private var add = false
    //@State private var coin = 500
    @EnvironmentObject var model: ModelData
    var acc: [Accounts] {
        model.account.filter{ a in
            (a.name == "Hoàng")
        }
    }
    var num1: Int
    var num2: Int
    var num3: Int
    @AppStorage("myCoin") var myCoin = 500
    @AppStorage("win") var win = 0
    @AppStorage("lose") var lose = 0
    @AppStorage("difficult") var dif = "easy"
    @AppStorage("isDark") var isDark = false
    @AppStorage("sound") var sound = true
    
    private func chooseBet50(){
        isChooseBet50 = true
        isChooseBet10 = false
    }
    
    private func chooseBet10(){
        isChooseBet50 = false
        isChooseBet10 = true
    }
    
    private func addCoin(){
        if isChooseBet10{
            if dif == "hard"{
                myCoin += 30
            } else if dif == "medium" {
                myCoin += 20
            } else {
                myCoin += 10
            }
            win += 1
        } else {
            if dif == "hard"{
                myCoin += 150
            } else if dif == "medium" {
                myCoin += 100
            } else {
                myCoin += 50
            }
            win += 1
        }
    }
    
    private func minusCoin(){
        if isChooseBet10{
            myCoin -= 10
            lose += 1
        } else {
            myCoin -= 50
            lose += 1
        }
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //Animation
    @State private var dealt = Set<UUID>()
    @State private var discard = Set<UUID>()
    private func deal(_ card: Card){
        dealt.insert(card.id)
    }
    
    private func discard(_ card: Card){
        dealt.remove(card.id)
        discard.insert(card.id)
    }
    
    private func dealt(_ card:  Card) -> Bool{
        dealt.contains(card.id)
    }

    private func discarded(_ card:  Card) -> Bool{
        discard.contains(card.id)
    }
    
    private func resetAll(){
        dealt.removeAll()
        discard.removeAll()
        isSelect = false
        counter = -4
        isReset = true
        disapear = false
    }
    
    private func dealAnimation(for card: Card, in player: Player) -> Animation {
        var delay = 0.0
        if let index = player.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (3 / Double(player.cards.count))
        }
        return Animation.easeInOut(duration: 0.5).delay(delay)
    }
    
    @Namespace private var dealingNamespace
    
    
    var body: some View {
        let otherAcc = model.account.filter({$0.name != "Hoàng"})
        GeometryReader { geo in
            ZStack{
                BackgroundPage()
                BackgroundIcon()
                VStack {
                    ZStack {
                        MemberPlayer(image: otherAcc[num1].name, isActive: Thirdteen.players[1].activePlay, name: otherAcc[num1].name, card: Thirdteen.players[1].cards.count)
                            .offset(y: -20)
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(60), spacing: -59), count: Thirdteen.players[1].cards.count)){
                            ForEach(Thirdteen.players[1].cards) { card in
                                if dealt(card) || discarded(card) {
                                    CardView(cardName: card.imageName)
                                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                }
                            }
                        }
                        .padding(.horizontal, 70)
                        .opacity(0.0)
                        .offset(y: -30)
                        .onAppear {
                            for card in Thirdteen.players[1].cards {
                                withAnimation(dealAnimation(for: card, in: Thirdteen.players[1])) {
                                    deal(card)
                                }
                            }
                        }
                        .onChange(of: isReset){ _ in
                            for card in Thirdteen.players[1].cards {
                                withAnimation(dealAnimation(for: card, in: Thirdteen.players[1])) {
                                    deal(card)
                                }
                            }
                        }
                    }
                    .padding()
                    ZStack{
                        HStack {
                            Group {
                                MemberPlayer(image: otherAcc[num2].name, isActive: Thirdteen.players[0].activePlay, name: otherAcc[num2].name, card: Thirdteen.players[0].cards.count)
                                        .opacity(dif == "medium" || dif == "hard" ? 1 : 0)
                                
                                Spacer()
                                
                                MemberPlayer(image: otherAcc[num3].name, isActive: Thirdteen.players[2].activePlay, name: otherAcc[num3].name, card: Thirdteen.players[2].cards.count)
                                        .opacity(dif == "hard" ? 1 : 0)

                            }
                            .offset(y: -80)
                        }
                        HStack {
                                LazyHGrid(rows: [
                                    GridItem(.adaptive(minimum: 90), spacing: -89)
                                ]){
                                    ForEach(Thirdteen.players[0].cards) { card in
                                        if dealt(card) || discarded(card) {
                                            CardView(cardName: card.imageName)
                                                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                        }
                                    }
                                }
                                .padding()
                                .opacity(0.0)
                                .onAppear {
                                    for card in Thirdteen.players[0].cards {
                                        withAnimation(dealAnimation(for: card, in: Thirdteen.players[0])) {
                                            if dif == "medium" || dif == "hard" {
                                                deal(card)
                                            }
                                        }
                                    }
                                }
                                .onChange(of: isReset){ _ in
                                    for card in Thirdteen.players[0].cards {
                                        withAnimation(dealAnimation(for: card, in: Thirdteen.players[0])) {
                                            if dif == "medium" || dif == "hard" {
                                                deal(card)
                                            }
                                        }
                                    }
                                }
                            
                            Spacer()
                            
                                LazyHGrid(rows: [
                                    GridItem(.adaptive(minimum: 90), spacing: -89)
                                ]){
                                    ForEach(Thirdteen.players[2].cards) { card in
                                        if dealt(card) || discarded(card) {
                                            CardView(cardName: card.imageName)
                                                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                        }
                                    }
                                }
                                .padding()
                                .opacity(0.0)
                                .onAppear {
                                    for card in Thirdteen.players[2].cards {
                                        withAnimation(dealAnimation(for: card, in: Thirdteen.players[2])) {
                                            if dif == "medium" || dif == "hard"{
                                                deal(card)
                                            }
                                        }
                                    }
                                }
                                .onChange(of: isReset){ _ in
                                    for card in Thirdteen.players[2].cards {
                                        withAnimation(dealAnimation(for: card, in: Thirdteen.players[2])) {
                                            if dif == "hard"{
                                                deal(card)
                                            }
                                        }
                                    }
                                }
                        }
                        .offset(y: -80)
                    }
                    .frame(minHeight: 170)
                        let isMe = Thirdteen.players[3]
                        let coin = myCoin
                        ZStack {
                            MemberPlayer(image: acc[0].name, isActive: isMe.activePlay, name: acc[0].name, card: isMe.cards.count)
                                .offset(y: 5)
                            let pet = isChooseBet10 && dif == "easy" ? Bet10 : isChooseBet10 && dif == "medium" ? Bet10 * 2 : isChooseBet10 && dif == "hard" ? Bet10 * 3 : isChooseBet50 && dif == "easy" ? Bet50 : isChooseBet50 && dif == "medium" ? Bet50 * 2 : Bet50 * 3
                            MyMonneyLabel(coins: coin, minus: minus, add: add, coin: add && !minus ? pet : isChooseBet10 ? Bet10 : Bet50)
                                .offset(x: -15, y: -10)
                                .opacity(isMe.activePlay ? 0.7 : 0.4)
                                .onChange(of: Thirdteen.gameOver) { _ in
                                    if Thirdteen.gameOver {
                                        if Thirdteen.activePlayer.playerIsMe {
                                            add = true
                                            minus = false
                                        } else {
                                            add = false
                                            minus = true
                                        }
                                    } else {
                                        add = false
                                        minus = false
                                    }
                                }
                        }
                        .padding()
                        .offset(y: 30)
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(90), spacing: -67), count: isMe.cards.count)){
                            ForEach(isMe.cards) { card in
                                if dealt(card) || discarded(card){
                                    CardView(cardName: card.imageName)
                                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                        .offset(y: card.selected ? -30 : 0)
                                        .onTapGesture{
                                            withAnimation(.easeInOut(duration: 0.15)) {
                                                Thirdteen.select(card, in: isMe)
                                            }
                                            let selectedCards = Thirdteen.players[3].cards.filter {
                                                $0.selected == true
                                            }
                                            if isMe.activePlay {
                                                if selectedCards.count > 0 && Thirdteen.playable(selectedCards, of: isMe) {
                                                    buttonText = "play-str"
                                                    isSelect = true
                                                } else {
                                                    buttonText = "pass-str"
                                                    isSelect = false
                                                }
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                        .onAppear {
                            for card in isMe.cards {
                                withAnimation(dealAnimation(for: card, in: isMe)) {
                                    deal(card)
                                }
                            }
                        }
                        .onChange(of: isReset){ _ in
                            for card in isMe.cards {
                                withAnimation(dealAnimation(for: card, in: isMe)) {
                                    deal(card)
                                }
                            }
                            isReset = false
                        }
                        Button {
                            counter = -1
                            if isSelect {
                                let selectedCards = isMe.cards.filter {$0.selected == true}
                                for card in selectedCards {
                                    withAnimation(.easeInOut.delay(0.2)){
                                        discard(card)
                                    }
                                }
                                
                                Thirdteen.playSelectedCard(of: isMe)
                                isSelect = false
                                buttonText = "pass-str"
                            } else {
                                Thirdteen.NotInCircle(isMe)
                            }
                        } label: {
                            Text(buttonText)
                                .foregroundColor(Color("Purple"))
                                .modifier(Thirteen_Cards.buttonStyle())
                                .opacity(isMe.activePlay ? 0.9 : 0.4)
                        }
                        .modifier(ShadowModifier())
                        .disabled(!isMe.activePlay ? true : false)
                }
                deckBody
                    .onAppear {
                        if sound {
                            playSound(sound: "Divide_Card", type: "mp3")
                        }
                    }
                ZStack{
                    VStack {
                        ZStack {
                            ForEach(Thirdteen.discardedHands) { discardhand in
                                let i = Thirdteen.discardedHands.firstIndex(where: { $0.id == discardhand.id})
                                let lastdiscard: Bool = (i == Thirdteen.discardedHands.count - 1)
                                let prevdiscard: Bool = (i == Thirdteen.discardedHands.count - 2)
                                LazyVGrid(columns: Array(repeating: GridItem(.fixed(80), spacing: discardhand.hand.count < 6 ? -35 : -50), count: discardhand.hand.count)){
                                    ForEach(discardhand.hand) { card in
                                        if discarded(card) {
                                            CardView(cardName: card.imageName)
                                                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                                                .onAppear(){
                                                    if sound && !Thirdteen.gameOver {
                                                        playSound(sound: "bet_card", type: "mp3")
                                                    }
                                                }
                                        }
                                    }
                                }
                                .scaleEffect(lastdiscard ? 0.80 : 0.55)
                                .opacity(lastdiscard ? 1 : prevdiscard ? 0.6 : 0)
                                .offset(y: lastdiscard ? 0 : -40)
                            }
                        }
                        .opacity(disapear ? 0 : 1)
                        .onChange(of: isDisapear) { newValue in
                            withAnimation(.easeInOut(duration: 1.5)){
                                disapear = true
                            }
                        }
                        let lastIndex = Thirdteen.discardedHands.count - 1
                        if lastIndex >= 0 {
                            let playerName = Thirdteen.discardedHands[lastIndex].handOwner.name == "John" ? otherAcc[num2].name : Thirdteen.discardedHands[lastIndex].handOwner.name == "Dorothy" ? otherAcc[num1].name : Thirdteen.discardedHands[lastIndex].handOwner.name == "Lily" ? otherAcc[num3].name : acc[0].name
                            let handPlay = Thirdteen.discardedHands[lastIndex].hand
                            let handType = "\(Thirdteen.evaluateHand(handPlay))"
                            if handType == "Invalid" {
                                Text("\(playerName): invalid-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "Single" {
                                Text("\(playerName): single-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "Pair" {
                                Text("\(playerName): pair-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "ThreeLeaves" {
                                Text("\(playerName): threeLeaves-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "ThreeConsecutivePair" {
                                Text("\(playerName): threeConsecutivePair-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "Quads" {
                                Text("\(playerName): quads-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "FourConsecutivePair" {
                                Text("\(playerName): fourConsecutivePair-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else if handType == "Straight" {
                                Text("\(playerName): straight-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            } else {
                                Text("\(playerName): aDragon-str")
                                    .font(.system(size: 14))
                                    .foregroundColor(isDark ? .white : .black)
                                    .opacity(disapear ? 0 : 1)
                                    .onChange(of: Thirdteen.gameOver) { newValue in
                                        withAnimation(.easeInOut(duration: 1.5)){
                                            disapear = true
                                        }
                                    }
                            }
                        }
                    }
                    .offset(y: -100)
                    if Thirdteen.gameOver {
                        VStack{
                            let name = Thirdteen.activePlayer.name == "John" ? otherAcc[num2].name : Thirdteen.activePlayer.name == "Dorothy" ? otherAcc[num1].name : Thirdteen.activePlayer.name == "Lily" ? otherAcc[num3].name : acc[0].name
                            GameOver(playerName: name)
                            Button ("restart-str") {
                                Thirdteen.restart()
                                resetAll()
                                if dif == "easy" {
                                    Thirdteen.NotInDifficulty(Thirdteen.players[0])
                                    Thirdteen.NotInDifficulty(Thirdteen.players[2])
                                } else if dif == "medium" {
                                    Thirdteen.NotInDifficulty(Thirdteen.players[2])
                                }
                                if sound {
                                    playSound(sound: "Divide_Card", type: "mp3")
                                }
                            }
                            .offset(y: -60)
                            .foregroundColor(Thirdteen.activePlayer.playerIsMe ? .red : Color("Purple"))
                            .buttonStyle(.bordered)
                            .tint(Thirdteen.activePlayer.playerIsMe ? .red : .purple)
                            HStack {
                                // MARK: - BET 50 BUTTON
                                Button {
                                    self.chooseBet50()
                                    if sound{
                                        playSound(sound: "bet-chip", type: "mp3")
                                    }
                                } label: {
                                    HStack(spacing: 30){
                                        Text("\(Bet50)")
                                            .foregroundColor(!isChooseBet50 ? Color("PurpleSet3") : Color.white)
                                            .modifier(BetCapsuleModifier())
                                       Image("casino-chips")
                                            .resizable()
                                            .offset(x: isChooseBet50 ? 0 : 18)
                                            .opacity(isChooseBet50 ? 1 : 0 )
                                            .modifier(CasinoChipModifier())
                                            .animation(.default, value: isChooseBet50)
                                    }
                                    .padding(.horizontal, 12)
                                }
                                .modifier(ShadowModifier())
                                .padding(30)
                                
                                Spacer()
                                
                                // MARK: - BET 10 BUTTON
                                Button {
                                    self.chooseBet10()
                                    if sound{
                                        playSound(sound: "bet-chip", type: "mp3")
                                    }
                                } label: {
                                    HStack(spacing: 30){
                                        Image("casino-chips")
                                             .resizable()
                                             .offset(x: isChooseBet10 ? 0 : -18)
                                             .opacity(isChooseBet10 ? 1 : 0 )
                                             .modifier(CasinoChipModifier())
                                             .animation(.default, value: isChooseBet50)
                                        Text("\(Bet10)")
                                            .foregroundColor(!isChooseBet10 ? Color("PurpleSet3") : Color.white)
                                            .modifier(BetCapsuleModifier())
                                       
                                    }
                                    .padding(.horizontal, 12)
                                }
                                .modifier(ShadowModifier())
                                .padding(30)
                            }
                            .offset(y: -80)
                        }
                        .offset(y: -100)
                        .onAppear(){
                            isDisapear = !isDisapear
                            if Thirdteen.gameOver {
                                if add {
                                    addCoin()
                                    if sound {
                                        playSound(sound: "winning", type: "mp3")
                                    }
                                } else {
                                    minusCoin()
                                    if sound {
                                        playSound(sound: "gameover", type: "mp3")
                                    }
                                }
                            }
                        }
                    }
                }
                .offset(y: 35)
            }
        }
        .onChange(of: Thirdteen.activePlayer.name) { _ in
            if !Thirdteen.activePlayer.playerIsMe {
                    let cpuHand = Thirdteen.getCPUHand(of: Thirdteen.activePlayer)
                    if cpuHand.count > 0 {
                        for i in 0 ... cpuHand.count - 1 {
                            Thirdteen.select(cpuHand[i], in: Thirdteen.activePlayer)
                        }
                        for card in cpuHand {
                            withAnimation(.easeInOut){
                                discard(card)
                            }
                        }
                        Thirdteen.playSelectedCard(of: Thirdteen.activePlayer)
                    }
            }
        }
        .onReceive(timer) { time in
            var nextPlayer = Player()
            counter += 1
            if counter >= 1 && !Thirdteen.gameOver {
                if Thirdteen.discardedHands.count == 0 {
                    nextPlayer = Thirdteen.findStartingPlayer()
                } else {
                    nextPlayer = Thirdteen.getNextPlayer()
                }
                Thirdteen.activatePlayer(nextPlayer)
                if nextPlayer.playerIsMe {
                    counter = -24
                } else {
                    counter = -1
                }
            }
        }
        .onAppear {
            counter = -4
            if dif == "easy" {
                Thirdteen.NotInDifficulty(Thirdteen.players[0])
                Thirdteen.NotInDifficulty(Thirdteen.players[2])
            } else if dif == "medium" {
                Thirdteen.NotInDifficulty(Thirdteen.players[2])
            }
        }
        
        
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(Thirdteen.players[1].cards.filter { !dealt($0)}) { card in
                CardView(cardName: card.imageName)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .offset(y: -40)
            }
            ForEach(Thirdteen.players[3].cards.filter { !dealt($0)}) { card in
                CardView(cardName: card.imageName)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .offset(y: -40)
            }
            if dif == "medium" || dif == "hard" {
                ForEach(Thirdteen.players[0].cards.filter { !dealt($0)}) { card in
                    CardView(cardName: card.imageName)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                        .offset(y: -40)
                }
            }
            if dif == "hard" {
                ForEach(Thirdteen.players[2].cards.filter { !dealt($0)}) { card in
                    CardView(cardName: card.imageName)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                        .offset(y: -40)
                }
            }
        }
        .frame(width: 60, height: 90)
    }
}

struct CardView: View {
    let cardName: String
    var body: some View {
        Image(cardName)
            .resizable()
            .aspectRatio(2/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10).stroke(Color("GreyWhite"), lineWidth: 3)
            }
    }
}


                    

struct CardPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        CardPlayerView(num1: 2, num2: 4, num3: 7)
    }
}
