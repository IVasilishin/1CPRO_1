///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Устанавливает состояние оригинала для выделенных документов. Вызывается через подсистему "Подключаемые команды".
//
//	Параметры:
//	Ссылка - ДокументСсылка - ссылка на документ.
//	Параметры - Структура - параметры выполнения команды.
//
Процедура Подключаемый_УстановитьСостояниеОригинала(Ссылка, Параметры) Экспорт
	
	Если Не УчетОригиналовПервичныхДокументовВызовСервера.ПраваНаИзменениеСостояния() Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'У пользователя недостаточно прав на изменение состояния оригинала первичного документа'"));
		Возврат;
	КонецЕсли;
	
	Список = Параметры.Источник;
	
	Если Список.ВыделенныеСтроки.Количество() = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Не выделено ни одного документа, для которого можно установить выбранное состояние'"));
		Возврат;
	КонецЕсли;

	Если Параметры.ОписаниеКоманды.Вид = "УстановкаСостоянияОригиналПолучен" Тогда
		ИмяСостояния = ПредопределенноеЗначение("Справочник.СостоянияОригиналовПервичныхДокументов.ОригиналПолучен");
	Иначе
		ИмяСостояния = Параметры.ОписаниеКоманды.Представление;
	КонецЕсли;

	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Список",Список);

	Если Параметры.ОписаниеКоманды.Идентификатор = "НастройкаСостояний" Тогда
		ОткрытьФормуНастройкиСостояний();
		Возврат;
	ИначеЕсли Параметры.ОписаниеКоманды.Вид = "УстановкаСостоянияОригиналПолучен" И Список.ВыделенныеСтроки.Количество() = 1 Тогда
		ДополнительныеПараметры.Вставить("ИмяСостояния", ИмяСостояния);
		УстановитьСостояниеОригиналаЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);
		Возврат;
	КонецЕсли;

	ДополнительныеПараметры.Вставить("ИмяСостояния", ИмяСостояния);
	
	Если Список.ВыделенныеСтроки.Количество() > 1 Тогда
		ТекстВопроса = НСтр("ru='У выделенных в списке документов будет установлено состояние оригинала ""%ИмяСостояния%"". Продолжить?'");
		ТекстВопроса = СтрЗаменить(ТекстВопроса, "%ИмяСостояния%", ИмяСостояния);

		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.Да,НСтр("ru='Установить'"));
		Кнопки.Добавить(КодВозвратаДиалога.Нет,НСтр("ru='Не устанавливать'"));

		ПоказатьВопрос(Новый ОписаниеОповещения("УстановитьСостояниеОригиналаЗавершение", ЭтотОбъект, ДополнительныеПараметры), ТекстВопроса, Кнопки);
	ИначеЕсли УчетОригиналовПервичныхДокументовВызовСервера.ЭтоОбъектУчета(Список.ТекущиеДанные.Ссылка) Тогда 
		УстановитьСостояниеОригиналаЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);
	Иначе
		ПоказатьПредупреждение(, НСтр("ru = 'Для данного документа учет оригиналов не ведется.'"));
	КонецЕсли;
	
КонецПроцедуры

// Устанавливает состояние оригинала для выделенных документов. Вызывается без подключения подсистемы "Подключаемые команды".
//
//	Параметры:
//	Команда - Строка- имя выполняемой команды формы.
//	Форма - УправляемаяФорма - форма списка или документа.
//	Список - ЭлементФормы - список формы, в котором будет происходить изменение состояния.
//
Процедура УстановитьСостояниеОригинала(Команда, Форма, Список) Экспорт
	
	Если Не УчетОригиналовПервичныхДокументовВызовСервера.ПраваНаИзменениеСостояния() Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'У пользователя недостаточно прав на изменение состояния оригинала первичного документа'"));
		Возврат;
	КонецЕсли;

	Если Список.ВыделенныеСтроки.Количество() = 0 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Не выделено ни одного документа, для которого можно установить выбранное состояние'"));
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Список",Список);
	
	Если Команда = "НастройкаСостояний" Тогда
		ОткрытьФормуНастройкиСостояний();
		Возврат;
	ИначеЕсли Команда = "УстановитьОригиналПолучен" И Список.ВыделенныеСтроки.Количество()= 1 Тогда
		ДополнительныеПараметры.Вставить("ИмяСостояния", ПредопределенноеЗначение("Справочник.СостоянияОригиналовПервичныхДокументов.ОригиналПолучен"));
		УстановитьСостояниеОригиналаЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);
		Возврат;
	КонецЕсли;

	НайденноеСостояние = Форма.Элементы.Найти(Команда);

	Если Не НайденноеСостояние = Неопределено Тогда
		ИмяСостояния = НайденноеСостояние.Заголовок;
	ИначеЕсли Команда = "УстановитьОригиналПолучен" Тогда
		ИмяСостояния = ПредопределенноеЗначение("Справочник.СостоянияОригиналовПервичныхДокументов.ОригиналПолучен");
	КонецЕсли;

	ДополнительныеПараметры.Вставить("ИмяСостояния", ИмяСостояния);
	
	Если Список.ВыделенныеСтроки.Количество() > 1 Тогда
		ТекстВопроса = НСтр("ru='У выделенных в списке документов будет установлено состояние оригинала ""%ИмяСостояния%"". Продолжить?'");
		ТекстВопроса = СтрЗаменить(ТекстВопроса, "%ИмяСостояния%", ИмяСостояния);

		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.Да,НСтр("ru='Установить'"));
		Кнопки.Добавить(КодВозвратаДиалога.Нет,НСтр("ru='Не устанавливать'"));

		ПоказатьВопрос(Новый ОписаниеОповещения("УстановитьСостояниеОригиналаЗавершение", ЭтотОбъект, ДополнительныеПараметры), ТекстВопроса, Кнопки);
	ИначеЕсли УчетОригиналовПервичныхДокументовВызовСервера.ЭтоОбъектУчета(Список.ТекущиеДанные.Ссылка) Тогда 
		УстановитьСостояниеОригиналаЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);
	Иначе
		ПоказатьПредупреждение(, НСтр("ru = 'Для данного документа учет оригиналов не ведется.'"));
	КонецЕсли;
	
КонецПроцедуры

// Открывает на форме списка или документа выпадающие меню выбора состояния оригинала.
//
//	Параметры:
//	Форма - УправляемаяФорма - форма списка документов или документа.
//	Источник - ЭлементФормы - список или декорация формы, у которого будет открыт выпадающий список.
//
Процедура ОткрытьМенюВыбораСостояния(Форма, Источник) Экспорт 
		
	Если Не УчетОригиналовПервичныхДокументовВызовСервера.ПраваНаИзменениеСостояния() Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'У пользователя недостаточно прав на изменение состояния оригинала первичного документа'"));
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Источник) = Тип("ТаблицаФормы") Тогда
		ДанныеЗаписи = Источник.ТекущиеДанные;

		МассивСсылок = Новый Массив;
		МассивСсылок.Добавить(ДанныеЗаписи.Ссылка);

		НепроведенныеДокументы = ОбщегоНазначенияВызовСервера.ПроверитьПроведенностьДокументов(МассивСсылок);

		Если НепроведенныеДокументы.Количество() = 1 Тогда
			ПоказатьПредупреждение(,НСтр("ru = 'Для выполнения команды необходимо предварительно провести документ.'"));
			Возврат;
		Иначе
			МассивЗаписей = Новый Массив;
			МассивЗаписей.Добавить(ДанныеЗаписи);
			
			ОписаниеОповещения = Новый ОписаниеОповещения("ОткрытьМенюВыбораСостоянияЗавершение", ЭтотОбъект, МассивЗаписей);

			Если ДанныеЗаписи.ОбщееСостояние Или Не ЗначениеЗаполнено(ДанныеЗаписи.СостояниеОригиналаПервичногоДокумента) Тогда
				УточнитьПоПечатнымФормам = Форма.СписокВыбораСостоянийОригинала.НайтиПоЗначению("Уточнитьпопечатнымформам");
				Если УточнитьПоПечатнымФормам = Неопределено Тогда
					Форма.СписокВыбораСостоянийОригинала.Добавить("Уточнитьпопечатнымформам",НСтр("ru = 'Уточнить по печатным формам...'"),,БиблиотекаКартинок.УточнитьСостояниеОригиналаПервичногоДокументаПоПечатнымФормам);
				КонецЕсли;
				Форма.ПоказатьВыборИзМеню(ОписаниеОповещения,Форма.СписокВыбораСостоянийОригинала,Форма.Элементы.СостояниеОригиналаПервичногоДокумента);
			Иначе
				УточнитьПоПечатнымФормам = Форма.СписокВыбораСостоянийОригинала.НайтиПоЗначению("Уточнитьпопечатнымформам");
				Если УточнитьПоПечатнымФормам <> Неопределено Тогда
					Форма.СписокВыбораСостоянийОригинала.Удалить(УточнитьПоПечатнымФормам);
				КонецЕсли;
				Форма.ПоказатьВыборИзМеню(ОписаниеОповещения,Форма.СписокВыбораСостоянийОригинала,Форма.Элементы.СостояниеОригиналаПервичногоДокумента);
			КонецЕсли;

		КонецЕсли;
	Иначе
		Если Форма.Объект.Ссылка.Пустая() Тогда
			ПоказатьПредупреждение(,НСтр("ru = 'Для выполнения команды необходимо предварительно провести документ.'"));
			Возврат;
		Иначе
			МассивСсылок = Новый Массив;
			МассивСсылок.Добавить(Форма.Объект.Ссылка);

			НепроведенныеДокументы = ОбщегоНазначенияВызовСервера.ПроверитьПроведенностьДокументов(МассивСсылок);

			Если НепроведенныеДокументы.Количество() = 1 Тогда
				ПоказатьПредупреждение(,НСтр("ru = 'Для выполнения команды необходимо предварительно провести документ.'"));
				Возврат;
			Иначе
				ДополнительныеПараметры = Новый Структура("Ссылка", Форма.Объект.Ссылка);

				ОписаниеОповещения = Новый ОписаниеОповещения("ОткрытьМенюВыбораСостоянияЗавершение", ЭтотОбъект, ДополнительныеПараметры);

				УточнитьПоПечатнымФормам = Форма.СписокВыбораСостоянийОригинала.НайтиПоЗначению("Уточнитьпопечатнымформам");

				Если УточнитьПоПечатнымФормам = Неопределено Тогда
						Форма.СписокВыбораСостоянийОригинала.Добавить("Уточнитьпопечатнымформам",НСтр("ru = 'Уточнить по печатным формам...'"),,БиблиотекаКартинок.УточнитьСостояниеОригиналаПервичногоДокументаПоПечатнымФормам);
				КонецЕсли;

				Форма.ПоказатьВыборИзМеню(ОписаниеОповещения, Форма.СписокВыбораСостоянийОригинала, Источник);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

// Обработчик оповещения событий подсистемы "Учет оригиналов первичных документов" для формы документа.
//
//	Параметры:
//	ИмяСобытия - Строка - имя произошедшего события.
//	Форма - УправляемаяФорма - форма документа.
//
Процедура ОбработчикОповещенияФормаДокумента(ИмяСобытия, Форма) Экспорт           
		
	Если ИмяСобытия = "ИзменениеСостоянияОригиналаПервичногоДокумента" Тогда 
		СформироватьНадписьТекущегоСостоянияОригинала(Форма);
	ИначеЕсли ИмяСобытия = "ДобавлениеУдалениеСостоянияОригиналаПервичногоДокумента" Тогда			
		Форма.ОбновитьОтображениеДанных();	
	КонецЕсли;
		
КонецПроцедуры

// Обработчик оповещения событий подсистемы "Учет оригиналов первичных документов" для формы списка.
//
//	Параметры:
//	ИмяСобытия - Строка - имя произошедшего события.
//	Форма - УправляемаяФорма - форма списка документов.
//	Список - ЭлементФормы - основной список формы.
//
Процедура ОбработчикОповещенияФормаСписка(ИмяСобытия, Форма, Список) Экспорт 
	
	Если ИмяСобытия = "ДобавлениеУдалениеСостоянияОригиналаПервичногоДокумента" Тогда
		СтруктураПоиска = Новый Структура;
 		СтруктураПоиска.Вставить("СписокВыбораСостоянийОригинала", Неопределено);
 		ЗаполнитьЗначенияСвойств(СтруктураПоиска, Форма);
 		Если СтруктураПоиска.СписокВыбораСостоянийОригинала<> Неопределено Тогда
			Форма.ОтключитьОбработчикОжидания("Подключаемый_ОбновитьКомандыСостоянияОригинала");
			Форма.ПодключитьОбработчикОжидания("Подключаемый_ОбновитьКомандыСостоянияОригинала", 0.2, Истина);
			УчетОригиналовПервичныхДокументовВызовСервера.ЗаполнитьСписокВыбораСостоянийОригинала(Форма.СписокВыбораСостоянийОригинала);
			Форма.ОбновитьОтображениеДанных();
		Иначе
			Возврат;
		КонецЕсли;
	ИначеЕсли ИмяСобытия = "ИзменениеСостоянияОригиналаПервичногоДокумента" Тогда
		Список.Обновить();
	КонецЕсли;

КонецПроцедуры

// Обработчик события "Выбор" списка.
//
//	Параметры:
//	ИмяПоля - Строка - наименование выбранного поля.
//	Форма - УправляемаяФорма - форма списка документов.
//	Список - ЭлементФормы - основной список формы.
//  СтандартнаяОбработка - Булево - Истина, если в форме используется стандартная обработка события "Выбор"
//
Процедура СписокВыбор(ИмяПоля, Форма, Список, СтандартнаяОбработка) Экспорт 
	
	Если ИмяПоля = "СостояниеОригиналаПервичногоДокумента" Или ИмяПоля = "СостояниеОригиналПолучен" Тогда
		СтандартнаяОбработка = Ложь;
		Если Не УчетОригиналовПервичныхДокументовВызовСервера.ПраваНаИзменениеСостояния() Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'У пользователя недостаточно прав на изменение состояния оригинала первичного документа'"));
			Возврат;
		КонецЕсли;
			Если УчетОригиналовПервичныхДокументовВызовСервера.ЭтоОбъектУчета(Список.ТекущиеДанные.Ссылка) Тогда
			Если ИмяПоля = "СостояниеОригиналаПервичногоДокумента" Тогда
				ОткрытьМенюВыбораСостояния(Форма, Список);
			ИначеЕсли ИмяПоля = "СостояниеОригиналПолучен" Тогда
				УстановитьСостояниеОригинала("УстановитьОригиналПолучен", Форма, Список);
			КонецЕсли;
		Иначе
			ПоказатьПредупреждение(, НСтр("ru = 'Для данного документа учет оригиналов не ведется.'"));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Процедура обрабатывает действия по учету оригиналов после сканирования штрихкода документа.
//
//	Параметры:
//	Штрихкод - Строка - отсканированный штрихкод документа.
//	ИмяСобытия - Строка - имя события формы.
//
Процедура ОбработатьШтрихкод(Штрихкод, ИмяСобытия) Экспорт
	
	Если ИмяСобытия = "ScanData" Тогда
		Состояние(НСтр("ru = 'Выполняется установка состояния оригинала по штрихкоду...'"));
		УчетОригиналовПервичныхДокументовВызовСервера.ОбработатьШтрихкод(Штрихкод[0]);
	КонецЕсли;
	
КонецПроцедуры

// Процедура показывает пользователю оповещение об изменении состояний оригинала документа.
//
//	Параметры:
//	КоличествоОбработанных - Число - количество успешно обработанных документов.
//	ДокументСсылка - ДокументСсылка - ссылка на документ для обработки нажатия на оповещение пользователя 
//		в случае единичной установки состояния, необязательный параметр.
//	ИмяСостояния - Строка - устанавливаемое состояние.
//
Процедура ОповеститьПользователяОбУстановкеСостояний(КоличествоОбработанных, ДокументСсылка = Неопределено, ИмяСостояния = Неопределено) Экспорт

	Если КоличествоОбработанных > 1 Тогда
		ТекстСообщения = НСтр("ru='Для всех выделенных в списке документов установлено состояние оригинала ""%ИмяСостояния%""'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ИмяСостояния%", ИмяСостояния);
		
		ТекстЗаголовка = НСтр("ru='Состояние оригинала ""%ИмяСостояния%"" установлено'");
		ТекстЗаголовка = СтрЗаменить(ТекстЗаголовка, "%ИмяСостояния%", ИмяСостояния);

		ПоказатьОповещениеПользователя(ТекстЗаголовка,, ТекстСообщения, БиблиотекаКартинок.Информация32,СтатусОповещенияПользователя.Важное);
	Иначе
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработатьНажатиеНаОповещение",ЭтотОбъект,ДокументСсылка);
		ПоказатьОповещениеПользователя(НСтр("ru = 'Изменение состояния оригинала:'"),ОписаниеОповещения,ДокументСсылка,БиблиотекаКартинок.Информация32,СтатусОповещенияПользователя.Важное);
	КонецЕсли;

КонецПроцедуры

// Открывает форму списка справочника "СостоянияОригиналовПервичныхДокументов".
Процедура ОткрытьФормуНастройкиСостояний() Экспорт
	
	ОткрытьФорму("Справочник.СостоянияОригиналовПервичныхДокументов.ФормаСписка");

КонецПроцедуры

// Вызывается для записи состояний оригиналов печатных форм в регистр, после печати формы.
//
//	Параметры:
//	ОбъектыПечати - СписокЗначений - список ссылок на объекты печати.
//	СписокПечати - СписокЗначений - список с именами макетов и представлениями печатных форм.
// 	Записано - Булево - признак того, что состояние документа записано в регистр.
//
Процедура ЗаписатьСостоянияОригиналовПослеПечати(ОбъектыПечати, СписокПечати, Записано = Ложь) Экспорт

	УчетОригиналовПервичныхДокументовВызовСервера.ЗаписатьСостоянияОригиналовПослеПечати(ОбъектыПечати,СписокПечати, Записано);
	
	Если Записано = Ложь Тогда
		Возврат
	КонецЕсли;
	
	Оповестить("ИзменениеСостоянияОригиналаПервичногоДокумента");
	
	Если ОбъектыПечати.Количество() > 1 Тогда
		ОповеститьПользователяОбУстановкеСостояний(ОбъектыПечати.Количество(),,ПредопределенноеЗначение("Справочник.СостоянияОригиналовПервичныхДокументов.ФормаНапечатана"));
	ИначеЕсли ОбъектыПечати.Количество() = 1 Тогда
		ОповеститьПользователяОбУстановкеСостояний(1,ОбъектыПечати[0].Значение,ПредопределенноеЗначение("Справочник.СостоянияОригиналовПервичныхДокументов.ФормаНапечатана"));
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму уточнения состояний печатных форм документа.
//
//	Параметры:
//	ДокументСсылка - СсылкаДокумент - ссылка на документ,для которого необходимо получить ключ записи общего состояния.
//
Процедура ОткрытьФормуИзмененияСостоянийПечатныхФорм(ДокументСсылка) Экспорт

	КлючЗаписиРегистра = УчетОригиналовПервичныхДокументовВызовСервера.КлючЗаписиОбщегоСостояния(ДокументСсылка);
	
	ПередаваемыеПараметры = Новый Структура;
	
	Если КлючЗаписиРегистра = Неопределено Тогда
		ПередаваемыеПараметры.Вставить("Ссылка",ДокументСсылка);
		ОткрытьФорму("РегистрСведений.СостоянияОригиналовПервичныхДокументов.Форма.ИзменениеСостоянийОригиналовПервичныхДокументов",ПередаваемыеПараметры);
	Иначе
		ПередаваемыеПараметры.Вставить("Ключ", КлючЗаписиРегистра);
		ОткрытьФорму("РегистрСведений.СостоянияОригиналовПервичныхДокументов.Форма.ИзменениеСостоянийОригиналовПервичныхДокументов",ПередаваемыеПараметры);
	КонецЕсли;

КонецПроцедуры

// Вызывается при открытии журнала оригиналов первичных документов в случае использования подключаемого оборудования.
// Позволяет определить собственный процесс подключения подключаемого оборудования к журналу
//	
//	Параметры:
//	Форма - УправляемаяФорма - форма списка документа.
//
Процедура ПриПодключенииСканераШтрихкода(Форма) Экспорт

	УчетОригиналовПервичныхДокументовКлиентПереопределяемый.ПриПодключенииСканераШтрихкода(Форма);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует надпись для вывода информации о текущем состоянии на форму документа.
//
//	Параметры:
//	Форма - УправляемаяФорма - форма списка документа.
//
Процедура СформироватьНадписьТекущегоСостоянияОригинала(Форма)
	
	Если Не Форма.Элементы.Найти("ДекорацияСостояниеОригинала") = Неопределено Тогда 
		Если ЗначениеЗаполнено(Форма.Объект.Ссылка) Тогда
			ТекущиеСостояниеОригинала = УчетОригиналовПервичныхДокументовВызовСервера.СведенияОСостоянииОригиналаПоСсылке(Форма.Объект.Ссылка);
			Если ПустаяСтрока(ТекущиеСостояниеОригинала) Тогда
				ТекущиеСостояниеОригинала=НСтр("ru='<Состояние оригинала неизвестно>'");
				Форма.Элементы.ДекорацияСостояниеОригинала.ЦветТекста = WebЦвета.Серебряный;
			Иначе
				ТекущиеСостояниеОригинала = ТекущиеСостояниеОригинала.СостояниеОригиналаПервичногоДокумента;
				Форма.Элементы.ДекорацияСостояниеОригинала.ЦветТекста = Новый Цвет();
			КонецЕсли;
		Иначе
			Форма.Элементы.ДекорацияСостояниеОригинала.ЦветТекста = WebЦвета.Серебряный;
		КонецЕсли;

		Форма.Элементы.ДекорацияСостояниеОригинала.Заголовок = ТекущиеСостояниеОригинала;
	КонецЕсли;
	
КонецПроцедуры

// Обработчик оповещения, вызванного после завершения работы процедуры УстановитьСостояниеОригинала(...).
Процедура УстановитьСостояниеОригиналаЗавершение(Ответ, ДополнительныеПараметры) Экспорт

	Если Ответ = КодВозвратаДиалога.Да Тогда
		Список = ДополнительныеПараметры.Список;
		ИмяСостояния = ДополнительныеПараметры.ИмяСостояния;

		Если Список.ВыделенныеСтроки.Количество() = 0 Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'Не выделено ни одного документа, для которого можно установить выбранное состояние'"));
			Возврат;
		Иначе
			МассивСтрок = Новый Массив;
			Для Каждого СтрокаСписка Из Список.ВыделенныеСтроки Цикл
				ДанныеСтроки = Список.ДанныеСтроки(СтрокаСписка);
				МассивСтрок.Добавить(ДанныеСтроки);
			КонецЦикла;
		КонецЕсли;
		
		ОбъектыЗаписи = УчетОригиналовПервичныхДокументовВызовСервера.ВозможностьЗаписиОбъектов(МассивСтрок);
		
		Если Не ТипЗнч(ОбъектыЗаписи)= Тип("Массив") Тогда
			ПоказатьПредупреждение(,НСтр("ru = 'Для выполнения команды необходимо предварительно провести все выделенные документы.'"));
			Возврат;
		Иначе
			Изменено = Ложь;
			
			УчетОригиналовПервичныхДокументовВызовСервера.УстановитьНовоеСостояниеОригинала(ОбъектыЗаписи,ИмяСостояния,Изменено);

			Если ОбъектыЗаписи.Количество() = 1 И Изменено Тогда 
				ОповеститьПользователяОбУстановкеСостояний(1,ОбъектыЗаписи[0].Ссылка);
			ИначеЕсли Изменено Тогда
				ОповеститьПользователяОбУстановкеСостояний(ОбъектыЗаписи.Количество(),,ИмяСостояния);
			КонецЕсли;
			
			Если Изменено Тогда
			Оповестить("ИзменениеСостоянияОригиналаПервичногоДокумента");
			КонецЕсли;
		КонецЕсли;

	Иначе
		Возврат;
	КонецЕсли;

КонецПроцедуры

// Обработчик оповещения, вызванного после завершения работы процедуры ОткрытьМенюВыбораСостояния(...).
//	
//	Параметры:
//  ВыбранноеСостояниеИзСписка - Строка - выбранное пользователем состояние оригинала.
//  ДополнительныеПараметры - Структура - сведения необходимые для установки состояния оригинала:
//       	                   * Ссылка - ЛюбаяСсылка - ссылка на документ для установки состояния оригинала.
//       	                - Массив из Структура:
//                             * Ссылка - ЛюбаяСсылка - ссылка на документ для установки состояния оригинала
//
Процедура ОткрытьМенюВыбораСостоянияЗавершение(ВыбранноеСостояниеИзСписка, ДополнительныеПараметры) Экспорт

	Изменено = Ложь;
	
	Если Не ВыбранноеСостояниеИзСписка = Неопределено Тогда
		Если ТипЗнч(ДополнительныеПараметры)= Тип("Массив")Тогда
			Если ВыбранноеСостояниеИзСписка.Значение = "Уточнитьпопечатнымформам" Тогда
				ОткрытьФормуИзмененияСостоянийПечатныхФорм(ДополнительныеПараметры[0].Ссылка);
			Иначе
				УчетОригиналовПервичныхДокументовВызовСервера.УстановитьНовоеСостояниеОригинала(ДополнительныеПараметры,ВыбранноеСостояниеИзСписка.Значение, Изменено);
				Если Изменено Тогда
					ОповеститьПользователяОбУстановкеСостояний(1,ДополнительныеПараметры[0].Ссылка,ВыбранноеСостояниеИзСписка.Значение);
					Оповестить("ИзменениеСостоянияОригиналаПервичногоДокумента");
				КонецЕсли;
			КонецЕсли;
		Иначе
			Если ВыбранноеСостояниеИзСписка.Значение = "Уточнитьпопечатнымформам" Тогда
				ОткрытьФормуИзмененияСостоянийПечатныхФорм(ДополнительныеПараметры.Ссылка);
			Иначе
				УчетОригиналовПервичныхДокументовВызовСервера.УстановитьНовоеСостояниеОригинала(ДополнительныеПараметры.Ссылка,ВыбранноеСостояниеИзСписка.Значение, Изменено);
				Если Изменено Тогда
					ОповеститьПользователяОбУстановкеСостояний(1,ДополнительныеПараметры.Ссылка,ВыбранноеСостояниеИзСписка.Значение);
					Оповестить("ИзменениеСостоянияОригиналаПервичногоДокумента");
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	Иначе
		Возврат;

	КонецЕсли;

КонецПроцедуры

// Обработчик оповещения, вызванного после завершения работы процедуры ОповеститьПользователяОбУстановкеСостояний(...).
Процедура ОбработатьНажатиеНаОповещение(ДополнительныеПараметры) Экспорт

	ПоказатьЗначение(,ДополнительныеПараметры);

КонецПроцедуры

#КонецОбласти
