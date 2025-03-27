///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Загружает настройки пользователей информационной базы.
//
// Параметры:
//	Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//	Обработчики - ОбработкаОбъектИмяОбработки - 
//  ЗаменитьПользователяВНастройках - Соответствие - соответствие старого и нового имени пользователя ИБ.
//
Процедура ЗагрузитьНастройкиПользователейИнформационнойБазы(Контейнер, Обработчики, ПотокЗаменыСсылок, ЗаменитьПользователяВНастройках = Неопределено) Экспорт
	
	ТипыХранилищ = ВыгрузкаЗагрузкаДанныхСлужебный.ТипыСтандартныхХранилищНастроек();
	
	Для Каждого ТипХранилища Из ТипыХранилищ Цикл
		
		МенеджерЗагрузки = Создать();
		МенеджерЗагрузки.Инициализировать(Контейнер, ТипХранилища, Обработчики, ПотокЗаменыСсылок);
		МенеджерЗагрузки.ЗагрузитьДанные(ЗаменитьПользователяВНастройках);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
