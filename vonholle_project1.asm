; James Von Holle
; CS 301 Assembly
; Project 1 - vonholle_project1.asm

; Draws a box and a triangle, both are pretty colors

; code borrowed heavily from the following sources:
; https://forum.nasm.us/index.php?topic=342.0
; lazyfoo.net/tutorials/OpenGL/

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

    section .text
    msg: db 'Hello 64-bit world!',0xA,0x0
    zero: dd 0.0
    one: dd 1.0
    half: dd 0.5
    neghalf: dd -0.5
    negone: dd -1.0
    quart: dd 0.25

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
        call glClear  ; glClear( GL_COLOR_BUFFER_BIT );

    mov edi, 9
        call glBegin ; glBegin( GL_POLYGON );

; ********
; SQUARE *
; ********
        movss xmm0, [rv1]
        movss xmm1, [gv1]
        movss xmm2, [bv1]
    call glColor3f ; glColor ( rv1, gv1, bv1 )

        movss xmm0, [zero]
        movss xmm1, [zero]
    call glVertex2f ; glVertex2f( 0.25, 0.25 );

        movss xmm0, [rv2]
        movss xmm1, [gv2]
        movss xmm2, [bv2]
    call glColor3f ; glColor ( rv2, gv2, bv2 );

        movss xmm0, [half]
        movss xmm1, [zero]
    call glVertex2f ; glVertex2f( 0.5, 0.25 );

        movss xmm0, [rv3]
        movss xmm1, [gv3]
        movss xmm2, [bv3]
    call glColor3f ; glColor ( rv3, gv3, bv3 )

        movss xmm0, [half]
        movss xmm1, [half]
    call glVertex2f ; glVertex2f( 0.5, 0.5 );

        movss xmm0, [zero]
        movss xmm1, [half]
    call glVertex2f ; glVertex3f( 0.25, 0.5 );

    call glEnd ; glEnd();
        call glFlush ; glFlush();

; **********
; TRIANGLE *
; **********

    mov edi, 9
        call glBegin ; glBegin( GL_POLYGON );

        movss xmm0, [rv1]
        movss xmm1, [gv1]
        movss xmm2, [bv1]
    call glColor3f ; glColor ( rv1, gv1, bv1 )

        movss xmm0, [zero]
        movss xmm1, [neghalf]
    call glVertex2f ; glVertex2f( -0.5, -0.5 );

        movss xmm0, [rv2]
        movss xmm1, [gv2]
        movss xmm2, [bv2]
    call glColor3f ; glColor ( rv2, gv2, bv2 )

        movss xmm0, [neghalf]
        movss xmm1, [zero]
    call glVertex2f ; glVertex2f( 0.5, 0.0 );

        movss xmm0, [rv3]
        movss xmm1, [gv3]
        movss xmm2, [bv3]
    call glColor3f ; glColor ( rv3, gv3, bv3 )

        movss xmm0, [negone]
        movss xmm1, [neghalf]
    call glVertex2f ; glVertex2f( 0.5, 0.5 );


    call glEnd ; glEnd();
        call glFlush ; glFlush();

; *****************************
; CIRCLE  -- WORK IN PROGRESS *
; *****************************


   ; mov edi, 9
   ;     call glBegin ; glBegin( GL_POLYGON );

    


   ; call glEnd ; glEnd();
   ;     call glFlush ; glFlush();


    leave
        ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov rsi, [rbp-16]
    lea rdi, [rbp-4]
        call glutInit

    mov edi,0
        call glutInitDisplayMode
        mov esi, 400 
        mov edi, 400
        call glutInitWindowSize
        mov edi, msg
        call glutCreateWindow
        mov edi, display
        call glutDisplayFunc
        call glutMainLoop

    mov rsp, rbp
    pop rbp

mov eax, 0
ret
