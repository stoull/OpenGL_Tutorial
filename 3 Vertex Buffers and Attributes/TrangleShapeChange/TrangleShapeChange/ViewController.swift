//
//  ViewController.swift
//  TrangleShapeChange
//
//  Created by Stoull Hut on 01/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var vertexBuffer: GLuint = GLuint(0.0)
    var shader: HUTBaseEffect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
        
        EAGLContext.setCurrent(view.context)
        setupShader()
        setUpVertexBuffer()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        shader.prepareToDraw()
        
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<HUTVertex>.size), nil)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        
        glDisableVertexAttribArray(HUTVertextAttributes.position.rawValue)
    }
    
    private func setUpVertexBuffer() {
        let vertices: [HUTVertex] = [HUTVertex.init(Position: (-1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (0.0, 0.0, 0.0))]
        
        glGenBuffers(1, &self.vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
        let sizeOfVerties: Int = MemoryLayout<HUTVertex>.size * 3
        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(sizeOfVerties), vertices, GLenum(GL_STATIC_DRAW))
    }
    
    private func setupShader() {
        self.shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex", fragmentShader: "HUTSimpleFragment")
    }
}

