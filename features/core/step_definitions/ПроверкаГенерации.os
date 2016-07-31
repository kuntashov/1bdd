﻿#Использовать logos

#Использовать "../../.."

Перем Лог;

Перем БДД;

Перем ВременныйКаталогФичи;
Перем ФайлИсходнойФичи;
Перем ФайлФичи;
Перем СохраненныеПараметрыКоманднойСтроки;

Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯПодготовилТестовыйКаталогДляФич");
	ВсеШаги.Добавить("ЯПодготовилСпециальнуюТестовуюФичу");
	ВсеШаги.Добавить("УстановилТестовыйКаталогКакТекущий");
	ВсеШаги.Добавить("ЯЗапустилГенерациюШаговФичи");
	ВсеШаги.Добавить("ЯЗапустилГенерациюШаговФичиСПередачейПараметра");
	ВсеШаги.Добавить("ЯПолучилСгенерированныйOs_ФайлВОжидаемомКаталоге");
	ВсеШаги.Добавить("ЯНеПолучилСгенерированныйOs_ФайлВОжидаемомКаталоге");
	ВсеШаги.Добавить("ПроверкаПоведенияФичиЗакончиласьСКодомВозврата");
	ВсеШаги.Добавить("ЯПодставилФайлШаговСУжеРеализованнымиШагамиДляФичи");
	ВсеШаги.Добавить("ЯЗапустилВыполнениеФичиСПередачейПараметра");
	ВсеШаги.Добавить("ЯСоздалФайлФичиСТекстом");
	ВсеШаги.Добавить("ЯСоздалФайлСТекстом");
	ВсеШаги.Добавить("ЯСоздалЕщеОдинКаталог");
	ВсеШаги.Добавить("УстановилКаталогКакТекущий");
	ВсеШаги.Добавить("ЯЗапустилВыполнениеФичи");
	ВсеШаги.Добавить("ПроверкаПоведенияФичСПередачейПараметраИзКаталогаЗакончиласьСКодомВозврата");

	Возврат ВсеШаги;
КонецФункции

Функция ИмяЛога() Экспорт
	Возврат "bdd.ПроверкаГенерации.feature";
КонецФункции

Процедура Инициализация() Экспорт
	СохраненныеПараметрыКоманднойСтроки = "";
КонецПроцедуры

//я подготовил тестовый каталог для фич
Процедура ЯПодготовилТестовыйКаталогДляФич() Экспорт
	Инициализация();

	ВременныйКаталогФичи = Новый Файл(ВременныеФайлы.СоздатьКаталог());
	Лог.Отладка("Использую временный каталог "+ВременныйКаталогФичи.ПолноеИмя);
КонецПроцедуры

//я подготовил специальную тестовую фичу "ПередачаПараметров"
Процедура ЯПодготовилСпециальнуюТестовуюФичу(Знач ИмяФичи) Экспорт

	ФайлИсходнойФичи = ПолучитьФайлИсходнойФичи(ИмяФичи);

	ПодготовитьТестовыйКаталогСФичей(ФайлИсходнойФичи);

	ФайлФичи = ПолучитьТестовыйФайлФичи(ИмяФичи);
	Лог.Отладка("Подготовлена тестовая фича "+ФайлФичи.ПолноеИмя);
КонецПроцедуры

//я запустил генерацию шагов фичи "ПередачаПараметров" с передачей параметра "-require lib"
Процедура ЯЗапустилГенерациюШаговФичиСПередачейПараметра(Знач ИмяФичи, Знач ПараметрыКоманднойСтроки) Экспорт
	
	ПутьИсполнителяБДД = ОбъединитьПути(ПолучитьКаталогИсходников(), "bdd.os");
	ФайлИсполнителя = Новый Файл(ПутьИсполнителяБДД);
	Ожидаем.Что(ФайлИсполнителя.Существует(), "Ожидаем, что скрипт исполнителя шагов существует, а его нет. "+ФайлИсполнителя.ПолноеИмя).Равно(Истина);

	ФайлФичиИлиКаталога = Новый Файл(ОбъединитьПути(ТекущийКаталог(), ИмяФичи + ".feature"));

	СтрокаКоманды = СтрШаблон("oscript.exe %4 %1 gen %2 %3", ПутьИсполнителяБДД, ФайлФичиИлиКаталога.ПолноеИмя, 
	ПараметрыКоманднойСтроки, "-encoding=utf-8");

	ТекстФайла = "";
	КодВозврата = ВыполнитьПроцесс(СтрокаКоманды, ТекстФайла);

	БДД.СохранитьВКонтекст("ТекстЛогФайлаПродукта", ТекстФайла);

	Если КодВозврата <> 0 ИЛИ СтрНайти(ПараметрыКоманднойСтроки, "-verbose on") <> 0 Тогда
		ВывестиТекст(ТекстФайла);
		Ожидаем.Что(КодВозврата, "Ожидаем, что код возврата равен 0, а это не так").Равно(0);
	КонецЕсли;

КонецПроцедуры

//я запустил генерацию шагов фичи "ПередачаПараметров"
Процедура ЯЗапустилГенерациюШаговФичи(Знач ИмяФичи) Экспорт
	ЯЗапустилГенерациюШаговФичиСПередачейПараметра(ИмяФичи, "");
КонецПроцедуры

//я получил сгенерированный os-файл "ФичаБезШагов" в ожидаемом каталоге
Процедура ЯПолучилСгенерированныйOs_ФайлВОжидаемомКаталоге(Знач ИмяФичи) Экспорт
	ФайлШагов = Новый Файл(ОбъединитьПути(ТекущийКаталог(), "step_definitions", ИмяФичи+".os"));
	Ожидаем.Что(ФайлШагов.Существует(), "Ожидаем, что файл исполнителя шагов существует, а его нет. "+ФайлШагов.ПолноеИмя).Равно(Истина);
КонецПроцедуры

//я не получил сгенерированный os-файл "ФичаБезШагов" в ожидаемом каталоге
Процедура ЯНеПолучилСгенерированныйOs_ФайлВОжидаемомКаталоге(Знач ИмяФичи) Экспорт
	ФайлШагов = Новый Файл(ОбъединитьПути(ТекущийКаталог(), "step_definitions", ИмяФичи+".os"));
	Ожидаем.Что(ФайлШагов.Существует(), "Ожидаем, что файл исполнителя шагов не существует, а он есть. "+ФайлШагов.ПолноеИмя).Равно(Ложь);
КонецПроцедуры

//проверка поведения фичи "ПередачаПараметров" закончилась со статусом "НеРеализован"
Процедура ПроверкаПоведенияФичиЗакончиласьСоСтатусом(Знач ИмяФичи, Знач ОжидаемыйСтатусВыполненияСтрока) Экспорт
	ИсполнительБДД = Новый ИсполнительБДД;

	ОжидаемыйСтатусВыполнения = ИсполнительБДД.ВозможныеСтатусыВыполнения()[ОжидаемыйСтатусВыполненияСтрока];

	РезультатыВыполнения = ИсполнительБДД.ВыполнитьФичу(ФайлФичи);

	Ожидаем.Что(РезультатыВыполнения, "Ожидали, что дерево фич будет получено как дерево значений, а это не так").ИмеетТип("ДеревоЗначений");

	Функциональность0 = РезультатыВыполнения.Строки[0];
	СообщениеОбОшибке = СтрШаблон("Ожидали, что статус выполнения Функциональность0 будет %1, а это не так", ОжидаемыйСтатусВыполнения);
	Ожидаем.Что(Функциональность0.СтатусВыполнения, СообщениеОбОшибке).Равно(ОжидаемыйСтатусВыполнения);

КонецПроцедуры

//проверка поведения фичи "ПередачаПараметров" закончилась с кодом возврата 1
Процедура ПроверкаПоведенияФичиЗакончиласьСКодомВозврата(Знач ИмяФичи, Знач ОжидаемыйКодВозврата) Экспорт
	ПроверитьПоведениеФичиИлиКаталога(ИмяФичи, "", ОжидаемыйКодВозврата);
КонецПроцедуры

//проверка поведения фич с передачей параметра "" из каталога "." закончилась с кодом возврата 0
Процедура ПроверкаПоведенияФичСПередачейПараметраИзКаталогаЗакончиласьСКодомВозврата(Знач ПараметрыКоманднойСтроки, Знач ПутьКаталога, Знач ОжидаемыйКодВозврата) Экспорт
	ПроверитьПоведениеФичиИлиКаталога(ПутьКаталога, ПараметрыКоманднойСтроки, ОжидаемыйКодВозврата);
КонецПроцедуры

Процедура ПроверитьПоведениеФичиИлиКаталога(Знач ИмяФичиИлиПутьКаталога, Знач ПараметрыКоманднойСтроки, ОжидаемыйКодВозврата)
	Если ИмяФичиИлиПутьКаталога = "КаталогТестовыйПолный" Тогда
		ИмяФичиИлиПутьКаталога = ВременныйКаталогФичи.ПолноеИмя;
	ИначеЕсли ИмяФичиИлиПутьКаталога = "КаталогТестовыйОтносительный" Тогда
		ИмяФичиИлиПутьКаталога = ОбъединитьПути("..", ВременныйКаталогФичи.Имя);
	КонецЕсли;

	ПутьИсполнителяБДД = ОбъединитьПути(ПолучитьКаталогИсходников(), "bdd.os");
	ФайлИсполнителя = Новый Файл(ПутьИсполнителяБДД);
	Ожидаем.Что(ФайлИсполнителя.Существует(), "Ожидаем, что скрипт исполнителя шагов существует, а его нет. "+ФайлИсполнителя.ПолноеИмя).Равно(Истина);

	ФайлФичиИлиКаталога = Новый Файл(ИмяФичиИлиПутьКаталога);
	Если Не ФайлФичиИлиКаталога.Существует() Тогда
		ФайлФичиИлиКаталога = Новый Файл(ИмяФичиИлиПутьКаталога + ".feature");
	КонецЕсли;

	СтрокаКоманды = СтрШаблон("oscript.exe %4 %1 %2 %3 %5", ПутьИсполнителяБДД, ФайлФичиИлиКаталога.ПолноеИмя,
	СохраненныеПараметрыКоманднойСтроки, "-encoding=utf-8");

	ТекстФайла = "";
	КодВозврата = ВыполнитьПроцесс(СтрокаКоманды, ТекстФайла);

	БДД.СохранитьВКонтекст("ТекстЛогФайлаПродукта", ТекстФайла);

	Если КодВозврата <> ОжидаемыйКодВозврата ИЛИ СтрНайти(ПараметрыКоманднойСтроки, "-verbose on") <> 0 Тогда
		ВывестиТекст(ТекстФайла);
		Ожидаем.Что(КодВозврата, "Код возврата в ПроверитьПоведениеФичиИлиКаталога").Равно(ОжидаемыйКодВозврата);
	КонецЕсли;
КонецПроцедуры

Функция ВыполнитьПроцесс(Знач СтрокаВыполнения, ТекстВывода, Знач КодировкаПотока = Неопределено)
	Перем ПаузаОжиданияЧтенияБуфера;
	
	ПаузаОжиданияЧтенияБуфера = 10;
	МаксСчетчикЦикла = 100000;
	
	Если КодировкаПотока = Неопределено Тогда
		КодировкаПотока = КодировкаТекста.UTF8;
	КонецЕсли;
    Лог.Отладка("СтрокаКоманды "+СтрокаВыполнения);
	Процесс = СоздатьПроцесс(СтрокаВыполнения, ТекущийКаталог(), Истина,Истина, КодировкаПотока);
    Процесс.Запустить();
	
	ТекстВывода = "";
	Счетчик = 0; 
	
	Пока Не Процесс.Завершен Цикл 
		Текст = Процесс.ПотокВывода.Прочитать();
		Лог.Отладка("Цикл ПотокаВывода "+Текст);
		Если Текст = Неопределено ИЛИ ПустаяСтрока(Текст)  Тогда 
			Прервать;
		КонецЕсли;
		ТекстВывода = ТекстВывода + Текст;

		Счетчик = Счетчик + 1;
		Если Счетчик > МаксСчетчикЦикла Тогда 
			Прервать;
		КонецЕсли;
		
		sleep(ПаузаОжиданияЧтенияБуфера);		
	КонецЦикла;
	
	Процесс.ОжидатьЗавершения();
    
	Текст = Процесс.ПотокВывода.Прочитать();
	ТекстВывода = ТекстВывода + Текст;
	Лог.Отладка(ТекстВывода);

	Возврат Процесс.КодВозврата;
КонецФункции

//я запустил выполнение фичи "ФичаБезШагов" с передачей параметра "-require СтруктураСценария.feature"
Процедура ЯЗапустилВыполнениеФичиСПередачейПараметра(Знач ИмяФичи, Знач ПараметрыКоманднойСтроки) Экспорт
	СохраненныеПараметрыКоманднойСтроки = ПараметрыКоманднойСтроки;
КонецПроцедуры

//я запустил выполнение фичи "ПередачаПараметров"
Процедура ЯЗапустилВыполнениеФичи(Знач ИмяФичи) Экспорт
	СохраненныеПараметрыКоманднойСтроки = "";
КонецПроцедуры

//я подставил файл шагов с уже реализованными шагами для фичи "ПередачаПараметров"()
Процедура ЯПодставилФайлШаговСУжеРеализованнымиШагамиДляФичи(Знач ИмяФичи) Экспорт
	ИмяИсполнителяШагов = ФайлИсходнойФичи.ИмяБезРасширения+ ".os";
	ИсходныйФайлИсполнителяШагов = Новый Файл(ОбъединитьПути(ФайлИсходнойФичи.Путь, "step_definitions", ИмяИсполнителяШагов ));
	ФайлИсполнителяШагов = Новый Файл(ОбъединитьПути(ФайлФичи.Путь, "step_definitions", ИмяИсполнителяШагов ));

	Если ФайлИсполнителяШагов.Существует() Тогда
		УдалитьФайлы(ФайлИсполнителяШагов.ПолноеИмя);
	КонецЕсли;
	КопироватьФайл(ИсходныйФайлИсполнителяШагов.ПолноеИмя, ФайлИсполнителяШагов.ПолноеИмя);
КонецПроцедуры

//установил тестовый каталог как текущий
Процедура УстановилТестовыйКаталогКакТекущий() Экспорт
	УстановитьТекущийКаталог(ВременныйКаталогФичи.ПолноеИмя);
КонецПроцедуры

//я создал еще один каталог "lib"
Процедура ЯСоздалЕщеОдинКаталог(Знач ИмяКаталога) Экспорт
	СоздатьКаталог(ОбъединитьПути(ВременныйКаталогФичи.ПолноеИмя, ИмяКаталога));
КонецПроцедуры

//установил каталог "lib" как текущий
Процедура УстановилКаталогКакТекущий(Знач ИмяКаталога) Экспорт
	УстановитьТекущийКаталог(ОбъединитьПути(ВременныйКаталогФичи.ПолноеИмя, ИмяКаталога));
КонецПроцедуры


//я создал файл "ПустойСкрипт.os" с текстом
//"""
//// Пустой скрипт
//"""
Процедура ЯСоздалФайлСТекстом(Знач ПутьФайла, Знач ТексФайла) Экспорт
	ЗаписьФайла = Новый ЗаписьТекста(ОбъединитьПути(ТекущийКаталог(), ПутьФайла), "utf-8");

	Для Счетчик = 1 По СтрЧислоСтрок(ТексФайла) Цикл
		Строка = СтрПолучитьСтроку(ТексФайла, Счетчик);
		ЗаписьФайла.ЗаписатьСтроку(Строка);
		//Лог.Отладка("Записываю в файл шагов ----- "+Строка);
	КонецЦикла;

	ЗаписьФайла.Закрыть();
КонецПроцедуры

//я создал файл фичи "ФичаБезШагов" с текстом
//"""
//# language: ru
//Функционал: Библиотечные шаги
//Сценарий: Использование шагов из другой фичи
//	Когда я передаю параметр "Минимальный"
//	Тогда я получаю параметр "Минимальный"
//"""
Процедура ЯСоздалФайлФичиСТекстом(Знач ИмяФичи, Знач ТекстФичи) Экспорт
	ЯСоздалФайлСТекстом(ПутьВоВременномКаталоге(ИмяФичи + ".feature"), ТекстФичи);
КонецПроцедуры

Функция ПолучитьТестовыйФайлФичи(ИмяФичи)
	ФайлТекущегоКаталога = Новый Файл(ТекущийКаталог());
	ФайлФичи = Новый Файл(ОбъединитьПути(ФайлТекущегоКаталога.ПолноеИмя, ИмяФичи+".feature"));
	Возврат ФайлФичи;
КонецФункции

// TODO дубль метода с несколькими тестовыми файлами
Процедура ПодготовитьТестовыйКаталогСФичей(ФайлИсходнойФичи)
	ФайлТекущегоКаталога = Новый Файл(ТекущийКаталог());

	КопироватьФайл(ФайлИсходнойФичи.ПолноеИмя, ОбъединитьПути(ФайлТекущегоКаталога.ПолноеИмя, ФайлИсходнойФичи.Имя ));

	ИмяИсполнителяШагов = ФайлИсходнойФичи.ИмяБезРасширения+ ".os";
	КаталогИсполнителяШагов = ОбъединитьПути(ФайлТекущегоКаталога.ПолноеИмя, "step_definitions" );
	СоздатьКаталог(КаталогИсполнителяШагов);

	ФайлИсполнителяШагов = Новый Файл(ОбъединитьПути(КаталогИсполнителяШагов, ИмяИсполнителяШагов ));

	Ожидаем.Что(ФайлИсполнителяШагов.Существует(), "Ожидаем, что файл исполнителя шагов не существует, а он есть. "+ФайлИсполнителяШагов.ПолноеИмя).Равно(Ложь);
КонецПроцедуры

Функция ПолучитьТекстФайла(Знач ИмяФайла, Знач Кодировка = Неопределено)

	Файл = Новый Файл(ИмяФайла);
	Если НЕ Файл.Существует() Тогда
		Лог.Информация("Не существует лог-файл <"+ИмяФайла+">");
		Возврат "";
	КонецЕсли;

	Если Кодировка = Неопределено Тогда
		Кодировка = "utf-8";
	КонецЕсли;

	ЧТ = Новый ЧтениеТекста(ИмяФайла, Кодировка);
	СтрокаФайла = ЧТ.Прочитать();
	ЧТ.Закрыть();

	Возврат СтрокаФайла;

КонецФункции

Процедура ВывестиТекст(Знач Строка)

	Лог.Информация("");
	Лог.Информация("  ----------------    ----------------    ----------------  ");
	Лог.Информация( Строка );
	Лог.Информация("  ----------------    ----------------    ----------------  ");
	Лог.Информация("");

КонецПроцедуры

Функция СуффиксПеренаправленияВывода(Знач ИмяФайлаПриемника, Знач УчитыватьStdErr = Истина)
	Возврат "> """ + ИмяФайлаПриемника + """" + ?(УчитыватьStdErr, " 2>&1", "");
КонецФункции

Функция ПолучитьКаталогИсходников() Экспорт
	КаталогПроекта = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..", "..");
	Возврат ОбъединитьПути(КаталогПроекта, "src");
КонецФункции // ПолучитьКаталогИсходников()

Функция ПолучитьФайлИсходнойФичи(Знач ИмяФичи)
	Возврат Новый Файл(ОбъединитьПути(ТекущийСценарий().Каталог, "..", ИмяФичи+".feature"));
КонецФункции // ПолучитьФайлИсходнойФичи()

Функция ПутьВоВременномКаталоге(Знач ИмяФайла)
	Возврат ОбъединитьПути(ВременныйКаталогФичи.ПолноеИмя, ИмяФайла);
КонецФункции // ПутьВоВременномКаталоге(ИмяФайла)

Лог = Логирование.ПолучитьЛог(ИмяЛога());
Лог.УстановитьУровень(Логирование.ПолучитьЛог("bdd").Уровень());
СохраненныеПараметрыКоманднойСтроки = "";
