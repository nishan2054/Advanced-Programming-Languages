#include <iostream>
#include <functional>
using namespace std;

function<void()> outerFunc(){
    int x = 2;
    return[x](){
        cout << "Square vale: " << x * x << endl;
    };
}

int main() {
    auto run = outerFunc();
    run();
    return 0;
}