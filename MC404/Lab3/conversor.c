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

int potencia(int base, int elev){
  int num = 1;
  for (int i = 0; i < elev; i++)
  {
    num = num * base;
  }
  return num;
}


char intchar(int digito){
  char crct;
  if(digito <=9){
    crct = digito + '0';
  }else {
    crct = digito + 'a';
  }
  return crct;
}


void print_binary(int num){
  int binary_mask = 0x80000000;
  int start = 0;
  int zeros = 0;
  char str[35];
  str[0] = '0';
  str[1] = 'b';
  for(int i = 0; i < 32; i++){
    if(num & binary_mask){
      if(!start){
        start = 1;
      }
      str[i + 2 - zeros] = '1';

    }else {
      if(start){
        str[i + 2 - zeros] = '0';
      }else {
        zeros += 1;
      }
    }
    binary_mask >>= 1;
  }
  str[34 - zeros] = '\n';
}


void print_hex(int num){
  int hex_mask = 0xf0000000;
  int start = 0;
  int aux = 0;
  int zeros = 0;
  char str[11];
  str[0] = '0';
  str[1] = 'x';

  for(int i = 0; i < 8; i++){
    aux = num & hex_mask;
    aux >>= (28 - (4 * i));
    hex_mask >>= 4;

    if(aux == 0){
      if(start){
        str[i + 2 - zeros] = '0';
      }else {
        zeros += 1;
      }
    }else {
      start = 1;
      str[i + 2 - zeros] = intchar(aux);
    }
  }
  str[10 - zeros] = '\n';

  write(STDOUT_FD, str, 11 - zeros);
}


void print_dec(int num){
  int start = 0;
  int aux = 0;
  int zeros = 0;
  int negativo = 0;
  char str[12];
  if(num < 0){
    str[0] = '-';
    negativo = 1;
    num * -1;
  }
  for(int i = 0; i < 10; i++){
    str[i + negativo] = intchar(num / potencia(10, 9 - i));
  }
}


int main()
{
  char buffer[20];
  /* Read up to 20 bytes from the standard input into the str buffer */
  int n = read(STDIN_FD, buffer, 20);
  int num = 0;

  //se a entrada for hexadecimal
  if(buffer[1] == 'x'){
    for (int i = 0; i < n - 2; i++){

      if((buffer[i + 2]) <= '9'){
        num += (buffer[i + 2] - '0') * potencia(16, n - 3 - i);

      }else {
        if(buffer[i + 2] == 'a'){
          num += 10 * potencia(16, n - 3 - i);

        }else if(buffer[i + 2] == 'b'){
          num += 11 * potencia(16, n - 3 - i);

        }else if(buffer[i + 2] == 'c'){
          num += 12 * potencia(16, n - 3 - i);

        }else if(buffer[i + 2] == 'd'){
          num += 13 * potencia(16, n - 3 - i);
          
        }else if(buffer[i + 2] == 'e'){
          num += 14 * potencia(16, n - 3 - i);
          
        }else if(buffer[i + 2] == 'f'){
          num += 11 * potencia(16, n - 3 - i);         
        }
      }
    }


  }else { //se a entrada for decimal
    if(buffer[0] == '-'){
      for (int i = 1; i < n; i++){
        num += (buffer[i] - '0') * potencia(10, n - 1 - i);
      }
    }else {
      for(int i = 0; 1 < n; i++){
        num += (buffer[i] - '0') * potencia(10, n - 1 - i);
      }
    }
  }
  



  /* Write n bytes from the str buffer to the standard output */
  write(STDOUT_FD, buffer, n);
  return 0;
}
