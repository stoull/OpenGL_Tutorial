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

    override func viewDidLoad() {
        super.viewDidLoad()
        let view: GLKView = self.view as! GLKView
        view.context = EAGLContext.init(api: .openGLES2)!
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(200.0/225.0, 104.0/255.0, 114.0/255.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }

}

