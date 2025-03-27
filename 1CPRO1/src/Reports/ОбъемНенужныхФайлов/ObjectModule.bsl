///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	НастройкиОчистки = РегистрыСведений.НастройкиОчисткиФайлов.ТекущиеНастройкиОчистки();
	
	ТаблицаНенужныхФайлов = Новый ТаблицаЗначений;
	ТаблицаНенужныхФайлов.Колонки.Добавить("ВладелецФайла");
	ТаблицаНенужныхФайлов.Колонки.Добавить("ОбъемНенужныхФайлов", Новый ОписаниеТипов("Число"));
	
	НастройкиОчисткиФайлов  = НастройкиОчистки.НайтиСтроки(Новый Структура("ЭтоНастройкаДляЭлементаСправочника", Ложь));
	
	Для Каждого Настройка Из НастройкиОчисткиФайлов Цикл
		
		МассивИсключений = Новый Массив;
		ДетализированныеНастройки = НастройкиОчистки.НайтиСтроки(Новый Структура(
		"ИдентификаторВладельца, ЭтоНастройкаДляЭлементаСправочника",
		Настройка.ВладелецФайла,
		Истина));
		Если ДетализированныеНастройки.Количество() > 0 Тогда
			Для Каждого ЭлементИсключение Из ДетализированныеНастройки Цикл
				МассивИсключений.Добавить(ЭлементИсключение.ВладелецФайла);
				ПолучитьОбъемНенужныхФайлов(ТаблицаНенужныхФайлов, ЭлементИсключение, , Истина);
			КонецЦикла;
		КонецЕсли;
		
		ПолучитьОбъемНенужныхФайлов(ТаблицаНенужныхФайлов, Настройка, МассивИсключений, Ложь);
	КонецЦикла;
	
	СтандартнаяОбработка = Ложь;
	
	ДокументРезультат.Очистить();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	
	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("ОбъемДанныхВсего", ОбъемДанныхВсего());
	ВнешниеНаборыДанных.Вставить("ОбъемНенужныхФайлов", ТаблицаНенужныхФайлов);
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки, Истина);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВариантыОтчетов") Тогда
		ОтчетПустой = ОбщегоНазначения.ОбщийМодуль("ОтчетыСервер").ОтчетПустой(ЭтотОбъект, ПроцессорКомпоновки);
		КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства.Вставить("ОтчетПустой", ОтчетПустой);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
// 	ТаблицаНенужныхФайлов - ТаблицаЗначений:
//   * ВладелецФайла - ЛюбаяСсылка
//   * ОбъемНенужныхФайлов - Число
// 	НастройкаОчистки - СтрокаТаблицыЗначений:
// 	* Действие - ПеречислениеСсылка.ВариантыОчисткиФайлов
// 	МассивИсключений - Неопределено
// 	                 - Массив
// 	ЭтоНастройкаДляЭлементаСправочника - Булево
//
Процедура ПолучитьОбъемНенужныхФайлов(ТаблицаНенужныхФайлов, НастройкаОчистки, МассивИсключений = Неопределено, ЭтоНастройкаДляЭлементаСправочника = Ложь)
	
	Если НастройкаОчистки.Действие = Перечисления.ВариантыОчисткиФайлов.НеОчищать Тогда
		Возврат;
	КонецЕсли;
	
	Если МассивИсключений = Неопределено Тогда
		МассивИсключений = Новый Массив;
	КонецЕсли;
	
	НенужныеФайлы = ВыбратьДанныеПоПравилу(НастройкаОчистки, МассивИсключений);
	
	Для Каждого Стр Из НенужныеФайлы Цикл
		НоваяСтрока = ТаблицаНенужныхФайлов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Стр);
	КонецЦикла;
	
КонецПроцедуры

Функция ТекстЗапросаДляОчисткиФайлов(ВладелецФайла, Настройка, МассивИсключений, ЭлементИсключение)
	
	Возврат РаботаСФайламиСлужебный.ТекстЗапросаДляОчисткиФайлов(ВладелецФайла, Настройка, МассивИсключений, ЭлементИсключение, Истина);
	
КонецФункции

Функция ВыбратьДанныеПоПравилу(НастройкаОчистки, МассивИсключений)
	
	ВременныйКомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
	
	ОчищатьПоПравилу = НастройкаОчистки.ПериодОчистки = Перечисления.ПериодОчисткиФайлов.ПоПравилу;
	Если ОчищатьПоПравилу Тогда
		НастройкиКомпоновщика = НастройкаОчистки.ПравилоОтбора.Получить();
		Если НастройкиКомпоновщика <> Неопределено Тогда
			ВременныйКомпоновщикНастроек.ЗагрузитьНастройки(НастройкиКомпоновщика);
		КонецЕсли;
	КонецЕсли;
	
	ВременнаяСхемаКомпоновкиДанных = Новый СхемаКомпоновкиДанных;
	ИсточникДанных = ВременнаяСхемаКомпоновкиДанных.ИсточникиДанных.Добавить();
	ИсточникДанных.Имя = "ИсточникДанных1";
	ИсточникДанных.ТипИсточникаДанных = "Local";
	
	НаборДанных = ВременнаяСхемаКомпоновкиДанных.НаборыДанных.Добавить(Тип("НаборДанныхЗапросСхемыКомпоновкиДанных"));
	НаборДанных.Имя = "НаборДанных1";
	НаборДанных.ИсточникДанных = ИсточникДанных.Имя;
	
	ВременнаяСхемаКомпоновкиДанных.ПоляИтога.Очистить();
	
	Если НастройкаОчистки.ЭтоНастройкаДляЭлементаСправочника Тогда
		ВладелецФайла = НастройкаОчистки.ИдентификаторВладельца;
		ЭлементИсключение = НастройкаОчистки.ВладелецФайла;
	Иначе
		ВладелецФайла = НастройкаОчистки.ВладелецФайла;
		ЭлементИсключение = Неопределено;
	КонецЕсли;
	
	ВременнаяСхемаКомпоновкиДанных.НаборыДанных[0].Запрос = ТекстЗапросаДляОчисткиФайлов(
		ВладелецФайла,
		НастройкаОчистки,
		МассивИсключений,
		ЭлементИсключение);
	
	Структура = ВременныйКомпоновщикНастроек.Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	
	ВыбранноеПоле = Структура.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных("ВладелецФайла");
	
	ВыбранноеПоле = Структура.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных("ОбъемНенужныхФайлов");
	
	ВременныйКомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(ВременнаяСхемаКомпоновкиДанных));
	
	Параметр = ВременныйКомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ТипВладельца");
	Параметр.Значение = ТипЗнч(ВладелецФайла.ЗначениеПустойСсылки);
	Параметр.Использование = Истина;
	
	Если МассивИсключений.Количество() > 0 И Не НастройкаОчистки.ЭтоНастройкаДляЭлементаСправочника Тогда
		Параметр = ВременныйКомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("МассивИсключений");
		Параметр.Значение = МассивИсключений;
		Параметр.Использование = Истина;
	КонецЕсли;
	
	ПараметрТекущаяДата = ВременныйКомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ТекущаяДата");
	Если ПараметрТекущаяДата <> Неопределено Тогда
		ПараметрТекущаяДата.Значение = ТекущаяДатаСеанса();
		ПараметрТекущаяДата.Использование = Истина;
	КонецЕсли;
	
	Параметр = ВременныйКомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ПериодОчистки");
	Если Параметр <> Неопределено Тогда
		Если НастройкаОчистки.ПериодОчистки = Перечисления.ПериодОчисткиФайлов.СтаршеМесяца Тогда
			ЗначениеПериодаОчистки = ДобавитьМесяц(НачалоДня(ТекущаяДатаСеанса()), -1);
		ИначеЕсли НастройкаОчистки.ПериодОчистки = Перечисления.ПериодОчисткиФайлов.СтаршеГода Тогда
			ЗначениеПериодаОчистки = ДобавитьМесяц(НачалоДня(ТекущаяДатаСеанса()), -12);
		ИначеЕсли НастройкаОчистки.ПериодОчистки = Перечисления.ПериодОчисткиФайлов.СтаршеШестиМесяцев Тогда
			ЗначениеПериодаОчистки = ДобавитьМесяц(НачалоДня(ТекущаяДатаСеанса()), -6);
		КонецЕсли;
		Параметр.Значение = ЗначениеПериодаОчистки;
		Параметр.Использование = Истина;
	КонецЕсли;
	
	Если НастройкаОчистки.ЭтоНастройкаДляЭлементаСправочника Тогда
		Параметр = ВременныйКомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ЭлементИсключение");
		Параметр.Значение = ЭлементИсключение;
		Параметр.Использование = Истина;
	КонецЕсли;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ТаблицаЗначений = Новый ТаблицаЗначений;
	
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(ВременнаяСхемаКомпоновкиДанных, ВременныйКомпоновщикНастроек.Настройки, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновкиДанных);
	ПроцессорВывода.УстановитьОбъект(ТаблицаЗначений);
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
	
	Возврат ТаблицаЗначений;
	
КонецФункции

Функция ОбъемДанныхВсего()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = РаботаСФайламиСлужебный.ТекстЗапросаПолногоОбъемаФайлов();
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить();
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли