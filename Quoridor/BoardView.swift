//
//  BoardView.swift
//  Quoridor
//
//  Created by Артур on 07.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    let ratio: CGFloat = 0.9
    var originX: CGFloat = 15
    var originY: CGFloat = 15
    var cellSide: CGFloat = 15
    let space: CGFloat = 20
    var fromRow = -10
    var fromCol = -10
    var touchNumber = 0
    
    var shadowPieces = Set<Pawn>()

    
    var quoridorDelegate: QuoridorDelegate? = nil
    

    
    override func draw(_ rect: CGRect) {
        cellSide = (bounds.width - (9 * space)) * ratio / 9
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        
        drawBoard()
        drawPieces()
        drawWalls()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchNumber < 1{
            let first = touches.first!
            let fingerLocation = first.location(in: self)
            fromCol = Int((fingerLocation.x - originX)/(cellSide + space))
            fromRow = Int((fingerLocation.y - originY)/(cellSide + space))
        
            touchNumber += 1}
        else{
            let first = touches.first!
            let fingerLocation = first.location(in: self)
            let toCol: Int = Int((fingerLocation.x - originX)/(cellSide + space))
            let toRow: Int = Int((fingerLocation.y - originY)/(cellSide + space))
            
            if (toRow < 9 && toCol < 9 ){
                quoridorDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
            }
            else{
                
                if(fingerLocation.x > originX + 4 * (space + cellSide) && fingerLocation.x < originX + 4 * (space + cellSide) + space + 2 * cellSide) && (fingerLocation.y > originY + 10 * (space + cellSide) && fingerLocation.y < originY + 10 * (space + cellSide) + space){
                    print("Horizontal picked")
                    }
                
                else if(fingerLocation.x > originX + 3 * (space + cellSide) + (cellSide - space)/2 && fingerLocation.x < originX + 3 * (space + cellSide) + (cellSide - space)/2 + space) && (fingerLocation.y > originY + 10 * (space + cellSide) - cellSide && fingerLocation.y < originY + 10 * (space + cellSide) - cellSide + 2 * cellSide + space){
                    print("Vertical picked")
                    }
            }
            
            touchNumber = 0
        }
           
       }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("smth was dagged")
    }
    
    

    
    
    func drawBoard(){
        for column in 0..<9{
            for row in 0..<9{
                drawSquare(col: column, row: row, color: UIColor.white)
            }
        }
    }
    
    func drawSquare(col: Int, row: Int, color: UIColor){
        let path = UIBezierPath(rect: CGRect(x: originX + CGFloat(col) * (cellSide + space), y: originY + CGFloat(row) * (cellSide + space), width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
    }
    
    func drawPieces(){
        for piece in shadowPieces{
            let pawnImage = UIImage(named: piece.imageName)
            pawnImage?.draw(in: CGRect(x: originX + (space + cellSide) * CGFloat(piece.col) , y: originY + (space + cellSide) * CGFloat(piece.row), width: cellSide, height: cellSide))}
    }
    
    func drawWalls(){
    let horizontalWallImage = UIBezierPath(rect: CGRect(x: originX + 4 * (space + cellSide), y: originY + 10 * (space + cellSide), width: 2 * cellSide + space, height: space) )
    UIColor.orange.setFill()
    horizontalWallImage.fill()
    
    let verticalWallImage = UIBezierPath(rect: CGRect(x: originX + 3 * (space + cellSide) + (cellSide - space)/2, y: originY + 10 * (space + cellSide) - cellSide, width: space , height: 2 * cellSide + space))
    UIColor.orange.setFill()
    verticalWallImage.fill()
        
    }

}
