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
    
    // 顶点缓冲对象(Vertex Buffer Objects, VBO)管理这个内存，它会在GPU内存（通常被称为显存）中储存大量顶点
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
        
        // 启用顶点属性, 以顶点属性位置值作为参数，启用顶点属性；顶点属性默认是禁用的 VAO？
        glEnableVertexAttribArray(HUTVertextAttributes.position.rawValue)
        
        // 告诉OpenGL该如何解析顶点数据（应用到逐个顶点属性上）详见 1.1
        glVertexAttribPointer(HUTVertextAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<HUTVertex>.size), nil)
        
        // 绑定顶点数据
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer);
        
        // 绘制 1.2
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3);
        
        // 禁用顶点属性
        glDisableVertexAttribArray(HUTVertextAttributes.position.rawValue);
    }
    
    private func setupVertexBuffer() {
        let vertices: [HUTVertex] = [HUTVertex.init(Position: (-1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (1.0, -1.0, 0.0)),
                                     HUTVertex.init(Position: (0.0, 0.0, 0.0))]
        
        // 生成一个VBO对象
        glGenBuffers(1, &self.vertexBuffer)
        
        // 新创建的缓冲绑定到GL_ARRAY_BUFFER目标上 (OpenGL有很多缓冲对象类型，当前使用的顶点缓冲对象的缓冲类型是GL_ARRAY_BUFFER)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer)
        
        
        // 把之前定义的顶点数据复制到缓冲的内存（GPU）中 详见 1.0
        let sizeOfVerties: Int = MemoryLayout<HUTVertex>.size * 3;
        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(sizeOfVerties), vertices, GLenum(GL_STATIC_DRAW))
    }
    
    private func setupShader() {
        self.shader = HUTBaseEffect.init(vertexShader: "HUTSimpleVertex.glsl", fragmentShader: "HUTSimpleFragment.glsl")
    }
}


/**
 *  1.0 glBufferData
 *
 *  glBufferData是一个专门用来把用户定义的数据复制到当前绑定缓冲的函数。它的第一个参数是目标缓冲的类型：顶点缓冲对象当前绑定到GL_ARRAY_BUFFER目标上。第二个参数指定传输数据的大小(以字节为单位)；用一个简单的sizeof计算出顶点数据大小就行。第三个参数是我们希望发送的实际数据。
 
 第四个参数指定了我们希望显卡如何管理给定的数据。它有三种形式：
 
 GL_STATIC_DRAW ：数据不会或几乎不会改变。
 GL_DYNAMIC_DRAW：数据会被改变很多。
 GL_STREAM_DRAW ：数据每次绘制时都会改变。
 */

/**
 *  1.1 glVertexAttribPointer
 *
 *  glVertexAttribPointer函数的参数非常多，所以我会逐一介绍它们：
 第一个参数指定我们要配置的顶点属性。还记得我们在顶点着色器中使用layout(location = 0)定义了position顶点属性的位置值(Location)吗？它可以把顶点属性的位置值设置为0。因为我们希望把数据传递到这一个顶点属性中，所以这里我们传入0。
 第二个参数指定顶点属性的大小。顶点属性是一个vec3，它由3个值组成，所以大小是3。
 第三个参数指定数据的类型，这里是GL_FLOAT(GLSL中vec*都是由浮点数值组成的)。
 下个参数定义我们是否希望数据被标准化(Normalize)。如果我们设置为GL_TRUE，所有数据都会被映射到0（对于有符号型signed数据是-1）到1之间。我们把它设置为GL_FALSE。
 第五个参数叫做步长(Stride)，它告诉我们在连续的顶点属性组之间的间隔。由于下个组位置数据在3个float之后，我们把步长设置为3 * sizeof(float)。要注意的是由于我们知道这个数组是紧密排列的（在两个顶点属性之间没有空隙）我们也可以设置为0来让OpenGL决定具体步长是多少（只有当数值是紧密排列时才可用）。一旦我们有更多的顶点属性，我们就必须更小心地定义每个顶点属性之间的间隔，我们在后面会看到更多的例子（译注: 这个参数的意思简单说就是从这个属性第二次出现的地方到整个数组0位置之间有多少字节）。
 最后一个参数的类型是void*，所以需要我们进行这个奇怪的强制类型转换。它表示位置数据在缓冲中起始位置的偏移量(Offset)。由于位置数据在数组的开头，所以这里是0。
 */

/**
 *  1.2 glDrawArrays
 *
 *  glDrawArrays函数第一个参数是我们打算绘制的OpenGL图元的类型。由于我们在一开始时说过，我们希望绘制的是一个三角形，这里传递GL_TRIANGLES给它。第二个参数指定了顶点数组的起始索引，我们这里填0。最后一个参数指定我们打算绘制多少个顶点，这里是3（我们只从我们的数据中渲染一个三角形，它只有3个顶点长）
 */

/**
 *
 *
 */

