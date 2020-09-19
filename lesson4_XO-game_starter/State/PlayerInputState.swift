//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Оксана Зверева on 12.08.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//
public class PlayerInputState: GameState {

    public private(set) var isCompleted = false
    
    public var isComputerGame: Bool
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    public let markViewPrototype: MarkView
    public let typePlayer: PlayerType
    
    
    init(player: Player,  markViewPrototype: MarkView,gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, isComputerGame: Bool, typePlayer: PlayerType) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.isComputerGame = isComputerGame
        self.typePlayer = typePlayer
    }
    
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition, freePosition: GameboardPosition) {
        
        Log(.playerInput(player: self.player, typePlayer: self.typePlayer, position: position))

        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position)
            else { return }
        if typePlayer == .computer {
            self.gameboard?.setPlayer(self.player, at: freePosition)
            self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: freePosition)
        } else {
            self.gameboard?.setPlayer(self.player, at: position)
            self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
        }
       
        self.isCompleted = true
    }
    
//    public func addMark(at position: GameboardPosition) {
//        guard let gameboardView = self.gameboardView
//            , gameboardView.canPlaceMarkView(at: position)
//            else { return }
//
//        let markView: MarkView
//        switch self.player {
//        case .first:
//            markView = XView()
//        case .second:
//            markView = OView()
//        }
//        self.gameboard?.setPlayer(self.player, at: position)
//        self.gameboardView?.placeMarkView(markView, at: position)
//        self.isCompleted = true
//    }
}
