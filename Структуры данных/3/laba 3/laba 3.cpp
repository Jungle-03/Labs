#include <iostream>
#include <ctime>
#include <cstdlib>
#include <algorithm>
#include <vector>
#include <locale.h>

using namespace std;

// Функция для генерации случайного массива чисел
void generateRandomArray(vector<int>& arr, int N) {
    for (int i = 0; i < N; i++) {
        arr.push_back(rand() % 1000); // Генерируем случайные числа от 0 до 999
    }
}

// Функция для вывода массива
void printArray(const vector<int>& arr) {
    for (int num : arr) {
        cout << num << " ";
    }
    cout << endl;
}

// Функция для измерения времени сортировки и сортировки массива пузырьковой сортировкой
void bubbleSort(vector<int>& arr) {
    clock_t start = clock();
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
    clock_t end = clock();
    double elapsed_time = double(end - start) / CLOCKS_PER_SEC;
    cout << "Пузырьковая сортировка: " << elapsed_time << " секунд" << endl;
}

// Функция для измерения времени сортировки и сортировки массива сортировкой вставкой
void insertionSort(vector<int>& arr) {
    clock_t start = clock();
    int n = arr.size();
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
    clock_t end = clock();
    double elapsed_time = double(end - start) / CLOCKS_PER_SEC;
    cout << "Сортировка вставкой: " << elapsed_time << " секунд" << endl;
}

// Функция для измерения времени сортировки и сортировки массива сортировкой выбора
void selectionSort(vector<int>& arr) {
    clock_t start = clock();
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        int min_index = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[min_index]) {
                min_index = j;
            }
        }
        swap(arr[i], arr[min_index]);
    }
    clock_t end = clock();
    double elapsed_time = double(end - start) / CLOCKS_PER_SEC;
    cout << "Сортировка выбором: " << elapsed_time << " секунд" << endl;
}

// Функция для измерения времени сортировки и сортировки массива быстрой сортировкой
void quickSort(vector<int>& arr) {
    clock_t start = clock();
    sort(arr.begin(), arr.end());
    clock_t end = clock();
    double elapsed_time = double(end - start) / CLOCKS_PER_SEC;
    cout << "Быстрая сортировка: " << elapsed_time << " секунд" << endl;
}

int main() {
    setlocale(LC_ALL, "ru");

    int N;
    cout << "Введите число N: ";
    cin >> N;

    vector<int> A;
    generateRandomArray(A, N);

    cout << "Исходный массив A: ";
    printArray(A);

    vector<int> B = A;
    vector<int> C = A;
    vector<int> D = A;
    vector<int> E = A;

    bubbleSort(B);
    cout << "Отсортированный массив B: ";
    printArray(B);

    insertionSort(C);
    cout << "Отсортированный массив C: ";
    printArray(C);

    selectionSort(D);
    cout << "Отсортированный массив D: ";
    printArray(D);

    quickSort(E);
    cout << "Отсортированный массив E: ";
    printArray(E);

    return 0;
}
