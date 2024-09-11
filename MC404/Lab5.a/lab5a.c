int read(int __fd, const void *__buf, int __n){
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall write code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)  // Output list
    : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
  __asm__ __volatile__(
    "mv a0, %0           # file descriptor\n"
    "mv a1, %1           # buffer \n"
    "mv a2, %2           # size \n"
    "li a7, 64           # syscall write (64) \n"
    "ecall"
    :   // Output list
    :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
}

void exit(int code)
{
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}

#define STDIN_FD  0
#define STDOUT_FD 1


char intchar(int digito){
  char crct;
  if(digito <=9){
    crct = digito + '0';
  }else {
    crct = digito + 'A' - 10;
  }
  return crct;
}


void print_hex(int num_int){
  unsigned int hex_mask = 0xf0000000;
  unsigned int num = num_int;
  unsigned int aux = 0;
  int start = 0;
  char str[50];
  str[0] = '0';
  str[1] = 'x';

  for(int i = 0; i < 8; i++){
    aux = num & hex_mask;
    aux >>= (28 - (4 * i));
    hex_mask >>= 4;
    str[i + 2] = intchar(aux);
    }
  
  str[10] = '\n';

  write(STDOUT_FD, str, 11);
}


int potencia(int base, int elev){
  int num = 1;
  for (int i = 0; i < elev; i++)
  {
    num = num * base;
  }
  return num;
}


int leitor(int ordem, char* buffer){
    //sinais 0 - 6 - 12 - 18 - 24
    unsigned num = 0;
    for(int i = 0; i < 4; i++){
        num += (buffer[((ordem - 1) * 6) + 1 + i] - '0' ) * potencia(10, 3-i);
    }
    if(buffer[((ordem - 1) * 6)] == '-'){
        num *= -1;
    }
    return num;
}


int conversor(char* buffer){
    unsigned int bit_mask1 = 0b111;
    unsigned int bit_mask2 = 0b11111111;
    unsigned int bit_mask3 = 0b11111;
    unsigned int bit_mask4 = 0b11111;
    unsigned int bit_mask5 = 0b11111111111;
    unsigned int num = 0;

    num += (bit_mask1 & leitor(1, buffer));
    num += ((bit_mask2 & leitor(2, buffer)) << 3);
    num += ((bit_mask3 & leitor(3, buffer)) << 11);
    num += ((bit_mask4 & leitor(4, buffer)) << 16);
    num += ((bit_mask5 & leitor(5, buffer)) << 21);

    return num;
}


int main()
{
    char buffer[32];
    int n = read(STDIN_FD, buffer, 32);
     
    int num = conversor(buffer);

    print_hex(num);
}