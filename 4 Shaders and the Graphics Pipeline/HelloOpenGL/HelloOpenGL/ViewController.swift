//
//  ViewController.swift
//  HelloOpenGL
//
//  Created by linkapp on 02/01/2018.
//  Copyright © 2018 hut. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var vertextBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    var shader: HUTBaseEffect!
    var indexCount: GLsizei = 0
    
    func setupShader() {
        shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex", fragmentShader: "HUTSimpleFragment")
    }
    
    func setupVertexBuffer() {
//        let vertices: [HUTVertex] = [HUTVertex.init(Position: (1, -1, 0), Color: (1, 0, 0, 1)),
//                                     HUTVertex.init(Position: (1, 1, 0), Color: (0, 1, 0, 1)),
//                                     HUTVertex.init(Position: (-1, 1, 0), Color: (0, 0, 1, 1)),
//                                     HUTVertex.init(Position: (-1, -1, 0), Color: (0, 0, 0, 0))]
        
//        let vertices: [HUTVertex] = [HUTVertex.init(Position: (1, -1, 0, 1, 0, 0, 1)),
//                                     HUTVertex.init(Position: (1, 1, 0, 0, 1, 0, 1)),
//                                     HUTVertex.init(Position: (-1, 1, 0, 0, 0, 1, 1)),
//                                     HUTVertex.init(Position: (-1, -1, 0, 0, 0, 0, 0))]
        
        let vertices : [HUTVertex] = [
            HUTVertex( 1.0, -1.0, 0, 1.0, 0.0, 0.0, 1.0),
            HUTVertex( 1.0,  1.0, 0, 0.0, 1.0, 0.0, 1.0),
            HUTVertex(-1.0,  1.0, 0, 0.0, 0.0, 1.0, 1.0),
            HUTVertex(-1.0, -1.0, 0, 1.0, 1.0, 0.0, 1.0)
        ]
        
        let indices: [GLubyte] = [0, 1, 2,
                                  2, 3, 0]
        
        indexCount = GLsizei(MemoryLayout.size(ofValue: indices) / MemoryLayout.size(ofValue: indices[0]))
        
        glGenBuffers(1, &vertextBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertextBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), MemoryLayout.size(ofValue: vertices), vertices, GLenum(GL_STATIC_DRAW))
        
        glGenBuffers(1, &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), MemoryLayout.size(ofValue: indices), indices, GLenum(GL_STATIC_DRAW))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
        
        EAGLContext.setCurrent(view.context)
        
        setupShader()
        setupVertexBuffer()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        shader?.prepareToDraw()
        
        let strideSize = MemoryLayout<HUTVertex>.size
        let positionStrideSize = MemoryLayout<GLfloat>.size * 0
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: positionStrideSize))
        
        glEnableVertexAttribArray(HUTVertextAttributes.color.rawValue)
        let colorStrideSize = MemoryLayout<GLfloat>.size * 3
        glVertexAttribPointer(HUTVertextAttributes.color.rawValue, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(strideSize), BUFFER_OFFSET(n: colorStrideSize))
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertextBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        
        glDrawElements(GLenum(GL_TRIANGLES), indexCount, GLenum(GL_UNSIGNED_BYTE), nil)
        
//        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3);
        
        glDisableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        glDisableVertexAttribArray(HUTVertextAttributes.color.rawValue)
    }
    
    func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
    
//    func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer? {
//
////        return UnsafeRawPointer(bitPattern: n)
//
//        var t = 0
//        let ptr = UnsafeRawPointer.init(&t)
//        return ptr
//
//        //        let pointer: UnsafeRawPointer
////        let ptr = UnsafeRawPointer(bitPattern: n)
//        //        let adPtr = ptr?.advanced(by: n)
//        //        let adPtr = pointer + n
//
////        var f: GLfloat = 0
////        withUnsafePointer(to: &f) { (pointer) -> Void in
////
////        }
//    }
    
//    func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer {
//        let ptr: UnsafeRawPointer? = nil
//        return ptr?.advanced(by: n)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

