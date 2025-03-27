///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Загружает данные информационной базы.
//
// Параметры:
//	Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//	Обработчики - ОбщийМодуль, ОбработкаМенеджер -
//
Функция ЗагрузитьДанныеИнформационнойБазы(Контейнер, Обработчики) Экспорт
	
	ЗагружаемыеТипы = Контейнер.ПараметрыЗагрузки().ЗагружаемыеТипы;
	ИсключаемыеТипы = ВыгрузкаЗагрузкаДанныхСлужебныйСобытия.ПолучитьТипыИсключаемыеИзВыгрузкиЗагрузки();
	
	МенеджерЗагрузки = Создать();
	МенеджерЗагрузки.Инициализировать(Контейнер, ЗагружаемыеТипы, ИсключаемыеТипы, Обработчики);
	МенеджерЗагрузки.ЗагрузитьДанные();
	
	Возврат МенеджерЗагрузки.ТекущийПотокЗаменыСсылок();
	
КонецФункции

#КонецОбласти

#КонецЕсли
