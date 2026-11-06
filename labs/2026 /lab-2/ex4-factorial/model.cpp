#include <iostream>

// Global variables simulating the data section
int n = 5; 
int result = 0;

// Factorial procedure
int factorial(int num) {
    int fact = 1;
    for (int i = 1; i <= num; i++) {
        fact *= i;
    }
    return fact;
}

int main() {
    result = factorial(n);
    std::cout << "Factorial of " << n << " is: " << result << std::endl;
    return 0;
}
