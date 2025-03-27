///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// Вызывается при поиске замены дублей подчиненных объектов (см. ОбщегоНазначения.ЗаменитьСсылки).
// Демонстрирует пример переопределения процедуры поиска при замене ссылок на владельцев справочника.
//
// Параметры:
//	ПарыЗамен - соответствие из КлючИЗначение - содержит пары значение Оригинал/Дубль:
//		* Ключ - ЛюбаяСсылка - что заменяем.
//		* Значение - ЛюбаяСсылка - на что заменяем.
//	НеобработанныеДубли - Массив из Структура:
//		* ЗаменяемоеЗначение - ЛюбаяСсылка - оригинальное значение заменяемого объекта
//		* ИспользуемыеСвязи - см. ПоискИУдалениеДублей.СвязиПодчиненныхОбъектовПоТипам  
//		* ЗначениеКлючевыхРеквизитов - Структура - Ключ - имя реквизита, значение - значение реквизита 
//
Процедура ПриПоискеЗаменыСсылок(ПарыЗамен, НеобработанныеДубли) Экспорт

	Для каждого НеобработанныйДубль Из НеобработанныеДубли Цикл
		
		ЗначениеКлючевыхРеквизитов = НеобработанныйДубль.ЗначениеКлючевыхРеквизитов;
		
		Если НЕ ЗначениеЗаполнено(ЗначениеКлючевыхРеквизитов.НомерСчета) Тогда
			Продолжить;
		КонецЕсли;
		
		Если НеобработанныйДубль.ИспользуемыеСвязи.Найти("Владелец", "ИмяРеквизита") = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ЗаменяемоеЗначениеОсновногоОбъекта = ПарыЗамен[ЗначениеКлючевыхРеквизитов.Владелец];
		Если НЕ ЗначениеЗаполнено(ЗаменяемоеЗначениеОсновногоОбъекта) Тогда
			Продолжить;
		КонецЕсли;
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	_ДемоБанковскиеСчета.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник._ДемоБанковскиеСчета КАК _ДемоБанковскиеСчета
		|ГДЕ
		|	_ДемоБанковскиеСчета.НомерСчета = &НомерСчета
		|	И _ДемоБанковскиеСчета.Владелец = &Владелец";
		
		Запрос.УстановитьПараметр("Владелец", ЗаменяемоеЗначениеОсновногоОбъекта);
		Запрос.УстановитьПараметр("НомерСчета", ЗначениеКлючевыхРеквизитов.НомерСчета);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Если ВыборкаДетальныеЗаписи.Следующий() Тогда
			ПарыЗамен.Вставить(НеобработанныйДубль.ЗаменяемоеЗначение, ВыборкаДетальныеЗаписи.Ссылка);
		КонецЕсли;	
	
	КонецЦикла;

КонецПроцедуры

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ
	|	ЗначениеРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоОрганизации))
	|	И ЧтениеСпискаРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоОрганизации))
	|	ИЛИ
	|	ЗначениеРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоКонтрагенты).Партнер)
	|	И ЧтениеСпискаРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоКонтрагенты).Партнер)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ЗначениеРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоОрганизации))
	|	И ИзменениеСпискаРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоОрганизации))
	|	ИЛИ
	|	ЗначениеРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоКонтрагенты).Партнер)
	|	И ИзменениеСпискаРазрешено(ВЫРАЗИТЬ(Владелец КАК Справочник._ДемоКонтрагенты).Партнер)";
	
	Ограничение.ТекстДляВнешнихПользователей =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК _ДемоБанковскиеСчета
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник._ДемоКонтрагенты КАК _ДемоКонтрагенты
	|	ПО _ДемоКонтрагенты.Ссылка = _ДемоБанковскиеСчета.Владелец
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователиПартнеры
	|	ПО ВнешниеПользователиПартнеры.ОбъектАвторизации = _ДемоКонтрагенты.Партнер
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник._ДемоКонтактныеЛицаПартнеров КАК _ДемоКонтактныеЛицаПартнеров
	|	ПО _ДемоКонтактныеЛицаПартнеров.Владелец = _ДемоКонтрагенты.Партнер
	|
	|ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ВнешниеПользователи КАК ВнешниеПользователиКонтактныеЛица
	|	ПО ВнешниеПользователиКонтактныеЛица.ОбъектАвторизации = _ДемоКонтактныеЛицаПартнеров.Ссылка
	|;
	|РазрешитьЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец ТОЛЬКО Справочник._ДемоОрганизации)
	|	И ЧтениеСпискаРазрешено(Владелец ТОЛЬКО Справочник._ДемоОрганизации)
	|	ИЛИ
	|	ЗначениеРазрешено(ВнешниеПользователиПартнеры.Ссылка)
	|	И ЧтениеСпискаРазрешено(ВнешниеПользователиПартнеры.ОбъектАвторизации)
	|	ИЛИ
	|	ЗначениеРазрешено(ВнешниеПользователиКонтактныеЛица.Ссылка)
	|	И ЧтениеСпискаРазрешено(ВнешниеПользователиКонтактныеЛица.ОбъектАвторизации)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Владелец ТОЛЬКО Справочник._ДемоОрганизации)
	|	И ИзменениеСпискаРазрешено(Владелец ТОЛЬКО Справочник._ДемоОрганизации)
	|	ИЛИ
	|	ЗначениеРазрешено(ВнешниеПользователиПартнеры.Ссылка)
	|	И ИзменениеСпискаРазрешено(ВнешниеПользователиПартнеры.ОбъектАвторизации)
	|	ИЛИ
	|	ЗначениеРазрешено(ВнешниеПользователиКонтактныеЛица.Ссылка)
	|	И ИзменениеСпискаРазрешено(ВнешниеПользователиКонтактныеЛица.ОбъектАвторизации)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли
