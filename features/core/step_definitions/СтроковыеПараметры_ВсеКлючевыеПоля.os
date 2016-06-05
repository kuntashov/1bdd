﻿Перем БДД;
Перем Журнал;
Перем КлючЖурнала;

Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯНичегоНеДелаю");
	ВсеШаги.Добавить("НичегоНеПроисходит");
	ВсеШаги.Добавить("ВсеПутемИ");
	ВсеШаги.Добавить("НиктоНичегоНеДелает");

	Возврат ВсеШаги;
КонецФункции

Процедура ЯНичегоНеДелаю(ПарамСтрока) Экспорт
	ДобавитьВЖурнал("ЯНичегоНеДелаю", ПарамСтрока);
КонецПроцедуры

Процедура НичегоНеПроисходит(ДругойПарамСтрока) Экспорт
	ДобавитьВЖурнал("НичегоНеПроисходит", ДругойПарамСтрока);
КонецПроцедуры

Процедура ВсеПутемИ(Парам1, Парам2) Экспорт
	ДобавитьВЖурнал("ВсеПутемИ", Парам1, Парам2);
КонецПроцедуры

Процедура НиктоНичегоНеДелает(Парам1) Экспорт
	ДобавитьВЖурнал("НиктоНичегоНеДелает", Парам1);
КонецПроцедуры

Процедура ДобавитьВЖурнал(Строка, Параметр = "", Параметр2 = "") Экспорт
	Журнал.Вставить(КлючЖурнала, Журнал[КлючЖурнала]+Строка+ПредставлениеПараметра(Параметр)+ПредставлениеПараметра(Параметр2)+";");
КонецПроцедуры

Функция ПредставлениеПараметра(Параметр)
	Возврат ?(ПустаяСтрока(Параметр), "", "<"+Параметр+">");
КонецФункции

КлючЖурнала = (Новый Файл(ТекущийСценарий().Источник)).ИмяБезРасширения;
Журнал = Новый Соответствие;
Журнал.Вставить(КлючЖурнала, "");
