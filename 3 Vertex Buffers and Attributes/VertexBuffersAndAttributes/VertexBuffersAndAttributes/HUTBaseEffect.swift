//
//  HUTBaseEffect.swift
//  Hello OpenGL
//
//  Created by linkapp on 20/12/2017.
//  Copyright © 2017 hut. All rights reserved.
//

import UIKit
//import OpenGLES
import GLKit

class HUTBaseEffect: NSObject {
    
    var programHandle: GLuint = 0

    public init(vertexShader: String, fragmentShader: String) {
        super.init()
        self.comileVertexShader(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }
    
    public func prepareToDraw() {
        glUseProgram(self.programHandle)
    }
    
    private func compileShader(shaderName: String, shaderType: GLenum) -> GLuint {
        // "/Applications/MyApp.app"
        if let shaderPath = Bundle.path(forResource: shaderName, ofType: nil, inDirectory: Bundle.main.resourcePath!){
            var shaderString: NSString
            do{
                shaderString = try String.init(contentsOfFile: shaderPath, encoding: .utf8) as NSString
            }catch {
                print("Failed to load vertex shader")
                exit(1)
            }
            
            var shaderHandle: GLuint = 0
            
            shaderHandle = glCreateShader(shaderType)
            if shaderHandle == 0 {
                print("Couldn't create shader")
            }
            
            var shaderStringUT8: UnsafePointer<CChar>? = shaderString.utf8String
            var shaderStringLength: GLint = GLint(Int32(shaderString.length))
            glShaderSource(shaderHandle, 1, &shaderStringUT8, &shaderStringLength)
            
            glCompileShader(shaderHandle)
            
            var compileSuccess: GLint = GL_FALSE
            glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess)
            if compileSuccess == GL_FALSE {
                var messages: [CChar] = Array(repeating: CChar.init(), count: 512)
                let sizeOfMsg: Int32 = Int32(MemoryLayout<CChar>.size * messages.count)
                glGetShaderInfoLog(shaderHandle, sizeOfMsg, nil, &messages[0])
                let messageString = String.init(cString: messages);
                print("compileShader: \(messageString)")
                exit(1)
            }
            return shaderHandle
        }else {
            print("Cannot get glsl file")
            exit(1)
        }
    }
    
    private func comileVertexShader(vertexShader: String, fragmentShader: String) {
        self.programHandle = glCreateProgram()
        let vertexShaderName: GLuint = self.compileShader(shaderName: vertexShader,
                                                          shaderType: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderName: GLuint = self.compileShader(shaderName: fragmentShader,
                                                    shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        glAttachShader(self.programHandle, vertexShaderName)
        glAttachShader(self.programHandle, fragmentShaderName)
        
        glBindAttribLocation(self.programHandle, GLuint(HUTVertextAttributes.position.rawValue), "a_Position")
        
        glLinkProgram(self.programHandle)
        
        var linkSuccess: GLint = GL_FALSE
        glGetProgramiv(self.programHandle, GLenum(GL_LINK_STATUS), &linkSuccess)
        if linkSuccess == GL_FALSE {
            var messages: [CChar] = Array(repeatElement(CChar.init(), count: 256))
            let sizeOfMsg: Int32 = Int32(MemoryLayout<CChar>.size * messages.count)
            glGetProgramInfoLog(self.programHandle, sizeOfMsg, nil, &messages[0])
            let messagesString = String.init(describing: messages)
            print("comileVertexShader: \(messagesString)")
            exit(1)
        }
    }
}










