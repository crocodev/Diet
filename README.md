Diet
====

##Задачи:
1. Продумать оповещения, показываемые пользователю **(Ники, Ди)**. 
2. ~~Отрисовка дизайна приложения **(Ди)**.~~
3. ~~Проанализировать механику перехода пользователя по всем экранам, выявить ошибки работы или недочеты **(Ники, Ди)**.~~
5. ~~Разделение задач по написанию кода приложения **(Ники, Ди)**.~~
6. Болванка приложения **(Ди)**.
7. Стартовый экран **(Ди)**.
8. Написание класса движка приложения **(Ники)**.
9. Экран аналитики **(Ники)**.

##Вопросы:
1. Нужно ли акцентировать на кремле? **Нет**
2. Переход между этапами ручной или авто? **Ручной с предложением перейти на новый этап**
3. Название у.е., очки, углеводы? **Очки**
4. Что если пропустить день и не вводить данные? **Нотификации о необходимости пользоваться приложением**
5. Как корректировать введенные ошибочно данные? **Кнопка редактирования с переходом на подэкран редактирования**
6. Использовать усредненные данные для блюд? **Да**
7. Что за ограничение 40 оч/день?
8. Что происходит в случае превышения дневной нормы очков?
9. Как осуществить навигацию по таблице очков блюд?

##Учесть:
1. В описании необходимо указать что приложение носит рекомендательный характер.
2. Настройки -> удалить/вернкть запись из лога.
3. Перерисовать человечка на весах.
4. Нажатие на номер этапа выводит контекстное меню перехода на другой этап.
5. Убрать минус.
6. Сделать секции в таблице блюд (+избранное).
7. Переход по подэкранам главного экрана осуществлять посредством свайпа по эконкам.

##Алгоритм диеты
№ этапа | Длительность | Дневная норма очков | Оповещения
--------|--------|--------|--------
1 | 2 недели | 20 |  Превышение дневной нормы очков.
2 | 3-5 кг до целевого веса |  += 5 оч/нед |  Слишклм большая скорость сброса веса.  Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков.
3 | достижение целевого веса или точка баланса | += 10 оч/нед | Слишклм большая скорость сброса веса.  Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков. Необходлимо вернуться к предидущемму этапу.
4 | - | <= точки баланса | Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков.

Программа предусатривает разные ограницчения по блюдам на разных этапах.

##Необходимые функции приложения:
1. Добавление веса.
2. Вычитание очков.
3. График изменения веса, очков, комбинированный, аналитика.
4. Справочная информация по этапу и самой диете.
5. Подсказка о необходимости изменения физических нагрузок и др.
6. Напоминание о необходимости регулярно использовать приложение.
7. Примеры меню.
8. Таблица очков блюд.
9. Переход между этапами диеты.
10. Ачивки и цитаты великих людей.
11. Входные параметры (вес, целевой вес, мера веса).
12. Вывод цели этапа.
13. Составление своего меню.
14. Отправка меню на почту.
15. Интеллектуальное распознание вводимых данных.
16. Notification center



