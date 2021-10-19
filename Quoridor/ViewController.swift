//
//  ViewController.swift
//  Quoridor
//
//  Created by Артур on 06.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuoridorDelegate {
    
    var quoridorEngine = QuoridorEngine()
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.quoridorDelegate = self
        
        quoridorEngine.initializerGame()
        boardView.shadowPieces = quoridorEngine.pawns
        boardView.shadowWalls = quoridorEngine.walls
        
        
    }
    
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        
        quoridorEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shadowPieces = quoridorEngine.pawns
        boardView.setNeedsDisplay()
    }
    
    func setWall(type: String, toCol: Int, toRow: Int){
        quoridorEngine.setWall(type: type, toCol: toCol, toRow: toRow)
        boardView.shadowWalls = quoridorEngine.walls
        boardView.setNeedsDisplay()
    }

    
    
    
}

