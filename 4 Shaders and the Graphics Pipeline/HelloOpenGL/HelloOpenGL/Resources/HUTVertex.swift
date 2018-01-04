//
//  HUTVertex.swift
//  TrangleShapeChange
//
//  Created by Stoull Hut on 01/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

enum HUTVertextAttributes: UInt32 {
    case position = 0   // layout (location = 0)
    case color
}

struct HUTVertex {
    var Position: (GLfloat, GLfloat, GLfloat)
    var Color: (GLfloat, GLfloat, GLfloat, GLfloat)
    //    var Position: [GLfloat] = [0.0, 0.0, 0.0]
}

