//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    private lazy var positions: [[Player?]] = initialPositions()
    
    // MARK: - public
    
    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
    
    //проверка на наличие пустых клеток 
    public var gotAvailablePositions: Bool {
        positions.flatMap {$0}.contains(nil)
    }
    
    public func freePositons () -> GameboardPosition
    {
        var freePosition = GameboardPosition(column: 0, row: 0)
        for column in 0 ..< GameboardSize.columns    {
            for row in 0 ..< GameboardSize.rows {
                let position = GameboardPosition(column: column, row: row)
                if positions[position.column][position.row] == nil {
                    print (positions[position.column][position.row])
                    freePosition = position
                    break
                }
               
            }
        }
        print (freePosition)
        return freePosition
    }
    // MARK: - Private
    
    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
