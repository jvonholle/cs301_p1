all: vonholle_project1_v2.o
	gcc vonholle_project1_v2.o -lGL -lglut -lGLU && rm vonholle_project1_v2.o

v1: vonholle_project1.o
	gcc vonholle_project1.o -lGL -lglut && rm vonholle_project1.o

vonholle_project1.o:
	yasm -felf64 vonholle_project1.asm

vonholle_project1_v2.o:
	yasm -felf64 vonholle_project1_v2.asm
