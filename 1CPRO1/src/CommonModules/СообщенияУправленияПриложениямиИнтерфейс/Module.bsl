///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
// Возвращаемое значение:
//	Строка - 
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/ManageApplication/Messages/1.0";
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
// Возвращаемое значение:
//	Строка - 
Функция Версия() Экспорт
	
	Возврат "1.0.0.1";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
// Возвращаемое значение:
//	Строка - 
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ManageApplicationMessages";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/1cFresh/ManageApplication/Messages/a.b.c.d}RevokeUserAccess.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеАннулироватьДоступПользователя(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "RevokeUserAccess");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
