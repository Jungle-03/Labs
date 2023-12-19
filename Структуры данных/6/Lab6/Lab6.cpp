#include <iostream>
#include <vector>
#include <climits>

// Определение структуры для хранения данных
struct Contact {
    int phoneNumber;
    std::string name;
};

// Определение класса хэш-таблицы
class HashTable {
private:
    static const int TABLE_SIZE = 16; // Размер хэш-таблицы
    std::vector<std::vector<Contact>> table; // Массив цепочек

    // Простейшая хеш-функция (можно использовать другие хеш-функции)
    int hashFunction(int phoneNumber) {
        return phoneNumber % TABLE_SIZE;
    }

public:
    HashTable() : table(TABLE_SIZE) {}

    // Метод добавления элемента
    void insert(int phoneNumber, const std::string& name) {
        int index = hashFunction(phoneNumber);
        table[index].push_back({ phoneNumber, name });
    }

    // Метод поиска элемента
    Contact* search(int phoneNumber) {
        int index = hashFunction(phoneNumber);
        for (Contact& contact : table[index]) {
            if (contact.phoneNumber == phoneNumber) {
                return &contact;
            }
        }
        return nullptr; // Элемент не найден
    }

    // Метод удаления элемента
    void remove(int phoneNumber) {
        int index = hashFunction(phoneNumber);
        auto& chain = table[index];
        for (auto it = chain.begin(); it != chain.end(); ++it) {
            if (it->phoneNumber == phoneNumber) {
                chain.erase(it);
                return;
            }
        }
    }

    // Метод вывода всей таблицы
    void displayTable() {
        for (int i = 0; i < TABLE_SIZE; ++i) {
            std::cout << "Bucket " << i << ": ";
            for (const Contact& contact : table[i]) {
                std::cout << "[" << contact.phoneNumber << ", " << contact.name << "] ";
            }
            std::cout << std::endl;
        }
    }
};

int main() {
    HashTable phoneBook;

    // Добавление элементов
    phoneBook.insert(5551234567, "John Doe");
    phoneBook.insert(5559876543, "Jane Smith");
    phoneBook.insert(5555555555, "Alice Johnson");

    // Вывод таблицы
    phoneBook.displayTable();

    // Поиск элемента
    Contact* contact = phoneBook.search(5559876543);
    if (contact) {
        std::cout << "Found: " << contact->name << std::endl;
    }
    else {
        std::cout << "Not found" << std::endl;
    }

    // Удаление элемента
    phoneBook.remove(5559876543);
    phoneBook.displayTable();

    return 0;
}
