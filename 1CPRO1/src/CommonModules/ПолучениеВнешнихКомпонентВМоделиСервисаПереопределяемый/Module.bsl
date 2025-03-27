///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.РаботаВМоделиСервиса.ПолучениеВнешнихКомпонент".
// ОбщийМодуль.ПолучениеВнешнихКомпонентВМоделиСервисаПереопределяемый.
//
// Серверные переопределяемые процедуры загрузки внешних компонент:
//  - внешних компоненты используемых программой;
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переопределяются идентификаторы внешних компонент, которые используются в конфигурации.
// Указанные внешние компоненты будут загружены при обработке поставляемых данных.
//
// Параметры:
//  Идентификаторы - Массив - содержит идентификаторы внешних компоненты.
//
Процедура ПриОпределенииИспользуемыхВерсийВнешнихКомпонент(Идентификаторы) Экспорт
	
	// _Демо начало примера
	// Компоненты, используемые для тестировния подсистемы СтандартныеПодсистемы.ВнешниеКомпоненты.
	Идентификаторы.Добавить("InputDevice");
	Идентификаторы.Добавить("Scanner");
	Идентификаторы.Добавить("CustomerDisplay1C");
	Идентификаторы.Добавить("RFIDReader");
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти
