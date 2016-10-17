all: vonholle_project1.o
	gcc vonholle_project1.o -lGL -lglut && rm vonholle_project1.o

vonholle_project1.o:
	yasm -felf64 vonholle_project1.asm
