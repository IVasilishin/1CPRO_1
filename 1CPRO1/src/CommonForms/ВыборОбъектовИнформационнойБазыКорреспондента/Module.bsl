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
	
	Параметры.Свойство("ВыборГруппИЭлементов", ВыборГруппИЭлементов);
	
	РежимПодбора = (Параметры.ЗакрыватьПриВыборе = Ложь);
	ИмяРеквизита = Параметры.ИмяРеквизита;
	
	Если Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВнешнееСоединение" Тогда
		
		Подключение = ОбменДаннымиСервер.ВнешнееСоединениеСБазой(Параметры.ПараметрыВнешнегоСоединения);
		СтрокаСообщенияОбОшибке = Подключение.ПодробноеОписаниеОшибки;
		ВнешнееСоединение       = Подключение.Соединение;
		
		Если ВнешнееСоединение = Неопределено Тогда
			ОбщегоНазначения.СообщитьПользователю(СтрокаСообщенияОбОшибке,,,, Отказ);
			Возврат;
		КонецЕсли;
		
		СвойстваОбъектаМетаданных = ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.СвойстваОбъектаМетаданных(Параметры.ПолноеИмяТаблицыБазыКорреспондента);
		
		Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
			ИЛИ Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
			
			ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы_2_0_1_6(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
			
		Иначе
			
			ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр(ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
			
		КонецЕсли;
		
	ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВебСервис" Тогда
		
		СтрокаСообщенияОбОшибке = "";
		
		Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7 Тогда
			
			WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_1_1_7(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
			
		ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
			
			WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_0_1_6(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
			
		Иначе
			
			WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
			
		КонецЕсли;
		
		Если WSПрокси = Неопределено Тогда
			ОбщегоНазначения.СообщитьПользователю(СтрокаСообщенияОбОшибке,,,, Отказ);
			Возврат;
		КонецЕсли;
		
		Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
			ИЛИ Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
			
			ДанныеБазыКорреспондента = СериализаторXDTO.ПрочитатьXDTO(WSПрокси.GetIBData(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
			
			СвойстваОбъектаМетаданных = ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных;
			ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
			
		Иначе
			
			ДанныеБазыКорреспондента = ЗначениеИзСтрокиВнутр(WSПрокси.GetIBData(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
			
			СвойстваОбъектаМетаданных = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных);
			ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
			
		КонецЕсли;
		
	ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВременноеХранилище" Тогда
		ДанныеВременногоХранилища = ПолучитьИзВременногоХранилища(Параметры.ПараметрыВнешнегоСоединения.АдресВременногоХранилища);
		ДанныеБазыКорреспондента = ДанныеВременногоХранилища.Получить().Получить(Параметры.ПолноеИмяТаблицыБазыКорреспондента);
		
		СвойстваОбъектаМетаданных = ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных;
		ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
		
	КонецЕсли;
	
	ОбновитьИндексыПиктограммЭлементов(ТаблицаБазыКорреспондента);
	
	Заголовок = СвойстваОбъектаМетаданных.Синоним;
	
	Элементы.Список.Отображение = ?(СвойстваОбъектаМетаданных.Иерархический = Истина, ОтображениеТаблицы.ИерархическийСписок, ОтображениеТаблицы.Список);
	
	КоллекцияЭлементовДерева = Список.ПолучитьЭлементы();
	КоллекцияЭлементовДерева.Очистить();
	ОбщегоНазначения.ЗаполнитьКоллекциюЭлементовДереваДанныхФормы(КоллекцияЭлементовДерева, ТаблицаБазыКорреспондента);
	
	// Позиционирование курсора в дереве значений.
	Если Не ПустаяСтрока(Параметры.НачальноеЗначениеВыбора) Тогда
		
		ИдентификаторСтроки = 0;
		
		ОбщегоНазначенияКлиентСервер.ПолучитьИдентификаторСтрокиДереваПоЗначениюПоля("Идентификатор", ИдентификаторСтроки, КоллекцияЭлементовДерева, Параметры.НачальноеЗначениеВыбора, Ложь);
		
		Элементы.Список.ТекущаяСтрока = ИдентификаторСтроки;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбработкаВыбораЗначения();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьЗначение(Команда)
	
	ОбработкаВыбораЗначения();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаВыбораЗначения()
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные=Неопределено Тогда 
		Возврат
	КонецЕсли;
	
	// Признак группы вычисляем косвенно:
	//     0 - Не помеченная на удаление группа.
	//     1 - Помеченная на удаление группа.
	
	ЭтоГруппа = ТекущиеДанные.ИндексКартинки=0 Или ТекущиеДанные.ИндексКартинки=1;
	Если (ЭтоГруппа И ВыборГруппИЭлементов=ГруппыИЭлементы.Элементы) 
		Или (Не ЭтоГруппа И ВыборГруппИЭлементов=ГруппыИЭлементы.Группы) Тогда
		Возврат;
	КонецЕсли;
	
	Данные = Новый Структура("Представление, Идентификатор");
	ЗаполнитьЗначенияСвойств(Данные, ТекущиеДанные);
	
	Данные.Вставить("РежимПодбора", РежимПодбора);
	Данные.Вставить("ИмяРеквизита", ИмяРеквизита);
	
	ОповеститьОВыборе(Данные);
КонецПроцедуры

// Для обеспечения обратной совместимости.
//
&НаСервере
Процедура ОбновитьИндексыПиктограммЭлементов(ТаблицаБазыКорреспондента)
	
	Для Индекс = -3 По -2 Цикл
		
		Отбор = Новый Структура;
		Отбор.Вставить("ИндексКартинки", - Индекс);
		
		НайденныеИндексы = ТаблицаБазыКорреспондента.Строки.НайтиСтроки(Отбор, Истина);
		
		Для Каждого НайденныйИндекс Из НайденныеИндексы Цикл
			
			НайденныйИндекс.ИндексКартинки = НайденныйИндекс.ИндексКартинки + 1;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
