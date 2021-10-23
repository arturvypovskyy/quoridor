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
    var walls = Set<Wall>()
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int){
        guard var pieceMoved = pieceAt(col: fromCol, row: fromRow) else { return  }
        var possibleMoves = Set<Pawn>()
        possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow, imageName: pieceMoved.imageName))
        possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
        possibleMoves.insert(Pawn(col: fromCol, row: fromRow + 1, imageName: pieceMoved.imageName))
        possibleMoves.insert(Pawn(col: fromCol, row: fromRow - 1, imageName: pieceMoved.imageName))
        pieceMoved.col = toCol
        pieceMoved.row = toRow
        
        
        if walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 1)) || walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow - 1)){
            possibleMoves.remove(Pawn(col: fromCol, row: fromRow - 1, imageName: pieceMoved.imageName))
        }
        else if pawns.contains(Pawn(col: fromCol, row: fromRow - 1, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol, row: fromRow - 1, imageName: "Pawn-white")) {
            possibleMoves.remove(Pawn(col: fromCol, row: fromRow - 1, imageName: pieceMoved.imageName))
            if !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 2)){
                possibleMoves.insert(Pawn(col: fromCol, row: fromRow - 2, imageName: pieceMoved.imageName))
            }
        }
        
        if walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow)) || walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow)){
            possibleMoves.remove(Pawn(col: fromCol, row: fromRow + 1, imageName: pieceMoved.imageName))
        }
        else if pawns.contains(Pawn(col: fromCol, row: fromRow + 1, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol, row: fromRow + 1, imageName: "Pawn-white")) {
            possibleMoves.remove(Pawn(col: fromCol, row: fromRow + 1, imageName: pieceMoved.imageName))
            if !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow + 1)){
                possibleMoves.insert(Pawn(col: fromCol, row: fromRow + 2, imageName: pieceMoved.imageName))
            }
        }
        
        if walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 1)){
            possibleMoves.remove(Pawn(col: fromCol + 1, row: fromRow, imageName: pieceMoved.imageName))
        }
        else if pawns.contains(Pawn(col: fromCol + 1, row: fromRow, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol + 1, row: fromRow, imageName: "Pawn-white")) {
            possibleMoves.remove(Pawn(col: fromCol + 1, row: fromRow, imageName: pieceMoved.imageName))
            if !walls.contains(Wall(type: "vertical", col: fromCol + 1, row: fromRow)){
                print("hey")
                possibleMoves.insert(Pawn(col: fromCol + 2, row: fromRow, imageName: pieceMoved.imageName))
            }
        }
        
        if walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 1)){
            possibleMoves.remove(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
        }
        else if pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-white")) {
            possibleMoves.remove(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
            if !walls.contains(Wall(type: "vertical", col: fromCol - 2, row: fromRow)){
                print("hey")
                possibleMoves.insert(Pawn(col: fromCol - 2, row: fromRow, imageName: pieceMoved.imageName))
            }
        }
        
        
        

        if (possibleMoves.contains(pieceMoved)){
            
            pieceMoved.col = fromCol
            pieceMoved.row = fromRow
            pawns.remove(pieceMoved)
            pieceMoved.col = toCol
            pieceMoved.row = toRow
            pawns.insert(pieceMoved)
        }
        else{
            print("Move is forbidden")
        }

    }
    
    func pieceAt(col: Int, row: Int) -> Pawn?{
        for pawn in pawns{
            if pawn.col == col && pawn.row == row {
                return pawn
            }
        }
        return nil
    }
    
    mutating func setWall(type:String, toCol: Int, toRow: Int){
        if (toRow >= 0 && toRow < 8 && toCol < 8 && toCol >= 0){
            if !(walls.isEmpty){
                var candidates = Set<Wall>()
                
                if type == "vertical"{
                    candidates.insert(Wall(type: "vertical", col: toCol, row: toRow))
                    candidates.insert(Wall(type: "vertical", col: toCol, row: toRow - 1))
                    candidates.insert(Wall(type: "vertical", col: toCol, row: toRow + 1))
                    candidates.insert(Wall(type: "horizontal", col: toCol, row: toRow))
                    
                }
                else{
                    candidates.insert(Wall(type: "horizontal", col: toCol, row: toRow))
                    candidates.insert(Wall(type: "horizontal", col: toCol - 1, row: toRow))
                    candidates.insert(Wall(type: "horizontal", col: toCol + 1, row: toRow))
                    candidates.insert(Wall(type: "vertical", col: toCol, row: toRow))
                }
                
                
                if (!(walls.isDisjoint(with: candidates))){
                    print("Same found")
                }
                else{
                    let wallSet = Wall(type: type, col: toCol, row: toRow)
                    walls.insert(wallSet)
                }
            }
            else{
                let wallSet = Wall(type: type, col: toCol, row: toRow)
                walls.insert(wallSet)
            }
        }
    }
        
    mutating func initializerGame(){
        pawns.removeAll()
        walls.removeAll()
        
        pawns.insert(Pawn(col: 4, row: 0, imageName: "Pawn-black"))
        pawns.insert(Pawn(col: 4, row: 8, imageName: "Pawn-white"))
        
        

    }
    
    
}
