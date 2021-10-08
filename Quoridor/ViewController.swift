//
//  ViewController.swift
//  Quoridor
//
//  Created by Артур on 06.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var quoridorEngine = QuoridorEngine()
    
    @IBOutlet weak var boardView: BoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoridorEngine.initializerGame()
        boardView.shadowPiece = quoridorEngine.pawns
        
    }
    
    
    
}

