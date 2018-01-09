//
//  HUTSquare.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

let vertices: [HUTVertex] = [HUTVertex.init(Position: (1, -1, 0), Color: (1, 0, 0, 1), TexCoord: (0, 0)),
                             HUTVertex.init(Position: (1, 1, 0), Color: (0, 1, 0, 1), TexCoord: (0, 0)),
                             HUTVertex.init(Position: (-1, 1, 0), Color: (0, 0, 1, 1), TexCoord: (0, 0)),
                             HUTVertex.init(Position: (-1, -1, 0), Color: (0, 0, 0, 0), TexCoord: (0, 0))]

let indices: [GLubyte] = [0, 1, 2,
                          2, 3, 0]

class HUTSquare: HUTModel {
    init(shader: HUTBaseEffect) {
        
        let countOfVerties: Int = 4;
        let countOfIndeices: Int = 6;
        
        super.init(name: "square", shader: shader, vertices: vertices, vertextCount: countOfVerties, inidices: indices, indexCount: countOfIndeices)
        
    }
    
    
    override func updateWithDelta(time: TimeInterval) {
        let secsPerMove = 2.0
        position = GLKVector3.init(v: (sinf(Float(CACurrentMediaTime() * 2*Double.pi / secsPerMove)), position.y, position.z))
    }
    
}
