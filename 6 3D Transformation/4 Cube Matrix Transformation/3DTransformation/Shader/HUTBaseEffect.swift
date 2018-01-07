//
//  HUTBaseEffect.swift
//  TrangleShapeChange
//
//  Created by Stoull Hut on 01/01/2018.
//  Copyright © 2018 CCApril. All rights reserved.
//

import UIKit

import GLKit

class HUTBaseEffect: NSObject {
    
    var programHandle: GLuint = 0
    
    var vertexShaderHandle: GLuint = 0
    var fragmentShaderHandle: GLuint = 0
    
    var modelViewMatrix: GLKMatrix4?
    var modelViewMatrixUniform :GLuint = 0
    var projectionMatrix: GLKMatrix4?
    var projectionMatrixUniform: GLuint = 0
    
    public init(vertexShader: String, fragmentShader: String) {
        super.init()
        compileShader(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }
    
    public func prepareToDraw() {
        glUseProgram(programHandle)
        
        var matrixM = modelViewMatrix?.m
        
        
        //        let m: UnsafePointer<GLfloat> = modelViewMatrix?.m
        // WARN:
        let components = MemoryLayout.size(ofValue: matrixM)/MemoryLayout.size(ofValue: matrixM?.0)
        withUnsafePointer(to: &matrixM) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: components) {
                glUniformMatrix4fv(GLint(modelViewMatrixUniform), 1, 0, $0)
            }
        }
        
        withUnsafePointer(to: &matrixM) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: components) {
                glUniformMatrix4fv(GLint(projectionMatrixUniform), 1, 0, $0)
            }
        }
    }
    
    private func compileShader(vertexShader: String, fragmentShader: String) {
        programHandle = glCreateProgram()
        
        vertexShaderHandle = compileShaderName(shaderName: vertexShader, shaderType: GLenum(GL_VERTEX_SHADER))
        fragmentShaderHandle = compileShaderName(shaderName: fragmentShader, shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        glAttachShader(programHandle, vertexShaderHandle)
        glAttachShader(programHandle, fragmentShaderHandle)
        
        glBindAttribLocation(programHandle, GLuint(HUTVertextAttributes.position.rawValue), "a_Position")
        glBindAttribLocation(programHandle, GLuint(HUTVertextAttributes.color.rawValue), "a_Color")
        
        glLinkProgram(programHandle)
        
        self.modelViewMatrix = GLKMatrix4Identity
        modelViewMatrixUniform = GLuint(glGetUniformLocation(programHandle, "u_ModelViewMatrix"))
        projectionMatrixUniform = GLuint(glGetUniformLocation(programHandle, "u_ProjectionMatrix"))
        
        var linkSuccessStatus: GLint = GL_FALSE
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &linkSuccessStatus)
        if linkSuccessStatus == GL_FALSE {
            var messages: [CChar] = Array(repeatElement(CChar.init(), count: 256))
            let sizeOfMsg = Int32(MemoryLayout<CChar>.size * messages.count)
            glGetProgramInfoLog(programHandle, sizeOfMsg, nil, &messages[0])
            let messageString = String.init(cString: messages)
            print("Link program error :\(messageString)")
        }
        
    }
    
    private func compileShaderName(shaderName: String, shaderType: GLenum) -> GLuint {
        guard let shaderPath = Bundle.main.path(forResource: shaderName, ofType: "glsl") else {
            print("Failed to load Shader file")
            return 0
        }
        
        // Convert String to NSString
        var shaderPathString: NSString
        do{
            shaderPathString = try String.init(contentsOfFile: shaderPath, encoding: .utf8) as NSString
        }catch {
            print("Failed to load vertex shader")
            exit(1)
        }
        
        var shaderHandle: GLuint = 0
        shaderHandle = glCreateShader(shaderType)
        if shaderHandle == 0 {
            print("Creat shader failed")
        }
        
        var shaderPathUtf8  = shaderPathString.utf8String
        var shaderPathUtf8Length: GLint = GLint(shaderPathString.length)
        glShaderSource(shaderHandle, 1, &shaderPathUtf8, &shaderPathUtf8Length)
        
        glCompileShader(shaderHandle)
        
        var compileSuccessStatus = GL_FALSE
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccessStatus)
        if compileSuccessStatus == GL_FALSE {
            var message: [CChar] = Array(repeating: CChar.init(), count: 256)
            let sizeOfMsg = Int32(MemoryLayout<CChar>.size * message.count)
            glGetShaderInfoLog(shaderHandle, sizeOfMsg, nil, &message[0])
            let messageString = String.init(cString: message)
            print("compileShader error: \(messageString)")
            exit(1)
        }
        return shaderHandle
    }

}
