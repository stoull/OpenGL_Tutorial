//
//  HUTVertex.swift
//  Hello OpenGL
//
//  Created by Stoull Hut on 16/12/2017.
//  Copyright © 2017 hut. All rights reserved.
//
import OpenGLES

enum HUTVertexAttributes {
    case position
}

struct HUTVertext {
//    let Position: [GLfloat] = [0.0, 0.0, 0.0]
    var Position: [GLfloat] = Array(repeatElement(0.0, count: 3))
}
