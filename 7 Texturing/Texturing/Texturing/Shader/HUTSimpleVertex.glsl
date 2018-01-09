
uniform highp mat4 u_ModelViewMatrix;
uniform highp mat4 u_ProjectionMatrix;

attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TextCoord;

varying lowp vec4 frag_Color;

void main(void) {
    gl_Position = u_ProjectionMatrix * u_ModelViewMatrix * a_Position;
    frag_Color = a_Color;
    frag_TexCoord = a_TexCoord;
}
