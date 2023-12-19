#include <iostream>
#include <vector>
#include <algorithm>
#include <set>
#include <locale.h>

using namespace std;

// Задача 1: Максимальная сумма чека
pair<vector<int>, int> maximizeTotalPrice(const vector<int>& prices) {
    vector<int> sortedPrices = prices;
    sort(sortedPrices.rbegin(), sortedPrices.rend());

    vector<int> order;
    int totalSum = 0;
    for (int i = 0; i < sortedPrices.size(); i++) {
        if (i % 2 == 0) {
            totalSum += sortedPrices[i];
        }
        order.push_back(sortedPrices[i]);
    }

    return make_pair(order, totalSum);
}

// Задача 2: Количество призеров
int countPrizeWinners(const vector<int>& results) {
    set<int> uniqueResults(results.begin(), results.end());
    int count = 0;

    for (int result : uniqueResults) {
        if (result >= 7) { // Условие для призера
            count++;
        }
    }

    return count;
}

int main() {
    setlocale(LC_ALL, "ru");

    // Задача 1: Максимальная сумма чека
    int N;
    cout << "Введите количество товаров (N): ";
    cin >> N;

    vector<int> prices(N);
    cout << "Введите цены товаров:\n";
    for (int i = 0; i < N; i++) {
        cin >> prices[i];
    }

    pair<vector<int>, int> result1 = maximizeTotalPrice(prices);
    cout << "Порядок пробивания на кассе: ";
    for (int item : result1.first) {
        cout << item << " ";
    }
    cout << "\nМаксимальная сумма чека: " << result1.second << endl;

    // Задача 2: Количество призеров
    int M;
    cout << "Введите количество участников (M): ";
    cin >> M;

    vector<int> results(M);
    cout << "Введите баллы участников:\n";
    for (int i = 0; i < M; i++) {
        cin >> results[i];
    }

    int result2 = countPrizeWinners(results);
    cout << "Количество призеров: " << result2 << endl;

    return 0;
}
