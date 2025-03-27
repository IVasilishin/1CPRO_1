///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.КоманднаяПанель;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
		
	// СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	ЗащитаПерсональныхДанных.ПриСозданииНаСервереФормыСписка(ЭтотОбъект, Элементы.Список);
	// Конец СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.ЭлектроннаяПодпись
	Элементы.ФормаЗаявлениеНаСертификат.Видимость =
		ЭлектроннаяПодпись.ДоступностьСозданияЗаявления().ДляФизическихЛиц;
	// Конец СтандартныеПодсистемы.ЭлектроннаяПодпись
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	ЗащитаПерсональныхДанныхКлиент.ОбработкаОповещенияФормыСписка(Элементы.Список, ИмяСобытия);
	// Конец СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)

	// СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	ЗащитаПерсональныхДанных.ПриПолученииДанныхНаСервере(Настройки, Строки);
	// Конец СтандартныеПодсистемы.ЗащитаПерсональныхДанных
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПоискИУдалениеДублей

&НаКлиенте
Процедура ОбъединитьВыделенные(Команда)
	
	ПоискИУдалениеДублейКлиент.ОбъединитьВыделенные(Элементы.Список);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьМестаИспользования(Команда)
	
	ПоискИУдалениеДублейКлиент.ПоказатьМестаИспользования(Элементы.Список);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПоискИУдалениеДублей

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Элементы.Список);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


// СтандартныеПодсистемы.ЗащитаПерсональныхДанных
&НаКлиенте
Процедура Подключаемый_ПоказыватьСоСкрытымиПДн(Команда)
	ЗащитаПерсональныхДанныхКлиент.ПоказыватьСоСкрытымиПДн(ЭтотОбъект, Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ЗащитаПерсональныхДанных

// СтандартныеПодсистемы.ЭлектроннаяПодпись
&НаКлиенте
Процедура ЗаявлениеНаСертификат(Команда)
	
	Если Не ЗначениеЗаполнено(Элементы.Список.ТекущаяСтрока)
	 Или Элементы.Список.ТекущиеДанные.ЭтоГруппа Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Выделите строку с физическим лицом'"));
		Возврат;
	КонецЕсли;
	
	ОбработчикРезультата = Новый ОписаниеОповещения("ЗаявлениеНаСертификатПослеДобавления", ЭтотОбъект);
	
	ПараметрыДобавления = ЭлектроннаяПодписьКлиент.ПараметрыДобавленияСертификата();
	ПараметрыДобавления.ФизическоеЛицо = Элементы.Список.ТекущаяСтрока;
	ПараметрыДобавления.ИзЛичногоХранилища = Ложь;
	ЭлектроннаяПодписьКлиент.ДобавитьСертификат(ОбработчикРезультата, ПараметрыДобавления);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ЭлектроннаяПодпись

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ЭлектроннаяПодпись

// Параметры:
//  Результат - Неопределено
//            - Структура:
//          * Ссылка   - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования
//          * Добавлен - Булево
//
//  Контекст - Неопределено
//
&НаКлиенте
Процедура ЗаявлениеНаСертификатПослеДобавления(Результат, Контекст) Экспорт
	
	Если Результат = Неопределено Тогда
		ТекстПредупреждения = НСтр("ru = 'Заявление не добавлено'");
		
	ИначеЕсли Не Результат.Добавлен Тогда
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Заявление добавлено, но не исполнено:
			           |%1'"), Результат.Ссылка);
	Иначе
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Заявление добавлено, и исполнено:
			           |%1'"), Результат.Ссылка);
	КонецЕсли;
	
	ПоказатьПредупреждение(, ТекстПредупреждения);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.ЭлектроннаяПодпись

#КонецОбласти
