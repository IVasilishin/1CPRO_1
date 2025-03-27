///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем СтараяЦена;

#КонецОбласти

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступом.ЗаполнитьНаборыЗначенийДоступа.
//
// Параметры:
//   Таблица - см. УправлениеДоступом.ТаблицаНаборыЗначенийДоступа
//
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	// Логика ограничения:
	// Чтения:                Без ограничения.
	// Изменения:             Без ограничения.
	
	// Чтение, Добавление, Изменение: набор №0.
	Строка = Таблица.Добавить();
	Строка.ЗначениеДоступа = Перечисления.ДополнительныеЗначенияДоступа.ДоступРазрешен;
	
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СтараяЦена = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Цена");
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если СтараяЦена <> Цена Тогда
		ТекущаяДатаСеанса = ТекущаяДатаСеанса();
		НаборЗаписей = РегистрыСведений._ДемоЦеныНоменклатуры.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Период.Установить(ТекущаяДатаСеанса);
		НаборЗаписей.Отбор.Номенклатура.Установить(Ссылка);
		Запись = НаборЗаписей.Добавить();
		Запись.Период = ТекущаяДатаСеанса;
		Запись.Номенклатура = Ссылка;
		Запись.Цена = Цена;
		НаборЗаписей.Записать();
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Проверка на наличие дублей по наименованию и виду номенклатуры.
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Режим",  "КонтрольПоНаименованию");
	ДополнительныеПараметры.Вставить("Ссылка", Ссылка);
	
	Дубли = ПоискИУдалениеДублей.НайтиДублиЭлемента("Справочник._ДемоНоменклатура", ЭтотОбъект, ДополнительныеПараметры);
	Если Дубли.Количество() > 0 Тогда
		Ошибка = НСтр("ru = 'Номенклатура с таким наименованием и видом уже существует.'");
		ОбщегоНазначения.СообщитьПользователю(Ошибка, , "Объект.Наименование", , Отказ);
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		НепроверяемыеРеквизиты = Новый Массив;
		НепроверяемыеРеквизиты.Добавить("ВидНоменклатуры");
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли