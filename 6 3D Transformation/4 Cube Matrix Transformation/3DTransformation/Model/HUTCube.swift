//
//  HUTCube.swift
//  3DTransformation
//
//  Created by Stoull Hut on 07/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit

class HUTCube: HUTModel {
    let vertices: [HUTVertex] = [
        // 前部分点
         HUTVertex.init(Position: (1, -1, -1), Color: (1, 0, 0, 1)),
         HUTVertex.init(Position: (1, 1, 1), Color: (1, 0, 0, 1)),
         HUTVertex.init(Position: (-1, 1, 1), Color: (0, 1, 0, 1)),
         HUTVertex.init(Position: (-1, -1, -1), Color: (0, 1, 0, 1)),
        
        // 后部分点
        HUTVertex.init(Position: (-1, -1, -1), Color: (1, 0, 0, 1)),
        HUTVertex.init(Position: (-1, 1, -1), Color: (1, 0, 0, 1)),
        HUTVertex.init(Position: (1, 1, -1), Color: (0, 1, 0, 1)),
        HUTVertex.init(Position: (1, -1, -1), Color: (0, 1, 0, 1))
    ]
    
    let indices: [GLubyte] = [
        // 前部的点
        0, 1, 2,
        2, 3, 0,
        // 后部
        4, 5, 6,
        6, 7, 4,
        // 左方
        3, 2, 5,
        5, 4, 3,
        // 右方
        7, 6, 1,
        1, 0, 7,
        // 上方
        1, 6, 5,
        5, 2, 1,
        // 下方
        3, 4, 7,
        7, 0, 3]
    
    init(shader: HUTBaseEffect) {
        
        let countOfVerties: Int = 8;
        let countOfIndeices: Int = 36;
        
        super.init(name: "cube", shader: shader, vertices: vertices, vertextCount: countOfVerties, inidices: indices, indexCount: countOfIndeices)
        
    }

    override func updateWithDelta(time: TimeInterval) {
        rotationZ += GLfloat(Double.pi * time)
        rotationY += GLfloat(Double.pi * time)
    }
}
