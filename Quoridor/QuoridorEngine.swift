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
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int){
        guard var pieceMoved = pieceAt(col: fromCol, row: fromRow) else { return  }
        pawns.remove(pieceMoved)
        pieceMoved.col = toCol
        pieceMoved.row = toRow
        pawns.insert(pieceMoved)
        
    }
    
    func pieceAt(col: Int, row: Int) -> Pawn?{
        for pawn in pawns{
            if pawn.col == col && pawn.row == row {
                return pawn
            }
        }
        return nil
    }
        
    mutating func initializerGame(){
        pawns.removeAll()
        pawns.insert(Pawn(col: 4, row: 0, imageName: "Pawn-black"))
        pawns.insert(Pawn(col: 4, row: 8, imageName: "Pawn-white"))
    }
    
    
}
