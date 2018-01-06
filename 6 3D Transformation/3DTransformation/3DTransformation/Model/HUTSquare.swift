//
//  HUTSquare.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit

let vertices: [HUTVertex] = [HUTVertex.init(Position: (1, -1, 0), Color: (1, 0, 0, 1)),
                             HUTVertex.init(Position: (1, 1, 0), Color: (0, 1, 0, 1)),
                             HUTVertex.init(Position: (-1, 1, 0), Color: (0, 0, 1, 1)),
                             HUTVertex.init(Position: (-1, -1, 0), Color: (0, 0, 0, 0))]

let indices: [GLubyte] = [0, 1, 2,
                          2, 3, 0]

class HUTSquare: HUTModel {
    init(shader: HUTBaseEffect) {
        
        let countOfVerties: Int = 4;
        let countOfIndeices: Int = 6;
        
        super.init(name: "square", shader: shader, vertices: vertices, vertextCount: countOfVerties, inidices: indices, indexCount: countOfIndeices)
        
    }
    
}
