; James Von Holle
; CS 301 Assembly
; Project 1 V2 - vonholle_project1.asm

; Draws a cube

; code borrowed heavily from the following sources:
; https://forum.nasm.us/index.php?topic=342.0
; lazyfoo.net/tutorials/OpenGL/
; https://www.ntu.edu.sg/home/ehchua/programming/opengl/CG_Examples.html

global main
    extern printf
    extern glClear
    extern glBegin
    extern glEnd
    extern glColor3f
    extern glVertex3f
    extern glVertex2f
    extern glFlush
    extern glutInit
    extern glutInitDisplayMode
    extern glutInitWindowPosition
    extern glutInitWindowSize
    extern glutCreateWindow
    extern glutDisplayFunc
    extern glutMainLoop
    extern glMatrixMode
    extern glLoadIdentity
    extern glTranslatef

    section .text
    window_title: db '3d here we go! Woo!',0xA,0x0
    zero: dd 0.0
    one: dd 1.0
    half: dd 0.5
    neghalf: dd -0.5
    negone: dd -1.0
    quart: dd 0.25
    onehalf: dd 1.5
    negseven: dd -7.0

;colors
    rv1: dd 0.439215686
    gv1: dd 0.952941176
    bv1: dd 1.0
    rv2: dd 0.615685274
    gv2: dd 0.243137255
    bv2: dd 0.819607843
    rv3: dd 0.419607843
    gv3: dd 0.937254901
    bv3: dd 0.411764705

display:
        push rbp
        mov rbp, rsp

    mov edi, 16384
    OR edi, 256
        call glClear  ; glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT ); clears color and depth buffers

    mov edi, 0
        call glMatrixMode ; glMatrixMode( GL_MODELVIEW ); hopefully to operate on a model-view matrix

    ; Render a colored cube, 6 quads with colors
    call glLoadIdentity ; glLoadIdentity(); reset the model-view matrix
    movss xmm0, [onehalf]
    movss xmm1, [zero]
    movss xmm2, [negseven]
        call glTranslatef ; glTranslatef( 1.5, 0.0, -7.0 ); move right and into the screen

; ********
; * Cube *
; ********

    mov edi, 7 
        call glBegin ; glBegin( GL_QUADS );

; Vertices defined counter-clockwise order with normal pointing out

; # Top Face y = 1.0 #
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f ; glColor( rv1, gv1, bv1 );

    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, 1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, 1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, 1.0, 1.0 );
    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, 1.0, 1.0 );

; # Bottom Face y = -1.0 #
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f ; glColor( rv2, gv2, bv2 );

    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, -1.0, 1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, -1.0, 1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, -1.0, -1.0 );
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, -1.0, -1.0 );

; # Front Face z = 1.0 #
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f ; glColor( rv3, gv3, bv3 );

    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, 1.0, 1.0 );
    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, 1.0, 1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, -1.0, 1.0 );
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, -1.0, 1.0 );

; # Back Face z = -1.0 #
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f ; glColor( rv1, gv1, bv1 );
    
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, -1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, -1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, 1.0, -1.0 );
    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, 1.0, -1.0 );

; # Left Face x = -1.0 #
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f ; glColor( rv2, gv2, bv2 );

    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, 1.0, 1.0 );
    movss xmm0, [negone]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, 1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( -1.0, -1.0, -1.0 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( -1.0, -1.0, 1.0 );

; # Right Face x = 1.0 #
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f ; glColor( rv3, gv3, bv3 );

    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, 1.0, -1.0 );
    movss xmm0, [one]
    movss xmm1, [one]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, 1.0, 1.0 );
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f ; glVertex3f( 1.0, -1.0, 1.0 );
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f ; glVertex3f( 1.0, -1.0, -1.0 );

call glEnd ; glEnd();
    
    leave
        ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov rsi, [rbp-16]
    lea rdi, [rbp-4]
        call glutInit

    mov edi, 4
        call glutInitDisplayMode ; glutInitDisplayMode( GLUT_DOUBLE );
    mov esi, 400 
    mov edi, 400
        call glutInitWindowSize  ; glutInitWindowSize( 400, 400 );
    mov edi, window_title
        call glutCreateWindow    ; glutCreateWindow( window_title );
    mov edi, display
        call glutDisplayFunc     ; glutDisplayFunc( display() );
    call glutMainLoop            ; glutMainLoop();

    mov rsp, rbp
    pop rbp

mov eax, 0
ret
