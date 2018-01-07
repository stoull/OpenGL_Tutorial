//
//  ViewController.swift
//  3DTransformation
//
//  Created by Stoull Hut on 06/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var shader: HUTBaseEffect?
    var square: HUTSquare?
    var cube: HUTCube?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
        
        EAGLContext.setCurrent(view.context)
        
        setupSquare()
    }
    
    func setupSquare() {
        shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex", fragmentShader: "HUTSimpleFragment")
        if let realShader = shader {
            square = HUTSquare.init(shader: realShader)
            cube = HUTCube.init(shader: realShader)
            realShader.projectionViewMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), Float(self.view.bounds.size.width / self.view.bounds.size.height), 1, 150)
            
        }else {
            print("Setup Square ERROR!")
        }
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        // Depth testing
        glEnable(GLenum(GL_DEPTH_TEST))
        // Backface culling
        glEnable(GLenum(GL_CULL_FACE))
        
        let viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5)
        
        
//        square?.render()
        
//        square?.renderWithParentModelViewMatrix(parentModelViewMatrix: viewMatrix)
        cube?.renderWithParentModelViewMatrix(parentModelViewMatrix: viewMatrix)
    }
    
    //
    func update() {
//        square?.updateWithDelta(time: timeSinceLastUpdate)
        cube?.updateWithDelta(time: timeSinceLastUpdate);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: GLKViewControllerDelegate  {
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        self.update()
    }
}

