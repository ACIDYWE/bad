#include <stdio.h>
#include <string.h>
#include <stdint.h>

/*
int compute_the_part(char al, char* string)
{
  int v2 = 4, v3 = 0;
  char v4;
  do
  {
    v4 = *string;
    if (v4 < 65)
      v4-= 48;
    else
    {
      al+= (v4 < 87);
      al<<= 5;
      v4+=  al - 87;
    }
    v3 += (v4 & 15) << 4 * (v2 - 1);
    string++;
    v2--;
  }
  while( v2 );
  return v3;
}

int do_some_math(unsigned int A1, unsigned int A2, unsigned int A3)
{
  int result;
  while(a1 > 0)
  {
    if (a1 & 1)
      result = (a2 * result) % a3;
    a1 >>= 1;
    a2 = (a2 * a2) % a3;
  }
  return result;
*/
void main()
{
  char serial[] = "asdf-asdf";
/*  int32_t MLP = 0x7E4C9E32;
  char username[] = "MY_USERNAME\n", serial[] = "1234-5678\n";
  short int i = 0;
  do
  {
    MLP *= serial[i];
    i++;
  }
  while(serial[i]);
  int part_1 = compute_the_part(MLP % 256, serial);
  int part_2 = compute_the_part(MLP % 256, serial + 5);
  printf("Part_1 = %d\nPart_2 = %d\n", part_1, part_2);
  int ASDF;
  ASDF = do_some_math(0xF2A5, PART_2, 0xF2A7);
*/
for (int a = 33; a < 127; a++)
  {
    printf("Serial: %s\n",serial);
    for (int b = 33; b < 127; b++)
      {
        for (int c = 33; c < 127; c++)
          {
            for (int d = 33; d < 127; d++)
              {
                for (int e = 33; e < 127; e++)
                  {
                    for (int f = 33; f < 127; f++)
                      {
                        for (int g = 33; g < 127; g++)
                          {
                            for (int h = 33; h < 127; h++)
                              {
                                  serial[0] = a;
                                  serial[1] = b;
                                  serial[2] = c;
                                  serial[3] = d;
                                  serial[5] = e;
                                  serial[6] = f;
                                  serial[7] = g;
                                  serial[8] = h;
                                  //printf("Serial: %s\n",serial);
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
}
