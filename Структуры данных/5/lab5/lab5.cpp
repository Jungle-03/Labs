#include <iostream>
#include <stack>
#include <locale.h>

using namespace std;

bool areBracketsBalanced(const string& expression) {
    stack<char> s;

    for (char ch : expression) {
        if (ch == '(' || ch == '[' || ch == '{') {
            s.push(ch);
        }
        else if (ch == ')' || ch == ']' || ch == '}') {
            if (s.empty()) {
                return false; // Закрывающая скобка без соответствующей открывающей
            }
            char openBracket = s.top();
            s.pop();
            if ((ch == ')' && openBracket != '(') ||
                (ch == ']' && openBracket != '[') ||
                (ch == '}' && openBracket != '{')) {
                return false; // Несоответствие открывающей и закрывающей скобок
            }
        }
    }

    return s.empty(); // Все скобки должны быть закрыты
}

int main() {
    setlocale(LC_ALL, "ru");

    string expression;
    cout << "Введите строку с символами и скобками: ";
    cin >> expression;

    if (areBracketsBalanced(expression)) {
        cout << "Скобки расставлены верно" << endl;
    }
    else {
        cout << "Скобки расставлены не верно" << endl;
    }

    return 0;
}
