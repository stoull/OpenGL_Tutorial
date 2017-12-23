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
    
    var programHandle: GLuint!

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
                glGetShaderInfoLog(shaderHandle, sizeOfMsg, nil, &messages[0])
                let meesageString = String.init(describing: messages)
                print("compileShader: \(meesageString)")
                exit(1)
            }
            return shaderHandle
        }else {
            print("Cannot get glsl file")
            exit(1)
        }
    }
    
    private func comileVertexShader(vertexShader: String, fragmentShader: String) {
        let vertexShaderName: GLuint = self.compileShader(shaderName: vertexShader,
                                                          shaderType: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderName: GLuint = self.compileShader(shaderName: fragmentShader,
                                                    shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        self.programHandle = glCreateProgram()
        glAttachShader(self.programHandle, vertexShaderName)
        glAttachShader(self.programHandle, fragmentShaderName)
        
        glBindAttribLocation(self.programHandle, GLuint(HUTVertextAttributes.position.rawValue), "a_Position")
        
        glLinkProgram(self.programHandle)
        
        var linkSuccess: GLint = GL_FALSE
        glGetProgramiv(self.programHandle, GLenum(GL_LINK_STATUS), &linkSuccess)
        if linkSuccess == GL_FALSE {
            var messages: [CChar] = Array(repeatElement(CChar.init(32), count: 256))
            let sizeOfMsg: Int32 = Int32(MemoryLayout<CChar>.size * messages.count)
            glGetProgramInfoLog(self.programHandle, sizeOfMsg, nil, &messages[0])
            let messagesString = String.init(describing: messages)
            print("comileVertexShader: \(messagesString)")
            exit(1)
        }
    }
}










