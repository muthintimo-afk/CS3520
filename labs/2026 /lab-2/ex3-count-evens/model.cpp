#include <iostream>
using namespace std;

int main() {
    int array[] = {10, 7, 4, 9, 12, 5};
    int N = 6;
    int count = 0;

    for (int i = 0; i < N; i++) {
        if (array[i] % 2 == 0) {
            count++;
        }
    }

    cout << "Number of even elements = " << count << endl;

    return 0;
}
