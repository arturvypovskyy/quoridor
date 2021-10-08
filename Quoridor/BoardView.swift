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
    
    var shadowPiece = Set<Pawn>()
    

    
    override func draw(_ rect: CGRect) {
        cellSide = (bounds.width - (9 * space)) * ratio / 9
        originX = bounds.width * (1-ratio)/2
        originY = bounds.height * (1-ratio)/2
        
        drawBoard()
        drawPieces()
        
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
        for piece in shadowPiece{
            let pawnImage = UIImage(named: piece.imageName)
            pawnImage?.draw(in: CGRect(x: originX + (space + cellSide) * CGFloat(piece.col) , y: originY + (space + cellSide) * CGFloat(piece.row), width: cellSide, height: cellSide))}
    }

}
