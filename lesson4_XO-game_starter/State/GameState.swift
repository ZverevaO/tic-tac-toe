//
//  GameState.swift
//  XO-game
//
//  Created by Оксана Зверева on 12.08.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    var isComputerGame: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition, freePosition: GameboardPosition)
}
