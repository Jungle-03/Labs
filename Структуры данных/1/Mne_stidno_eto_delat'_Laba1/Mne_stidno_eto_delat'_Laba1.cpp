#include <iostream>
#include <chrono>

using namespace std;
using namespace std::chrono;

// Рекурсивный способ вычисления чисел Фибоначчи
int fibonacciRecursion(int n) {
    if (n <= 1) {
        return n;
    }
    return fibonacciRecursion(n - 1) + fibonacciRecursion(n - 2);
}

// Линейный способ вычисления чисел Фибоначчи
int fibonacciLinear(int n) {
    if (n <= 1) {
        return n;
    }
    int fib1 = 0, fib2 = 1, fib;
    for (int i = 2; i <= n; ++i) {
        fib = fib1 + fib2;
        fib1 = fib2;
        fib2 = fib;
    }
    return fib2;
}

int main() {

    setlocale(LC_ALL, "ru");

    int n;
    cout << "Введите число N: ";
    cin >> n;

    // Вычисление числа Фибоначчи с помощью рекурсии
    high_resolution_clock::time_point t1 = high_resolution_clock::now();
    int resultRecursion = fibonacciRecursion(n);
    high_resolution_clock::time_point t2 = high_resolution_clock::now();
    duration<double> timeRecursion = duration_cast<duration<double>>(t2 - t1);

    // Вычисление числа Фибоначчи с помощью линейного метода
    t1 = high_resolution_clock::now();
    int resultLinear = fibonacciLinear(n);
    t2 = high_resolution_clock::now();
    duration<double> timeLinear = duration_cast<duration<double>>(t2 - t1);

    cout << "N-ое число Фибоначчи (рекурсия): " << resultRecursion << endl;
    cout << "Расчетное время рекурсией: " << timeRecursion.count() << " секунд" << endl;

    cout << "N-ое число Фибоначчи (цикл): " << resultLinear << endl;
    cout << "Расчетное время циклом: " << timeLinear.count() << " секунд" << endl;

    return 0;
}
