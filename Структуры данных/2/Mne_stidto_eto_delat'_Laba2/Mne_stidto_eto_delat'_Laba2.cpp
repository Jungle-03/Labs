#include <iostream>
#include <vector>

int main() {
    setlocale(LC_ALL, "ru");
    using namespace std;
    int N;
    std::cout << "Введите число N: ";
    std::cin >> N;

    int low = 1; // Нижняя граница
    int high = N; // Верхняя граница
    int steps = 0; // Счетчик шагов
    std::vector<int> search_steps;

    while (low <= high) {
        int guess = (low + high) / 2;
        steps++;
        search_steps.push_back(guess);

        int answer;
        while (true) {
            std::cout << "Это число " << guess << "? (мало - 1 / много - 2 / угадал -3 ): ";
            std::cin >> answer;
            if (answer == 1 || answer == 2 || answer == 3) {
                break;
            }
            std::cout << "Пожалуйста, введите один из ответов: 'мало - 1', 'много - 2' или 'угадал - 2'." << std::endl;
        }

        if (answer == 3) {
            std::cout << "Максимальное количество шагов = " << steps << std::endl;
            std::cout << "Шаги бинарного поиска: ";
            for (int step : search_steps) {
                std::cout << step << " ";
            }
            std::cout << std::endl;
            break;
        }
        else if (answer == 1) {
            low = guess + 1;
        }
        else if (answer == 2) {
            high = guess - 1;
        }
    }

    return 0;
}
