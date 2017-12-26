//
//  ViewController.swift
//  Hello OpenGL
//
//  Created by linkapp on 14/12/2017.
//  Copyright © 2017 hut. All rights reserved.
//

import UIKit
import GLKit

class HUTViewController: GLKViewController {
    
    var vertexBuffer: GLuint = GLuint(0.0)
    var shader: HUTBaseEffect!
//    var shader: UnsafePointer<CChar>!

    override func viewDidLoad() {
        super.viewDidLoad()
        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
        
        EAGLContext.setCurrent(view.context)
//        glClearColor(0, 0, 0, 1)
        
        self.setupShader()
        self.setupVertexBuffer()
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        self.shader.prepareToDraw()
        
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<HUTVertex>.size), nil)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer);
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3);
        
        glDisableVertexAttribArray(HUTVertextAttributes.position.rawValue);
    }
    
    private func setupVertexBuffer() {
        let vertices: [HUTVertex] = [HUTVertex.init(Position: (-1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (0.0, 0.0, 0.0))]
        glGenBuffers(1, &self.vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
        let sizeOfVerties: Int = MemoryLayout<HUTVertex>.size * 3;
        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(sizeOfVerties), vertices, GLenum(GL_STATIC_DRAW))
    }
    
    private func setupShader() {
        self.shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex.glsl", fragmentShader: "HUTSimpleFragment.glsl")
    }
    
}

