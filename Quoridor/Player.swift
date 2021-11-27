//
//  Player.swift
//  Quoridor
//
//  Created by Артур on 27.11.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import Foundation

struct Player {
    var wallsLeft: Int
    var imageName: String
    init(imageName: String, wallsLeft: Int){
        self.imageName = imageName
        self.wallsLeft = wallsLeft 
    }
}
