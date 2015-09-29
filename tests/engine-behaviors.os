﻿///////////////////////////////////////////////////////////////////////
//
// Тест проверки поведения движка
//
///////////////////////////////////////////////////////////////////////

Перем юТест;
Перем глТестоваяПеременная;

////////////////////////////////////////////////////////////////////
// Программный интерфейс

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолженПроверитьИсключенияИдущиеДругЗаДругом");
	ВсеТесты.Добавить("ТестДолжен_ВызватьФункциюКакПроцедуру_Issue104");
	ВсеТесты.Добавить("ТестДолжен_ПрочитатьЛитералДатыСРазделителями");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьПерекрытиеГлобальнойПеременнойВнутриМетода");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьРазыменованияВПравойЧастиВыражения");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьУстановкуЗначенияПоСсылке");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьСокращенноеВычислениеПоИ");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьСокращенноеВычислениеПоИЛИ");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьВычислениеНЕ");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьОператорВопросаПоИстина");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьОператорВопросаПоЛожь");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьМаршаллингУникальныхИдентификаторовИПеречислений");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьВложенностьПробрасываемыхИсключений");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьКомпиляциюОбращенияКВозвращаемомуОбъектуЧерезТочку");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьРаботуФункцииТРег");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтоПараметрОтмеченныйЗнач_НеМеняется");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтоИзФункцииВозвращаютсяРазныеЗначения");
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ТестДолженПроверитьИсключенияИдущиеДругЗаДругом() Экспорт
	ТекстОшибки = "";
	Попытка
		БроситьИсключение(1, 2);
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("внутри исключения (1, 2)");
	КонецПопытки;
	
	юТест.ПроверитьНеравенство("", ТекстОшибки, "Должны были получить текст исключения, но не получили");
	
КонецПроцедуры

Процедура БроситьИсключение(Парам1, Парам2)
	Сообщить("до "+Парам1);
	Попытка
		ВызватьИсключение Парам1;
	Исключение
		ТекстОшибки = ОписаниеОшибки();
		Сообщить("внутри исключения "+Парам1);
	КонецПопытки;

	Сообщить("до "+Парам2);
	ВызватьИсключение Парам2;
КонецПроцедуры

Функция ВызовЛомающийСтек()
    
	Если ЗначениеЗаполнено(0) Тогда
		А = 2;
	КонецЕсли;
	
    Возврат 1;
	
КонецФункции

Функция НекаяФункция()
	ВызовЛомающийСтек();
	Возврат 1;
КонецФункции

Функция ПерекрытаяГлТестоваяПеременная()
	Перем глТестоваяПеременная;
	глТестоваяПеременная = "new";
	Возврат глТестоваяПеременная;
КонецФункции

Процедура ТестДолжен_ВызватьФункциюКакПроцедуру_Issue104() Экспорт
	
	юТест.ПроверитьРавенство(1, НекаяФункция()); // сбой передачи аргумента в метод.
	
КонецПроцедуры

Процедура ТестДолжен_ПрочитатьЛитералДатыСРазделителями() Экспорт
	
	юТест.ПроверитьРавенство('20140101121727', '2014-01-01 12:17:27');
	юТест.ПроверитьРавенство('20140101121727', '2014 год 01 месяц 01 число 12 часов 17 минут 27 секунд');
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьПерекрытиеГлобальнойПеременнойВнутриМетода() Экспорт
	глТестоваяПеременная = 1;
	ПерекрытаяГлТестоваяПеременная = ПерекрытаяГлТестоваяПеременная();
	
	юТест.ПроверитьРавенство(1, глТестоваяПеременная, "Глобальная переменная не должна поменять значение");
	юТест.ПроверитьРавенство("new", ПерекрытаяГлТестоваяПеременная, "Локальная переменная с таким же именем получена корректно");
	
КонецПроцедуры

Функция ФункцияВозвращаетОбъект()
	Возврат Новый Структура;
КонецФункции

Процедура ТестДолжен_ПроверитьРазыменованияВПравойЧастиВыражения() Экспорт

	Объект = Новый Структура("Свойство1",
				Новый Структура("Свойство2",
					Новый Структура("Свойство3", 1)
				)
			);
	А = Объект.Свойство1.Свойство2.Свойство3;
	юТест.ПроверитьРавенство(1, А);
	
	Массив = Новый Массив;
	Массив.Добавить((Объект.Свойство1.Свойство2));
	
	Объект.Свойство1 = Массив;
	Массив[0].Свойство3 = 2;
	юТест.ПроверитьРавенство(2, Объект.Свойство1[0].Свойство3);
	
	Массив[0] = Новый Массив;
	Массив[0].Добавить(0);
	
	юТест.ПроверитьРавенство(0, Массив[0][0]);
	юТест.ПроверитьРавенство(Массив[0], Массив[Массив[0][0]]);

КонецПроцедуры

Процедура ТестДолжен_ПроверитьУстановкуЗначенияПоСсылке() Экспорт
	
	Массив = Новый Массив;
	Массив.Добавить(5);
	ТестоваяПроцедура_УстановитьПоСсылке(Массив[0]);
	юТест.ПроверитьРавенство("НОВОЕЗНАЧЕНИЕ", Массив[0]);
	
	Массив.Добавить(Новый Структура("Свойство1", 7));
	ТестоваяПроцедура_УстановитьПоСсылке(Массив[1].Свойство1);
	юТест.ПроверитьРавенство("НОВОЕЗНАЧЕНИЕ", Массив[1].Свойство1);
	
КонецПроцедуры

Функция ТестоваяПроцедура_УстановитьПоСсылке(Параметр)
	Параметр = "НОВОЕЗНАЧЕНИЕ";
	Возврат Истина;
КонецФункции

Процедура ТестДолжен_ПроверитьСокращенноеВычислениеПоИ() Экспорт
	
	А = 5;
	Если Ложь или Истина и Ложь И ТестоваяПроцедура_УстановитьПоСсылке(А) Тогда
	КонецЕсли;
	
	юТест.ПроверитьРавенство(5, А);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьСокращенноеВычислениеПоИЛИ() Экспорт
	
	А = 5;
	Если Истина или Истина и Ложь или ТестоваяПроцедура_УстановитьПоСсылке(А) Тогда
	КонецЕсли;
	
	юТест.ПроверитьРавенство(5, А);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьВычислениеНЕ() Экспорт
	ТипСтроки = Тип("Строка");
	Операнд = 100;

	Если Не ТипЗнч(Операнд) = ТипСтроки И Ложь Тогда
		ВызватьИсключение "Операция НЕ должна быть выполнена до любого другого логического оператора";
	КонецЕсли;
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьОператорВопросаПоИстина() Экспорт
	А = 5;
	юТест.ПроверитьЛожь(?(Истина,Ложь,ТестоваяПроцедура_УстановитьПоСсылке(А)));
	юТест.ПроверитьРавенство(5, А);
КонецПроцедуры

Процедура ТестДолжен_ПроверитьОператорВопросаПоЛожь() Экспорт
	А = 5;
	юТест.ПроверитьЛожь(?(Ложь,ТестоваяПроцедура_УстановитьПоСсылке(А),Ложь));
	юТест.ПроверитьРавенство(5, А);
КонецПроцедуры

Процедура ТестДолжен_ПроверитьМаршаллингУникальныхИдентификаторовИПеречислений() Экспорт
	
	ИД = Новый УникальныйИдентификатор();
	Перечисление = ТипУзлаXML.НачалоЭлемента;
	Приемник = Новый Соответствие;
	
	Приемник[ИД] = Истина;
	Приемник[Перечисление] = Истина;
	
	// не должно упасть
	
КонецПроцедуры

Процедура ПроброситьИсключение()

	Попытка
		ВызватьИсключение "Первое";
	Исключение
		Попытка
			А = 1;
		Исключение
			ВызватьИсключение "Второе";
		КонецПопытки;
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры


Процедура ТестДолжен_ПроверитьВложенностьПробрасываемыхИсключений() Экспорт

	Попытка
		ПроброситьИсключение();
	Исключение
		юТест.ПроверитьИстину(ПустаяСтрока(ИнформацияОбОшибке().Описание), "Текст исключения должен быть пустым");
	КонецПопытки;
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьКомпиляциюОбращенияКВозвращаемомуОбъектуЧерезТочку() Экспорт
	ФункцияВозвращаетОбъект().Вставить("Свойство");
	Попытка
		ФункцияВозвращаетОбъект().Свойство = "Привет";
	Исключение // здесь проверяется возможность компиляции, если скрипт запустился, значит тест прошел.
			   // поэтому исключение проглатывается
	КонецПопытки;
КонецПроцедуры

Процедура ТестДолжен_ПроверитьРаботуФункцииТРег() Экспорт
	Текст = "шЛА Маша по шоссе(и) Сосала ""Сушку""";
	юТест.ПроверитьРавенство("Шла Маша По Шоссе(И) Сосала ""Сушку""", ТРег(Текст));
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоПараметрОтмеченныйЗнач_НеМеняется() Экспорт
	
	Парам = 1;
	НовыйПарам = ПроверкаЗнач(Парам);
	юТест.ПроверитьРавенство(1, Парам, "Ожидали, что параметр не изменит своего значения, а он поменял");

КонецПроцедуры

Функция ПроверкаЗнач(Знач Парам)
	Парам = Парам + 1;
КонецФункции

Процедура ТестДолжен_ПроверитьЧтоИзФункцииВозвращаютсяРазныеЗначения() Экспорт
	МассивИсходный = Новый Массив;
	МассивИсходный.Добавить(Новый Структура("Значение,Тело", "слово","тело"));
	МассивИсходный.Добавить(Новый Структура("Значение,Тело", "ДругоеСлово", "ДругоеТело"));

	Массив = Новый Массив;
	Для к=0 По 1 Цикл
		Элемент = МассивИсходный[к];
		Значение = Элемент.Значение;// ВАЖНО - именно присвоение значение приводит к багу
		Исходный = СозданиеНовойСтруктуры(Значение, Элемент.Тело);
		Массив.Добавить(Исходный);
	КонецЦикла;
	юТест.ПроверитьРавенство("слово", Массив[0].Лексема, "Ожидали, что параметр не изменит своего значения, а он поменял");

КонецПроцедуры

Функция СозданиеНовойСтруктуры(Лексема = "", Тело = "")
	Возврат Новый Структура("Лексема,Тело,Строки", Лексема, Тело, Новый Массив); // ВАЖНО - Если так, то падает
	
	// Рез = Новый Структура("Строки", Новый Массив); //А если так, то работает
	// Рез.Вставить("Лексема", Лексема);
	// Рез.Вставить("Тело", Тело);
	// Возврат Рез;
КонецФункции
