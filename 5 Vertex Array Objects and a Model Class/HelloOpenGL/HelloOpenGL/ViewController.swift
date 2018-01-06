//
//  ViewController.swift
//  HelloOpenGL
//
//  Created by Stoull Hut on 04/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
    
    var shader: HUTBaseEffect!
    var square: HUTSquare?
    
    func setupScene() {
        shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex", fragmentShader: "HUTSimpleFragment")
        square = HUTSquare.init(shader: shader)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
        
        EAGLContext.setCurrent(view.context)
        
        setupScene()
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        square?.render()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

