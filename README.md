Diet
====

##Задачи:
1. Проанализировать механику перехода пользователя по всем экранам, выявить ошибки работы или недочеты.
2. Продумать оповещения пользователя. 
3. Разработка дизайна приложения.
4. Разработка класса движка приложения.
5. Реализации приложения.

##Алгоритм диеты
№ этапа | Длительность | Дневная норма очков | Оповещения
--------|--------|--------|--------
1 | 2 недели | 20 |  Превышение дневной нормы очков.
2 | 3-5 кг до целевого веса |  += 5 оч/нед |  Слишклм большая скорость сброса веса.  Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков.
3 | достижение целевого веса или точка баланса | += 10 оч/нед | Слишклм большая скорость сброса веса.  Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков. Необходлимо вернуться к предидущемму этапу.
4 | - | <= точки баланса | Превышение дневной нормы очков. Необходимо уменьшить дневную норму очков.

Программа предусатривает ограницчения по блюдам на разных этапах программы.

##Необходимые функции приложения:
1. Добавление веса
2. Вычитание очков
3. График изменения веса, очков, комбинированный, аналитика
4. Справочная информация по этапу и самой диете
5. Подсказка о необходимости изменения физических нагрузок и др.
6. Напоминание о необходимости регулярно использовать приложение
7. Примеры меню
8. Таблица очков блюд
9. Переход между этапами диеты
10. Ачивки и цитаты великих людей
11. Входные параметры (пол, вес, целевой вес, мера веса)
12. Вывод цели этапа
13. Составление своего меню
14. Отправка меню на почту
15. Интеллектуальное распознание вводимых данных

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
1. В описании необходимо отразить что приложение носит рекомендательный характер

