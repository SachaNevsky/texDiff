/* This program removes kerns smaller then KERNLIMIT from AFM file
   Petr Olsak, 2012
   input AFM file = stdin, output = stdout, no parameters */


#include <stdio.h>

#define KERNLIMIT 9

char line[500];

int mygets(char *s, int num) 
{
  int c, i;   
  if ((c=fgetc(stdin))==EOF) return EOF;
  if (c=='\n')  return s[0] = 0;
  s[0] = c; i=1;
  while (1) {
    if (i>=num) {
      fprintf (stderr, "line is too long\n");
      s[num-1] = 0;
      return;
    }
    if ((c=fgetc(stdin))==EOF) return s[i] = 0;
    if (c=='\n')  return s[i] = 0;
    s[i++]=c;
  } 
}

int main(int argc, char *argv[]) 
{
  int i, v;
  while (1) {
     if (mygets(line,500)==EOF) return 0;
     v=100;
     if (line[0]=='K' && line[1]=='P' && line[2]=='X' && line[3]==' ') {
        i = 4;
        while (line[i]!=' ') i++;
        i++;
        while (line[i]!=' ') i++;
        v = atoi(&line[i]);
     }
     if (v>KERNLIMIT || v<-KERNLIMIT) printf("%s\n", line);
  }
}
