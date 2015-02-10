﻿Перем юТест;

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СоздатьАрхивЧерезКонструкторИмениФайла");
	ВсеТесты.Добавить("ТестДолжен_СоздатьАрхивЧерезМетодОткрыть");
	ВсеТесты.Добавить("ТестДолжен_ДобавитьВАрхивОдиночныйФайлБезПутей");
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ТестДолжен_СоздатьАрхивЧерезКонструкторИмениФайла() Экспорт
	
	ИмяАрхива = ПолучитьИмяВременногоФайла("zip");
	Архив = Новый ЗаписьZipФайла(ИмяАрхива);
	Архив.Записать();
	
	Файл = Новый Файл(ИмяАрхива);
	юТест.ПроверитьИстину(Файл.Существует());
	УдалитьФайлы(ИмяАрхива);
	
КонецПроцедуры

Процедура ТестДолжен_СоздатьАрхивЧерезМетодОткрыть() Экспорт
	
	ИмяАрхива = ПолучитьИмяВременногоФайла("zip");
	Архив = Новый ЗаписьZipФайла();
	Архив.Открыть(ИмяАрхива,,"Это комментарий",,УровеньСжатияZip.Максимальный);
	Архив.Записать();
	
	Файл = Новый Файл(ИмяАрхива);
	юТест.ПроверитьИстину(Файл.Существует());
	УдалитьФайлы(ИмяАрхива);
	
КонецПроцедуры

Процедура ТестДолжен_ДобавитьВАрхивОдиночныйФайлБезПутей() Экспорт
	ФайлСкрипта = ТекущийСценарий().Источник;
	
	юТест.ПодробныеОписанияОшибок(Истина);
	
	ИмяАрхива = ПолучитьИмяВременногоФайла("zip");
	Архив = Новый ЗаписьZipФайла();
	Архив.Открыть(ИмяАрхива,,"Это комментарий",,УровеньСжатияZip.Максимальный);
	Архив.Добавить(ФайлСкрипта, РежимСохраненияПутейZip.НеСохранятьПути);
	Архив.Записать();
	
	Чтение = Новый ЧтениеZipФайла(ИмяАрхива);
	
	Попытка
		юТест.ПроверитьРавенство("", Чтение.Элементы[0].Путь);
		юТест.ПроверитьРавенство("zip.os", Чтение.Элементы[0].Имя);
		юТест.ПроверитьРавенство("zip", Чтение.Элементы[0].ИмяБезРасширения);
	Исключение	
		Чтение.Закрыть();
		УдалитьФайлы(ИмяАрхива);
		ВызватьИсключение;
	КонецПопытки;
	
	Чтение.Закрыть();
	УдалитьФайлы(ИмяАрхива);
	
КонецПроцедуры
