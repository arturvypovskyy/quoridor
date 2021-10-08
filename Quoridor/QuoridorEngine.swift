//
//  QuoridorEngine.swift
//  Quoridor
//
//  Created by Артур on 07.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import Foundation

struct QuoridorEngine{
    
    var pawns = Set<Pawn>()
    
    mutating func initializerGame(){
        pawns.removeAll()
        pawns.insert(Pawn(col: 4, row: 0, imageName: "Pawn-black"))
        pawns.insert(Pawn(col: 4, row: 8, imageName: "Pawn-white"))
    }
    
}
