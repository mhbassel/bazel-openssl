#include <ctime>
#include <string>
#include <iostream>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/rand.h>

std::string get_greet(const std::string& who) {
  return "Hello " + who;
}

void print_localtime() {
  std::time_t result = std::time(nullptr);
  std::cout << std::asctime(std::localtime(&result));
}

int main(int argc, char** argv) {
  std::string who = "world";
  if (argc > 1) {
    who = argv[1];
  }
  std::cout << get_greet(who) << std::endl;
  print_localtime();
  cipher = EVP_get_cipherbyname("aes-256-cbc");
  EVP_add_cipher(cipher);
  return 0;
}
