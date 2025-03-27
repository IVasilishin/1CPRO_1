///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Обработчик фоновой выгрузки данных в другую программу.
//
Процедура ВыполнитьПереносСведенийОПользователях(Знач Параметры, Знач АдресХранилища) Экспорт
	
	УниверсальнаяВыгрузкаДанных = Обработки.УниверсальныйОбменДаннымиXML.Создать();
	
	ТекстСообщения = "";
	
	ЗагрузитьПравилаОбмена(УниверсальнаяВыгрузкаДанных, ТекстСообщения);
	
	Если ПустаяСтрока(ТекстСообщения) Тогда
		ВыполнитьПеренос(УниверсальнаяВыгрузкаДанных, Параметры, ТекстСообщения);
	КонецЕсли;
	
	ПоместитьВоВременноеХранилище(ТекстСообщения, АдресХранилища);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗагрузитьПравилаОбмена(Знач ОбработкаВыгрузкиДанных, ТекстСообщения)
	
	ОбработкаВыгрузкиДанных.ИмяФайлаПравилОбмена = ПолучитьИмяВременногоФайла("xml");
	
	МакетПравилОбмена = ПолучитьМакет("ПравилаПереносаДанных");
	МакетПравилОбмена.Записать(ОбработкаВыгрузкиДанных.ИмяФайлаПравилОбмена);
	
	ОбработкаВыгрузкиДанных.ЗагрузитьПравилаОбмена();
	
	УдалитьФайлы(ОбработкаВыгрузкиДанных.ИмяФайлаПравилОбмена);
	
	Если ОбработкаВыгрузкиДанных.ФлагОшибки Тогда
		ТекстСообщения = НСтр("ru = 'Ошибка при загрузке правил переноса данных.'");
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьПеренос(Знач ОбработкаВыгрузкиДанных, Знач Параметры, ТекстСообщения)
	
	// Параметры переноса
	ОбработкаВыгрузкиДанных.ВыгружатьТолькоРазрешенные                      = Истина;
	ОбработкаВыгрузкиДанных.ФлагРежимОтладки                                = Ложь;
	ОбработкаВыгрузкиДанных.ВыполнитьОбменДаннымиВОптимизированномФормате   = Истина;
	ОбработкаВыгрузкиДанных.НепосредственноеЧтениеВИБПриемнике              = Истина;
	ОбработкаВыгрузкиДанных.ВерсияПлатформыИнформационнойБазыДляПодключения = "V83";
	ОбработкаВыгрузкиДанных.НеВыводитьНикакихИнформационныхСообщенийПользователю = Истина;
	
	// Параметры подключения
	ПараметрыПодключения = Параметры.ПараметрыПодключения;
	
	ОбработкаВыгрузкиДанных.ТипИнформационнойБазыДляПодключения                   = ПараметрыПодключения.ВариантРаботыИнформационнойБазы = 0;
	ОбработкаВыгрузкиДанных.АутентификацияWindowsИнформационнойБазыДляПодключения = ПараметрыПодключения.АутентификацияОперационнойСистемы;
	
	ОбработкаВыгрузкиДанных.КаталогИнформационнойБазыДляПодключения      = ПараметрыПодключения.КаталогИнформационнойБазы;
	ОбработкаВыгрузкиДанных.ИмяСервераИнформационнойБазыДляПодключения   = ПараметрыПодключения.ИмяСервера1СПредприятия;
	ОбработкаВыгрузкиДанных.ИмяИнформационнойБазыНаСервереДляПодключения = ПараметрыПодключения.ИмяИнформационнойБазыНаСервере1СПредприятия;
	
	ОбработкаВыгрузкиДанных.ПользовательИнформационнойБазыДляПодключения = ПараметрыПодключения.ИмяПользователя;
	ОбработкаВыгрузкиДанных.ПарольИнформационнойБазыДляПодключения       = ПараметрыПодключения.ПарольПользователя;
	
	ОбработкаВыгрузкиДанных.ВыполнитьВыгрузку();
	
	Если ОбработкаВыгрузкиДанных.ФлагОшибки Тогда
		ТекстСообщения = НСтр("ru = 'При переносе сведений о пользователях произошли ошибки.'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
