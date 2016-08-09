# language: ru

Функционал: Вызов сценария, в реализации шага которого есть синтакс-ошибка
	Как Разработчик
	Я Хочу получать ошибки при загрузке неверных файлов-реализаций шагов
    Чтобы ускорить поиск ошибок при разработке шагов

Контекст: Использование каталог тестовых фич
	Допустим установил каталог проекта "tests\fixtures" как текущий

Сценарий: Вызов шага, в реализации которого есть синтакс-ошибка

	Тогда  проверка поведения фичи "СинтаксическиОшибочныйШаг" с передачей параметра "-verbose off" закончилась с кодом возврата 1
	И в лог-файле запуска продукта есть строка "специальная синтакс-ошибка для получения бага"
	И в лог-файле запуска продукта есть строка "1 Сценарий ( 0 Пройден, 1 Не реализован, 0 Сломался, 0 Не выполнялся )"
	И в лог-файле запуска продукта есть строка "1 Шаг ( 0 Пройден, 1 Не реализован, 0 Сломался, 0 Не выполнялся )"

