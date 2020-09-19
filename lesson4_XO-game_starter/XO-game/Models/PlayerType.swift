//
//  PlayerType.swift
//  XO-game
//
//  Created by Оксана Зверева on 19.09.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation
public enum PlayerType: CaseIterable {
    case human
    case computer
    
    var next: PlayerType {
        switch self {
        case .human: return .computer
        case .computer: return .human
        }
    }
    
//    var markViewPrototype: MarkView {
//        switch self {
//        case .first: return XView()
//        case .second: return OView()
//        }
//    }
    
}
