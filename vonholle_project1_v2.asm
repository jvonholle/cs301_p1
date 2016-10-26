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
    extern glClearColor
    extern glutSwapBuffers
    extern glutReshapeFunc
    extern glClearDepthf
    extern glutInitWindowPosition
    extern glEnable
    extern glRotatef
    extern glDepthFunc
    extern gluPerspective
    extern glViewport
    extern glShadeModel
    extern glHint
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
    extern glRotatef

    section .text
    window_title: db '3d here we go! Woo!',0xA,0x0
    msg:          db 'done with thing',0xA,0x0
    zero:       dd 0.0
    one:        dd 0.10
    half:       dd 0.05
    neghalf:    dd -0.05
    negone:     dd -0.10
    quart:      dd 0.025
    onehalf:    dd 0.55
    negseven:   dd -0.70
    negsix:     dd -0.60
    negonehalf: dd -0.55
    fourtyfive: dd 45.0
    pointone:   dd 0.1
    hunned:     dd 100.0
    ONE:        dd 1.0
    ten:        dd 10.0

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
;pseudo constructor to deal with local variables
    push rbp     ; save old rbp
    mov rbp, rsp ; point ebp to this 

    mov rdi, 0x000040000
    OR  rdi, 0x000001000
        call glClear  ; glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT ); clears color and depth buffers

    mov rdi, 0x1700
        call glMatrixMode ; glMatrixMode( GL_MODELVIEW ); operate on a model-view matrix

    ; Render a colored cube, 6 quads with colors
    call glLoadIdentity ; glLoadIdentity(); reset the model-view matrix
    movss xmm0, [onehalf]
    movss xmm1, [zero]
    movss xmm2, [negseven]
        call glTranslatef ; glTranslatef( 1.5, 0.0, -7.0 ); move right and into the screen
    movss xmm0, [fourtyfive]
    movss xmm1, [zero]
    movss xmm2, [ONE]
    movss xmm3, [zero]
        call glRotatef
    movss xmm0, [ten]
    movss xmm1, [ONE]
    movss xmm2, [zero]
    movss xmm3, [zero]
        call glRotatef

; ********
; * Cube *
; ********

    mov rdi, 0x0007 
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

; ***********
; * Pyramid *
; ***********

    call glLoadIdentity     ; reset model-view matrix
    
    movss xmm0, [negonehalf]
    movss xmm1, [zero]
    movss xmm2, [negsix]
        call glTranslatef   ; glTranslatef( -1.5, 0.0, -6.0 );

    movss xmm0, [fourtyfive]
    movss xmm1, [zero]
    movss xmm2, [ONE]
    movss xmm3, [zero]
        call glRotatef
    movss xmm0, [ten]
    movss xmm1, [ONE]
    movss xmm2, [zero]
    movss xmm3, [zero]
        call glRotatef

    mov rdi, 0x0004
        call glBegin        ; glBegin( GL_TRIANGLES );
; # FRONT
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f      ; glColor( rv1, gv1, gv1 );
    movss xmm0, [zero]
    movss xmm1, [one]
    movss xmm2, [zero]
        call glVertex3f     ; glVertex3f( 0.0, 1.0, 0.0 );
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f      ; glColor( rv2, gv2, bv2 );
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f
; # RIGHT
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f
    movss xmm0, [zero]
    movss xmm1, [one]
    movss xmm2, [zero]
        call glVertex3f
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f
; # BACK
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f
    movss xmm0, [zero]
    movss xmm1, [one]
    movss xmm2, [zero]
        call glVertex3f
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f
    movss xmm0, [one]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f
; # LEFT
    movss xmm0, [rv1]
    movss xmm1, [gv1]
    movss xmm2, [bv1]
        call glColor3f
    movss xmm0, [zero]
    movss xmm1, [one]
    movss xmm2, [zero]
        call glVertex3f
    movss xmm0, [rv2]
    movss xmm1, [gv2]
    movss xmm2, [bv2]
        call glColor3f
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [negone]
        call glVertex3f
    movss xmm0, [rv3]
    movss xmm1, [gv3]
    movss xmm2, [bv3]
        call glColor3f
    movss xmm0, [negone]
    movss xmm1, [negone]
    movss xmm2, [one]
        call glVertex3f
call glEnd

    call glutSwapBuffers
  leave
ret

reshape:
    push rbp
    mov rbp, rsp ; handle local variables

    mov rdx, rdi
    mov rcx, rsi
    mov rsi, 0
    mov rdi, 0
        call glViewport ; glViewport( 0, 0, width, height );
   
    mov rdi, 0x1701
        call glMatrixMode ; glMatrixMode( GL_PROJECTION );

    call glLoadIdentity   ; glLoadIdentity();

mov rdi, msg
call printf

leave
ret

main:
; init to deal with local variables
    push rbp
    mov rbp, rsp ; point rbp at this
    sub rsp, 16  ; make space 

    mov rsi, [rbp-16] ; argv
    lea rdi, [rbp-4]  ; argc
        call glutInit ; glutInit(&argc, argv);

    mov rdi, 0x0002
        call glutInitDisplayMode ; glutInitDisplayMode( GLUT_DOUBLE );

    mov rdi, 960 
    mov rsi, 1080
        call glutInitWindowSize  ; glutInitWindowSize( 400, 400 );

    mov rdi, window_title
        call glutCreateWindow    ; glutCreateWindow( window_title );

    mov rdi, display
        call glutDisplayFunc     ; glutDisplayFunc( display );
    mov rdi, reshape
        call glutReshapeFunc     ; glutReshapeFunc( reshape );

; init block
    movss xmm0, [zero]
    movss xmm1, [zero]
    movss xmm2, [zero]
    movss xmm3, [one]
        call glClearColor        ; glClearColor( 0.0, 0.0, 0.0, 1.0 );
    movss xmm0, [one]
        call glClearDepthf       ; glClearDethf( 1.0 );
    mov rdi, 2929
        call glEnable            ; glEnable( GL_DEPTH_TEST );
    mov rdi, 515 
        call glDepthFunc         ; glDepthFunc( GL_LEQUAL );
    mov rdi, 0x0B71
        call glShadeModel        ; glShadeModel( GL_SMOOTH );
    mov rdi, 0x0c50
    mov rsi, 0x1102
        call glHint              ; glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );
; end init block

    call glutMainLoop            ; glutMainLoop();

    ; cleanup for local variable helper
    mov rsp, rbp
    pop rbp

mov rax, 0
ret
