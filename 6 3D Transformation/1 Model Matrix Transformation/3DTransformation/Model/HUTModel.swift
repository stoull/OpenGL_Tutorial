//
//  HUTModel.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

class HUTModel: NSObject {
    
    var shader: HUTBaseEffect?
    
    var position: GLKVector3 = GLKVector3.init(v: (0.0, 0.0, 0.0))
    var rotationX: GLfloat = 0.0
    var rotationY: GLfloat = 0.0
    var rotationZ: GLfloat = 0.0
    var scale: GLfloat = 1.0
    
    var name: String?
    var vao: GLuint = 0
    var vertextBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    var indexCount: Int = 0
    var vetexCount: Int = 0
    
    init(name inName: String, shader inShader: HUTBaseEffect, vertices: Array<HUTVertex>, vertextCount inVertexCount: Int, inidices: Array<GLubyte>, indexCount inIndexCount: Int) {
        super.init()
        
        name = inName
        shader = inShader
        vetexCount = inVertexCount
        indexCount = inIndexCount
        
        let sizeOfVerties: Int = MemoryLayout<HUTVertex>.size * vetexCount;
        let sizeOfIndeices: Int = MemoryLayout<GLubyte>.size * indexCount;
        
        // 配置 顶点数组对象
        glGenVertexArraysOES(1, &vao)
        glBindVertexArrayOES(vao)
        
        // 生成顶点缓存
        glGenBuffers(1, &vertextBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertextBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), sizeOfVerties, vertices, GLenum(GL_STATIC_DRAW))
        
        // 生成index缓存
        glGenBuffers(1, &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), sizeOfIndeices, inidices, GLenum(GL_STATIC_DRAW))
        
        // glVertexAttribPointer函数 告诉OpenGL该如何解析顶点数据（应用到逐个顶点属性上）
        let strideSize = MemoryLayout<HUTVertex>.size
        let positionStrideSize = MemoryLayout<GLfloat>.size * 0
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: positionStrideSize))
        
        glEnableVertexAttribArray(HUTVertextAttributes.color.rawValue)
        let colorStrideSize = MemoryLayout<GLfloat>.size * 3
        glVertexAttribPointer(HUTVertextAttributes.color.rawValue, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: colorStrideSize))
        
        // 配置 顶点数组对象
        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    func render() {
        
        shader?.modelViewMatrix = self.modelMatrix()
        
        shader?.prepareToDraw()
        
        glBindVertexArrayOES(vao)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indexCount), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)
    }
    
    func modelMatrix() -> GLKMatrix4 {
        var modelMatrixCreat = GLKMatrix4Identity
        modelMatrixCreat = GLKMatrix4Translate(modelMatrixCreat, position.x, position.y, position.z)
        modelMatrixCreat = GLKMatrix4Rotate(modelMatrixCreat, rotationX, 1, 0, 0)
        modelMatrixCreat = GLKMatrix4Rotate(modelMatrixCreat, rotationY, 0, 1, 0)
        modelMatrixCreat = GLKMatrix4Rotate(modelMatrixCreat, rotationZ, 0, 0, 1)
        modelMatrixCreat = GLKMatrix4Scale(modelMatrixCreat, scale, scale, scale)
        return modelMatrixCreat
    }
    
    func updateWithDelta(time: TimeInterval) {
        
    }
    
    private func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
}
