//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet weak var changeGameTypeSegmentControl: UISegmentedControl!
    
    
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    var isComputerGame = true
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //получить значение переключателя для типа игры
//        if changeGameTypeSegmentControl.selectedSegmentIndex == 1 {
//            self.isComputerGame = true
//        }
//        else {
//            self.isComputerGame = false
//        }
//
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            //self.gameboardView.placeMarkView(XView(), at: position)
            self.currentState.addMark(at: position, freePosition: self.gameboard.freePositons() )
            print ("position = \(position)")
            if self.currentState.isCompleted {
                self.goToNextState()
            }
            

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        //получить значение переключателя для типа игры
//        if changeGameTypeSegmentControl.selectedSegmentIndex == 1 {
//            self.isComputerGame = true
//        }
//        else {
//            self.isComputerGame = false
//        }
        
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        
        gameboard.clear()
        gameboardView.clear()
        let player = Player.first
        currentState = PlayerInputState(player: player,
                                        markViewPrototype: player.markViewPrototype,
                                        gameViewController: self,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView,
                                        isComputerGame: self.isComputerGame,
                                        typePlayer: .human)

        
    }
    
//    private func goToFirstState() {
//        self.currentState = PlayerInputState(player: .first,
//                                             gameViewController: self,
//                                             gameboard: gameboard,
//                                             gameboardView: gameboardView)
//    }
//
//    private func goToNextState() {
//        if let winner = self.referee.determineWinner() {
//            self.currentState = GameEndedState(winner: winner, gameViewController: self)
//            return
//        }
//
//        if let playerInputState = currentState as? PlayerInputState {
//            self.currentState = PlayerInputState(player: playerInputState.player.next,
//                                                 gameViewController: self,
//                                                 gameboard: gameboard,
//                                                 gameboardView: gameboardView)
//        }
//    }
    
    private func goToFirstState() {
        let player = Player.first
        let typePlayer = PlayerType.human
        self.currentState = PlayerInputState(player: player,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView,
                                             isComputerGame: self.isComputerGame,
                                             typePlayer: typePlayer)
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        } else if !self.gameboard.gotAvailablePositions  {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        } else if let playerInputState = currentState as? PlayerInputState {
            
            print (self.gameboard.freePositons())
            let player = playerInputState.player.next
            var typePlayer: PlayerType = .human
            if self.isComputerGame  {
                typePlayer = playerInputState.typePlayer.next
            }
            self.currentState = PlayerInputState(player: player,
                                                 markViewPrototype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView,
                                                 isComputerGame: self.isComputerGame,
                                                 typePlayer: typePlayer)
        }
    }
    
}

