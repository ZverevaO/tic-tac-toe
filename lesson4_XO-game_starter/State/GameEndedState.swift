//
//  GameEndedState.swift
//  XO-game
//
//  Created by Оксана Зверева on 12.08.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    public var isComputerGame: Bool
    
    public let isCompleted = false
    
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
     init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
        self.isComputerGame = gameViewController.isComputerGame 
    }
    
    public func begin() {
        
        Log(.gameFinished(winner: self.winner))
        
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition, freePosition: GameboardPosition) { }
    
    private func winnerName(from winner: Player) -> String {

        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        //case .none: return "No winner"
        }
    }
}
