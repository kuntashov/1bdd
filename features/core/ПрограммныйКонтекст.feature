# language: ru

Функционал: Использование программного контекста
	Как Разработчик
	Я Хочу чтобы шаги разных сценариев могли обмениваться данными через програмнный контекст продукта

Сценарий: Первый сценарий

  Когда Я сохранил ключ "Ключ1" и значение 10 в программном контексте
  И я получаю ключ "Ключ1" и значение 10 из программного контекста

Сценарий: Следующий сценарий

  Тогда я получаю ключ "Ключ1" и значение 10 из программного контекста
