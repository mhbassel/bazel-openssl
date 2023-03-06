#include <iostream>
#include <openssl/evp.h>

int main(int argc, char** argv) {
  // Testing openssl
  std::cout << "Testing OpenSSL:" << std::endl;
  cipher = EVP_get_cipherbyname("aes-256-cbc");
  EVP_add_cipher(cipher);
  return 0;
}
