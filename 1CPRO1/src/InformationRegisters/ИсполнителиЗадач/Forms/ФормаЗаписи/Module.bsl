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
	
	УстановитьСостояниеЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект)
	Если НЕ ЗначениеЗаполнено(ТекущийОбъект.ОсновнойОбъектАдресации) Тогда
		ТекущийОбъект.ОсновнойОбъектАдресации = Неопределено;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ТекущийОбъект.ДополнительныйОбъектАдресации) Тогда
		ТекущийОбъект.ДополнительныйОбъектАдресации = Неопределено;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_РолеваяАдресация", ПараметрыЗаписи, Запись.РольИсполнителя);
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РольИсполнителяПриИзменении(Элемент)
	
	Запись.ОсновнойОбъектАдресации = Неопределено;
	Запись.ДополнительныйОбъектАдресации = Неопределено;
	УстановитьСостояниеЭлементов();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьСостояниеЭлементов()

	ТипыОсновногоОбъектаАдресации = Запись.РольИсполнителя.ТипыОсновногоОбъектаАдресации.ТипЗначения;
	ТипыДополнительногоОбъектаАдресации = Запись.РольИсполнителя.ТипыДополнительногоОбъектаАдресации.ТипЗначения;
	ИспользуетсяСОбъектамиАдресации = Запись.РольИсполнителя.ИспользуетсяСОбъектамиАдресации;
	ИспользуетсяБезОбъектовАдресации = Запись.РольИсполнителя.ИспользуетсяБезОбъектовАдресации;
	
	ЗаданаРоль = НЕ Запись.РольИсполнителя.Пустая();
	ЗаголовокОсновногоОбъектаАдресации = ?(ЗаданаРоль, Строка(Запись.РольИсполнителя.ТипыОсновногоОбъектаАдресации), "");
	ЗаголовокДополнительногоОбъектаАдресации = ?(ЗаданаРоль, Строка(Запись.РольИсполнителя.ТипыДополнительногоОбъектаАдресации), "");
	
	ЗаданыТипыОсновногоОбъектаАдресации = ЗаданаРоль И ИспользуетсяСОбъектамиАдресации
		И ЗначениеЗаполнено(ТипыОсновногоОбъектаАдресации);
	ЗаданыТипыДополнительногоОбъектаАдресации = ЗаданаРоль И ИспользуетсяСОбъектамиАдресации 
		И ЗначениеЗаполнено(ТипыДополнительногоОбъектаАдресации);
	Элементы.ОсновнойОбъектАдресации.Доступность = ЗаданыТипыОсновногоОбъектаАдресации;
	Элементы.ДополнительныйОбъектАдресации.Доступность = ЗаданыТипыДополнительногоОбъектаАдресации;
	
	Элементы.ОсновнойОбъектАдресации.АвтоОтметкаНезаполненного = ЗаданыТипыОсновногоОбъектаАдресации
		И НЕ ИспользуетсяБезОбъектовАдресации;
	Если ТипыОсновногоОбъектаАдресации <> Неопределено Тогда
		Элементы.ОсновнойОбъектАдресации.ОграничениеТипа = ТипыОсновногоОбъектаАдресации;
	КонецЕсли;
	Элементы.ОсновнойОбъектАдресации.Заголовок = ЗаголовокОсновногоОбъектаАдресации;
	
	Элементы.ДополнительныйОбъектАдресации.АвтоОтметкаНезаполненного = ЗаданыТипыДополнительногоОбъектаАдресации
		И НЕ ИспользуетсяБезОбъектовАдресации;
	Если ТипыДополнительногоОбъектаАдресации <> Неопределено Тогда
		Элементы.ДополнительныйОбъектАдресации.ОграничениеТипа = ТипыДополнительногоОбъектаАдресации;
	КонецЕсли;
	Элементы.ДополнительныйОбъектАдресации.Заголовок = ЗаголовокДополнительногоОбъектаАдресации;
	
	УстановитьДоступностьРоли(Запись.РольИсполнителя);
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьРоли(Роль)
	
	РольДоступнаДляВнешнихПользователей = ПолучитьФункциональнуюОпцию("ИспользоватьВнешнихПользователей");
	Если Не РольДоступнаДляВнешнихПользователей Тогда
		ВариантНазначения = "ТолькоПользователи"; 
		РольДоступнаДляПользователей = Истина;
	Иначе
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РолиИсполнителейНазначение.ТипПользователей
		|ИЗ
		|	Справочник.РолиИсполнителей.Назначение КАК РолиИсполнителейНазначение
		|ГДЕ
		|	РолиИсполнителейНазначение.Ссылка = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", Роль);
		
		РезультатЗапроса = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		РольДоступнаДляПользователей = Ложь;
		УРолиНеНазначеныВнешниеПользователи = Истина;
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Если ВыборкаДетальныеЗаписи.ТипПользователей = Справочники.Пользователи.ПустаяСсылка() Тогда
				РольДоступнаДляПользователей = Истина;
			Иначе
				УРолиНеНазначеныВнешниеПользователи = Ложь;
			КонецЕсли;
		КонецЦикла;
		
		Если УРолиНеНазначеныВнешниеПользователи Тогда
			РольДоступнаДляВнешнихПользователей = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	Если РольДоступнаДляВнешнихПользователей И РольДоступнаДляПользователей Тогда
		Элементы.Исполнитель.ВыбиратьТип = Истина;
	Иначе
		Если РольДоступнаДляВнешнихПользователей И ТипЗнч(Запись.Исполнитель) = Тип("СправочникСсылка.Пользователи") Тогда
			Запись.Исполнитель = Справочники.ВнешниеПользователи.ПустаяСсылка();
		ИначеЕсли ТипЗнч(Запись.Исполнитель) = Тип("СправочникСсылка.ВнешниеПользователи") Тогда
			Запись.Исполнитель = Справочники.Пользователи.ПустаяСсылка();
		КонецЕсли;
		Элементы.Исполнитель.ВыбиратьТип = Ложь;
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти
