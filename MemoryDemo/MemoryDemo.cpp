#include <iostream>

void print(int* data, int size) {
    for (int i = 0; i < size; ++i) {
        std::cout << "C++ value: " << data[i] << std::endl;
    }
}

int main() {
    int* data = new int[5]; // heap allocation
    for (int i = 0; i < 5; ++i) {
        data[i] = i + 1;
    }
    print(data, 5);
    delete[] data; // must manually deallocate
    return 0;
}
