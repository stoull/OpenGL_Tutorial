//
//  ViewController.swift
//  RedAlert
//
//  Created by Stoull Hut on 16/12/2017.
//  Copyright © 2017 CCApril. All rights reserved.
//

import UIKit
import GLKit

class HUTViewController: GLKViewController {
    
    public var rMult: Float = 0.0
    public var gMult: Float = 0.0
    public var bMult: Float = 0.0
    public var secsPerFlash: Double = 2.0;

    private var curRed: Float = 0.78       // 0 ~ 255 200.0
    private var curGreen: Float = 104.0     // 0 ~ 255
    private var curBlud: Float = 114.0      // 0 ~ 255
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let view : GLKView = self.view as! GLKView
        
        if let openGLContext = EAGLContext.init(api: .openGLES2) {
            view.context = openGLContext
        }else {
            print("Init EAGLContext error")
        }
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(curRed, curGreen, curBlud, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        self.update()
    }

    func update() {
        let changeColorValue: Float = (Float((sinf(Float(self.timeSinceLastResume * 2 * M_PI_2 / secsPerFlash)) * 0.5) + 0.5))
        curRed = rMult * changeColorValue
        curGreen = gMult * changeColorValue
        curBlud = bMult * changeColorValue
    }
}

