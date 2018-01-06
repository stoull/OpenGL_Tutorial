//
//  HUTModel.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit

class HUTModel: NSObject {
    var name: String?
    var vao: GLuint = 0
    
    var vertextBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    var shader: HUTBaseEffect?
    
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
        shader?.prepareToDraw()

        // 使用 顶点数组对象(Vertex Array Object, VAO) 配置
        /*
            此外如不使用VAO则每次需要单独的
            1. 配置顶点缓存
            2. 配置index缓存
            3. 使用glVertexAttribPointer函数 告诉OpenGL该如何解析顶点数据
         */
        glBindVertexArrayOES(vao)
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indexCount), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)
    }
    
    private func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
}
