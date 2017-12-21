//
//  HUTBaseEffect.swift
//  Hello OpenGL
//
//  Created by linkapp on 20/12/2017.
//  Copyright © 2017 hut. All rights reserved.
//

import UIKit
import OpenGLES

class HUTBaseEffect: NSObject {

    public init(vertextShader: String, fragmentShader: String) {
        
    }
    
    public func prepareToDraw() {
        
    }
    
    private func compileShader(shaderName: String, shaderType: GLenum) {
        // "/Applications/MyApp.app"
        if let shaderPath = Bundle.path(forResource: shaderName, ofType: "glsl", inDirectory: Bundle.main.resourcePath!){
            var shaderString: NSString
            do{
                shaderString = try String.init(contentsOfFile: shaderPath, encoding: .utf8) as NSString
            }catch {
                exit(1)
            }
            
            let shaderHandle: GLuint = glCreateShader(shaderType)
            var shaderStringUT8: UnsafePointer<CChar>? = shaderString.utf8String
            var shaderStringLength: Int32 = Int32(shaderString.length)
            glShaderSource(shaderHandle, 1, &shaderStringUT8, &shaderStringLength)
            
            glCompileShader(shaderHandle)
            
            var compileSuccess: GLint = GL_FALSE
            glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess)
            if compileSuccess == GL_FALSE {
                var messages: [CChar] = Array(repeating: CChar.init(32), count: 256)
                let sizeOfMsg: Int32 = Int32(MemoryLayout<CChar>.size * messages.count)
                glGetShaderInfoLog(shaderHandle, sizeOfMsg, 0, &messages)
            }
            
        }
        
    }
}
