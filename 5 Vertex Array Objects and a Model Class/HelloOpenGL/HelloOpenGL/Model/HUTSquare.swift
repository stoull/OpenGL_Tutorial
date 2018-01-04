//
//  HUTSquare.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit

class HUTSquare: NSObject {
    
    var name: UnsafePointer<String>?
    var vao: GLuint = 0
    
    var vertextBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    var shader: HUTBaseEffect!
    
    var indexCount: UInt = 0
    var vetexCount: UInt = 0
    
    init(name inName: UnsafePointer<String>, shader inShader: HUTBaseEffect, vertices: UnsafePointer<HUTVertex>, vertextCount inVertexCount: UInt, inidices: UnsafePointer<GLubyte>, indexCount inIndexCount: UInt) {
        super.init()
        name = inName
        shader = inShader
        vetexCount = inVertexCount
        indexCount = inIndexCount
        
        // 生成顶点缓存
        glGenBuffers(1, &vertextBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertextBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(vetexCount), vertices, GLenum(GL_STATIC_DRAW))
        
        // 生成index缓存
        glGenBuffers(1, &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), vetexCount, inidices, GLenum(GL_STATIC_DRAW))
        
        let strideSize = MemoryLayout<HUTVertex>.size
        let positionStrideSize = MemoryLayout<GLfloat>.size * 0
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: positionStrideSize))
        
        glEnableVertexAttribArray(HUTVertextAttributes.color.rawValue)
        let colorStrideSize = MemoryLayout<GLfloat>.size * 3
        glVertexAttribPointer(HUTVertextAttributes.color.rawValue, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: colorStrideSize))
        
        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
        
        
    }
}
