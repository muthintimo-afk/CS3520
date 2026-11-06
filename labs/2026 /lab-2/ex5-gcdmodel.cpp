#include <iostream>

// Global variables simulating the data section
int num1 = 54;
int num2 = 24;
int result = 0;

// GCD procedure using Euclid's subtraction algorithm
int gcd(int a, int b) {
    if (a == 0) return b;
    if (b == 0) return a;
    
    while (a != b) {
        if (a > b) {
            a = a - b;
        } else {
            b = b - a;
        }
    }
    return a;
}

int main() {
    result = gcd(num1, num2);
    std::cout << "GCD of " << num1 << " and " << num2 << " is: " << result << std::endl;
    return 0;
}
