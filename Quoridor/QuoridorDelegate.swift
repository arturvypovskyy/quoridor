//
//  QuoridorDelegate.swift
//  Quoridor
//
//  Created by Артур on 11.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import Foundation
protocol QuoridorDelegate{
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
}
