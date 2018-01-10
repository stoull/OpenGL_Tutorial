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
        HUTVertex.init(Position: (1, -1, 1), Color: (1, 0, 0, 1), TexCoord:(1, 0)), // 0
        HUTVertex.init(Position: (1, 1, 1), Color: (1, 0, 0, 1), TexCoord:(1, 1)),  // 1
        HUTVertex.init(Position: (-1, 1, 1), Color: (0, 1, 0, 1), TexCoord:(0, 1)), // 2
        HUTVertex.init(Position: (-1, -1, 1), Color: (0, 1, 0, 1), TexCoord:(0, 0)),// 3
        
        // 后部分点
        HUTVertex.init(Position: (-1, -1, -1), Color: (1, 0, 0, 1), TexCoord:(1, 0)),
        HUTVertex.init(Position: (-1, 1, -1), Color: (1, 0, 0, 1), TexCoord:(1, 1)),
        HUTVertex.init(Position: (1, 1, -1), Color: (0, 1, 0, 1), TexCoord:(0, 1)),
        HUTVertex.init(Position: (1, -1, -1), Color: (0, 1, 0, 1), TexCoord:(0, 0)),
        
        // 左部分点
        HUTVertex.init(Position: (-1, -1, 1), Color: (1, 0, 0, 1), TexCoord:(1, 0)),
        HUTVertex.init(Position: (-1, 1, 1), Color: (0, 1, 0, 1), TexCoord:(1, 1)),
        HUTVertex.init(Position: (-1, 1, -1), Color: (0, 0, 1, 1), TexCoord:(0, 1)),
        HUTVertex.init(Position: (-1, -1, -1), Color: (0, 0, 0, 1), TexCoord:(0, 0)),
        
        // 右部分点
        HUTVertex.init(Position: (1, -1, -1), Color: (1, 0, 0, 1), TexCoord:(1, 0)),
        HUTVertex.init(Position: (1, 1, -1), Color: (0, 1, 0, 1), TexCoord:(1, 1)),
        HUTVertex.init(Position: (1, 1, 1), Color: (0, 0, 1, 1), TexCoord:(0, 1)),
        HUTVertex.init(Position: (1, -1, 1), Color: (0, 0, 0, 1), TexCoord:(0, 0)),
        
        // 顶部分点
        HUTVertex.init(Position: (1, 1, 1), Color: (1, 0, 0, 1), TexCoord:(1, 0)),
        HUTVertex.init(Position: (1, 1, -1), Color: (0, 1, 0, 1), TexCoord:(1, 1)),
        HUTVertex.init(Position: (-1, 1, -1), Color: (0, 0, 1, 1), TexCoord:(0, 1)),
        HUTVertex.init(Position: (-1, 1, 1), Color: (0, 0, 0, 1), TexCoord:(0, 0)),
        
        // 底部分点
        HUTVertex.init(Position: (1, -1, -1), Color: (1, 0, 0, 1), TexCoord:(1, 0)),
        HUTVertex.init(Position: (1, -1, 1), Color: (0, 1, 0, 1), TexCoord:(1, 1)),
        HUTVertex.init(Position: (-1, -1, 1), Color: (0, 0, 1, 1), TexCoord:(0, 1)),
        HUTVertex.init(Position: (-1, -1, -1), Color: (0, 0, 0, 1), TexCoord:(0, 0)),
        
        
    ]
    
    let indices: [GLubyte] = [
        // 前部的点
        0, 1, 2,
        2, 3, 0,
        // 后部
        4, 5, 6,
        6, 7, 4,
        // 左方
        8, 9, 10,
        10, 11, 8,
        // 右方
        12, 13, 14,
        14, 15, 12,
        // 上方
        16, 17, 18,
        18, 19, 16,
        // 下方
        20, 21, 22,
        22, 23, 20]
    
    init(shader: HUTBaseEffect) {
        
        let countOfVerties: Int = 24;
        let countOfIndeices: Int = 36;
        
        super.init(name: "cube", shader: shader, vertices: vertices, vertextCount: countOfVerties, inidices: indices, indexCount: countOfIndeices)
        
        loadTexture(fileName: "lanlianhua")
        
    }

    override func updateWithDelta(time: TimeInterval) {
        rotationZ += GLfloat(Double.pi * time)
        rotationY += GLfloat(Double.pi * time)
    }
}
