# Анализ потоков данных (DFA)

## Цепочки Def-Use для переменных:

* **status**:
* Def: строка 5 (`status = "approved"`)
* Use: строка 10 (`"Transaction finished with status: " + status`), строка 15 (`return status`)

* **log_entry**:
* Def: строка 2 (`log_entry = "Start processing"`), строка 10 (`log_entry = "Transaction finished with status: " + status`)
* Use: строка 13 (`file.write(log_entry)`)

* **balance**:
* Def: строка 6 (`balance = get_balance(user_id)`)
* Use: строка 7 (`new_balance = balance - amount`)

* **new_balance**:
* Def: строка 7 (`new_balance = balance - amount`)
* Use: строка 8 (`update_balance(user_id, new_balance)`)

* **file**:
* Def: строка 12 (`file = open("audit_log.txt", "w")`)
* Use: строка 13 (`file.write(log_entry)`)

## Выявленные дефекты:
1. **Использование неинициализированной переменной:** Если `amount <= 0`, блок `if` не исполняется и переменная `status` не объявляется. На строке 10 произойдет ошибка `UnboundLocalError`.
2. **Мертвое присваивание (Dead Store):** Присваивание `log_entry = "Start processing"` на строке 2 перезаписывается на строке 10 до первого чтения.
3. **Утечка ресурса (Resource Leak):** Файл открывается через `open()`, но нигде не закрывается (отсутствует `file.close()` или контекстный менеджер `with`).
