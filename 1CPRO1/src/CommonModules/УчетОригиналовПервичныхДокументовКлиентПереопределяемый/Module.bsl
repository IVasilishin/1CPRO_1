///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается при открытии журнала оригиналов первичных документов в случае использования подключаемого оборудования.
// Позволяет определить собственный процесс подключения подключаемого оборудования к журналу.
//	
//	Параметры:
//	Форма - УправляемаяФорма - форма списка документа.
//	Параметры - Структура - необязательный. Дополнительные параметры подключения оборудования.
//
Процедура ПриПодключенииСканераШтрихкода(Форма) Экспорт

КонецПроцедуры

// Вызывается при открытии журнала оригиналов первичных документов в случае использования подключаемого оборудования.
// Позволяет определить собственный процесс подключения подключаемого оборудования к журналу.
//	
Процедура ПриОткрытииФормыЖурналаУчетаОригиналов() Экспорт

	// _Демо начало примера
	ОткрытьФорму("Обработка._ДемоЖурналУчетаОригиналовПервичныхДокументов.Форма.СписокДокументов");
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти
