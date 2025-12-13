#include <stdio.h> 
long double x, y;
int main(void){
 printf("Mittelwertberechnung\n"); 
 printf("Erster Wert: ");
 scanf("%Lf", &x); 
 printf("\nZweiter Wert: ");
 scanf("%Lf", &y);
 printf("\nDer Mittelwert ist  
   %Lf et de %Lf est %Lf.\n",
   x, y, (x+y)/2);
  return 0; }
