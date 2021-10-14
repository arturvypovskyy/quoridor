//
//  Wall.swift
//  Quoridor
//
//  Created by Артур on 12.10.2021.
//  Copyright © 2021 Artur Vypovskyy. All rights reserved.
//

import Foundation
struct Wall: Hashable{
    var orientation: String
    var wallCol: Int
    var wallRow: Int
}
