//
//  HUTVertex.swift
//  VertexBuffersAndAttributes
//
//  Created by linkapp on 21/12/2017.
//  Copyright © 2017 hut. All rights reserved.
//

import UIKit
import GLKit

enum HUTVertextAttributes: UInt32 {
    case position = 0   // layout (location = 0)
}

struct HUTVertex {
    var Position: (GLfloat, GLfloat, GLfloat)
//    var Position: [GLfloat] = [0.0, 0.0, 0.0]
}
