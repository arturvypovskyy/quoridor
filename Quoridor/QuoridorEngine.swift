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
    var possibleMovesComp = Set<Pawn>()
    var firstPlayer: Player = Player(imageName: "Pawn-white", wallsLeft: 10)
    var secondPlayer: Player = Player(imageName: "Pawn-black", wallsLeft: 10)
    var currentPlayer: Player = Player(imageName: "Pawn-white", wallsLeft: 10)
    
    
    mutating func changePlayer(){
        if currentPlayer.imageName == "Pawn-white"{
            firstPlayer = currentPlayer
            currentPlayer = secondPlayer
        }
        else{
            secondPlayer = currentPlayer
            currentPlayer = firstPlayer
        }
        
    }
    
    
    mutating func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int){
        if(!isGameEnded()){
            guard var pieceMoved = pieceAt(col: fromCol, row: fromRow) else { return  }
            
            var possibleMoves = Set<Pawn>()
            
            possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow, imageName: pieceMoved.imageName))
            possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
            possibleMoves.insert(Pawn(col: fromCol, row: fromRow + 1, imageName: pieceMoved.imageName))
            possibleMoves.insert(Pawn(col: fromCol, row: fromRow - 1, imageName: pieceMoved.imageName))
            pieceMoved.col = toCol
            pieceMoved.row = toRow
            
            
            //changing player, removing forbidden moves
            for possibleMove in possibleMoves {
                if possibleMove.imageName != currentPlayer.imageName{
                    possibleMoves.remove(possibleMove)
                }
            }
            
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
                    
                    possibleMoves.insert(Pawn(col: fromCol + 2, row: fromRow, imageName: pieceMoved.imageName))
                }
            }
            
            if walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 1)){
                possibleMoves.remove(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
            }
            else if pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-white")) {
                possibleMoves.remove(Pawn(col: fromCol - 1, row: fromRow, imageName: pieceMoved.imageName))
                if !walls.contains(Wall(type: "vertical", col: fromCol - 2, row: fromRow)){
                    possibleMoves.insert(Pawn(col: fromCol - 2, row: fromRow, imageName: pieceMoved.imageName))
                }
            }
            
            // diagonal moves
            
            //forward
            if (pawns.contains(Pawn(col: fromCol, row: fromRow - 1, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol, row: fromRow - 1, imageName: "Pawn-white"))) && (walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 2 )) || walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow - 2 )) ){
                if (walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 1 )) || walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 2 ))) && !walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 2 )) {
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
                else if (walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 1 )) || walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 2 ))) && (!walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 2 ))) {
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
                else if (!walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow - 2 ))) && (!walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow - 2 ))){
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
                
            }
            // backward
            if (pawns.contains(Pawn(col: fromCol, row: fromRow + 1, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol, row: fromRow + 1, imageName: "Pawn-white"))) && (walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow + 1 )) || walls.contains(Wall(type: "horizontal", col: fromCol - 1 , row: fromRow + 1 )) ){
                if (walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow + 1 )) || walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow))) && (!walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow)) && !walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow + 1 )))  {
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                }
                else if (walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow + 1 ))) && (!walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow + 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow)))  {
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                }
                else if (!walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow)) || !walls.contains(Wall(type: "vertical", col: fromCol - 1, row: fromRow + 1 ))) && (!walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow + 1 )) && !walls.contains(Wall(type: "vertical", col: fromCol, row: fromRow))) {
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                }
                
            }
            //to the left
            if(pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol - 1, row: fromRow, imageName: "Pawn-white"))) && (walls.contains(Wall(type: "vertical", col: fromCol - 2, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol - 2, row: fromRow - 1))){
                if (walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow - 1)) || walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow - 1))) && !walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow)) {
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                }
                else if (walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow)) || walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow))) && !walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow - 1)) && !walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow - 1)){
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                    
                }
                else if !walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol - 1, row: fromRow - 1)) && !walls.contains(Wall(type: "horizontal", col: fromCol - 2, row: fromRow - 1)){
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                    possibleMoves.insert(Pawn(col: fromCol - 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
            }
            
            // to the right
            if(pawns.contains(Pawn(col: fromCol + 1, row: fromRow, imageName: "Pawn-black")) || pawns.contains(Pawn(col: fromCol + 1, row: fromRow, imageName: "Pawn-white"))) && (walls.contains(Wall(type: "vertical", col: fromCol + 1, row: fromRow)) || walls.contains(Wall(type: "vertical", col: fromCol + 1, row: fromRow - 1))){
                
                if (walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 1)) || walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow - 1))) && !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow)){
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                }
                else if (walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow)) || walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow))) && !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 1)) && !walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow - 1)) {
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
                else if !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow)) && !walls.contains(Wall(type: "horizontal", col: fromCol, row: fromRow - 1)) && !walls.contains(Wall(type: "horizontal", col: fromCol + 1, row: fromRow - 1)) {
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow + 1, imageName: pieceMoved.imageName))
                    possibleMoves.insert(Pawn(col: fromCol + 1, row: fromRow - 1, imageName: pieceMoved.imageName))
                }
                
            }
            
            
            if (possibleMoves.contains(pieceMoved))
            {
                pieceMoved.col = fromCol
                pieceMoved.row = fromRow
                pawns.remove(pieceMoved)
                pieceMoved.col = toCol
                pieceMoved.row = toRow
                pawns.insert(pieceMoved)
                //ComputerPlayerLogic(possibleMoves: possibleMoves)
                changePlayer()
            }
            else {
                print("Move is forbidden")
            }
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
        if (currentPlayer.wallsLeft != 0 && !isGameEnded()){
            if (toRow >= 0 && toRow < 8 && toCol < 8 && toCol >= 0){
                //var candidatesSet = Set<Wall>()
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
                    //candidatesSet = candidates
                    
                    if (!(walls.isDisjoint(with: candidates))){
                        print("Same found")
                    }
                    else{
                        let wallSet = Wall(type: type, col: toCol, row: toRow)
                        //counting set walls
                        if wallSet.type != "" {
                            walls.insert(wallSet)
                            currentPlayer.wallsLeft -= 1
                            print("\(currentPlayer.imageName) walls left \(currentPlayer.wallsLeft)")
                            changePlayer()
                            //ComputerPlayerLogic(name: "Pawn-black", possibleMoves: Set<Pawn>(), candidates: candidatesSet)
                        }
                        
                    }
                }
                else{
                    let wallSet = Wall(type: type, col: toCol, row: toRow)
                    //counting set walls
                    if wallSet.type != "" {
                        walls.insert(wallSet)
                        currentPlayer.wallsLeft -= 1
                        print("\(currentPlayer.imageName) walls left \(currentPlayer.wallsLeft)")
                        changePlayer()
                        // ComputerPlayerLogic(name: "Pawn-black", possibleMoves: Set<Pawn>(), candidates: candidatesSet)
                    }
                }
            }
        }
    }
    
    mutating func initializerGame(){
        pawns.removeAll()
        walls.removeAll()
        pawns.insert(Pawn(col: 4, row: 0, imageName: "Pawn-black"))
        pawns.insert(Pawn(col: 4, row: 8, imageName: "Pawn-white"))
        firstPlayer = Player(imageName: "Pawn-white", wallsLeft: 10)
        secondPlayer = Player(imageName: "Pawn-black", wallsLeft: 10)
        currentPlayer = Player(imageName: "Pawn-white", wallsLeft: 10)
    }
    
    mutating func isGameEnded() -> Bool
    {
        for pawn in pawns
        {
            if(pawn.imageName == "Pawn-white" && pawn.row == 0 || pawn.imageName == "Pawn-black" && pawn.row == 8)
            {
                self.changePlayer()
                print(currentPlayer.imageName + " wins")
                return true
            }
        }
        return false
    }
    
    mutating func ComputerPlayerLogic(possibleMoves: Set<Pawn>)
    {
        if currentPlayer.imageName == "Pawn-black"{
            for pawn in pawns{
                if pawn.imageName == "Pawn-black"{
                    for possibleMove in possibleMoves {
                        if possibleMove.imageName == "Pawn-black"{
                            movePiece(fromCol: pawn.col, fromRow: pawn.row, toCol: possibleMove.col, toRow: possibleMove.row)
                        }
                    }
                }
            }
        }
        
    }
    
}
