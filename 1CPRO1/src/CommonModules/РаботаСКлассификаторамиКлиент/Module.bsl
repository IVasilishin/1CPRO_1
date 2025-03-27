///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "ИнтернетПоддержкаПользователей.РаботаСКлассификаторами".
// ОбщийМодуль.РаботаСКлассификаторамиКлиент.
//
// Клиентские процедуры и функции загрузки классификаторов:
//  - обработка событий панели Интернет-поддержка и сервисы;
//  - переход к интерактивному обновлению классификаторов;
//  - настройка автоматической загрузки обновлений классификаторов;
//  - оповещение об изменении данных классификаторов.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Открывает помощник обновления классификаторов.
//
Процедура ОбновитьКлассификаторы() Экспорт
	
	ОткрытьФорму("Обработка.ОбновлениеКлассификаторов.Форма.Форма");
	
КонецПроцедуры

// Определяет имя события, которое будет содержать оповещение
// о завершении загрузки классификаторов.
//
// Возвращаемое значение:
//  Строка - Имя события. Может быть использовано для идентификации
//           сообщений принимающими их формами.
//
Функция ИмяСобытияОповещенияОЗагрузки() Экспорт
	
	Возврат "РаботаСКлассификаторами.ЗагруженыКлассификаторы";
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.НастройкиПрограммы

// Выполняет обработку оповещения на панели администрирования
// "Интернет-поддержка и сервисы" (БСП).
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма, в которой обрабатывается оповещение;
//	ИмяСобытия - Строка - имя события;
//	Параметр - Произвольный - параметр;
//	Источник - Произвольный - источник события.
//
Процедура ИнтернетПоддержкаИСервисы_ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	Результат = РаботаСКлассификаторамиВызовСервера.НастройкиОбновленияКлассификаторов();
	
	Если ИмяСобытия = "ИнтернетПоддержкаОтключена" Тогда
		Если Результат.ВариантОбновления = 1 Тогда
			Форма.Элементы.БИПДекорацияОбновлениеКлассификаторовНеВыполняется.Видимость = Истина;
		КонецЕсли;
	ИначеЕсли ИмяСобытия = "ИнтернетПоддержкаПодключена" Тогда
		Если Результат.Расписание <> Неопределено Тогда
			Форма.Элементы.ДекорацияРасписаниеОбновленияКлассификаторов.Заголовок =
				ИнтернетПоддержкаПользователейКлиентСервер.ПредставлениеРасписания(
				Результат.Расписание);
		КонецЕсли;
		Форма.БИПВариантОбновленияКлассификаторов = Результат.ВариантОбновления;
		Форма.Элементы.БИПДекорацияОбновлениеКлассификаторовНеВыполняется.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Обработчик команды БИПОбновлениеКлассификаторов
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Команда - КомандаФормы - команда на панели администрирования.
//
Процедура ИнтернетПоддержкаИСервисы_ОбновлениеКлассификаторов(Форма, Команда) Экспорт
	
	ОбновитьКлассификаторы();
	
КонецПроцедуры

// Обработчик команды БИПФайлКлассификаторовНачалоВыбора
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Элемент - ЭлементФормы - поле ввода информации;
//  ДанныеВыбора - СписокЗначение - параметр данных выбора;
//  СтандартнаяОбработка - Булево - признак стандартной обработки.
//
Процедура ИнтернетПоддержкаИСервисы_БИПФайлКлассификаторовНачалоВыбора(
			Форма,
			Элемент,
			ДанныеВыбора,
			СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораФайла.Заголовок = НСтр("ru = 'Выберите файл с классификаторами'");
	ДиалогВыбораФайла.Фильтр    = НСтр("ru = 'Файл классификаторов (*.zip)|*.zip'");
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ФайлКлассификаторовПослеВыбораФайла",
		ЭтотОбъект,
		ДополнительныеПараметры);
	
	ДиалогВыбораФайла.Показать(ОписаниеОповещения);
	
КонецПроцедуры

// Обработчик события при изменении элемента формы БИПВариантОбновленияКлассификаторов
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Элемент - ЭлементФормы - поле ввода информации;
//
Процедура ИнтернетПоддержкаИСервисы_БИПФайлКлассификаторовПриИзменении(
			Форма,
			Элемент) Экспорт
	
	РаботаСКлассификаторамиВызовСервера.УстановитьФайлКлассификаторов(
		Форма.БИПФайлКлассификаторов);
	
КонецПроцедуры

// Обработчик события при изменении элемента формы БИПВариантОбновленияКлассификаторов
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Элемент - ЭлементФормы - поле ввода информации;
//
Процедура ИнтернетПоддержкаИСервисы_БИПВариантОбновленияКлассификаторовПриИзменении(
			Форма,
			Элемент) Экспорт
		
	Если Форма.БИПВариантОбновленияКлассификаторов = 1
		И Форма.БИПДанныеАутентификации = Неопределено Тогда
		
		Если Не ИнтернетПоддержкаПользователейКлиент.ДоступноПодключениеИнтернетПоддержки() Тогда
			ПоказатьПредупреждение(,
				НСтр("ru = 'Для автоматического обновления классификаторов необходимо
					|подключить Интернет-поддержку пользователей.'"));
			Возврат;
		КонецЕсли;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Форма", Форма);
		
		ОписаниеОповещения = Новый ОписаниеОповещения(
			"ПриОтветеНаВопросПодключенияИнтернетПоддержки",
			ЭтотОбъект,
			ДополнительныеПараметры);
		
		Ответы = Новый СписокЗначений;
		Ответы.Добавить(КодВозвратаДиалога.Да, НСтр("ru = 'Подключить'"));
		Ответы.Добавить(КодВозвратаДиалога.Отмена, НСтр("ru = 'Отмена'"));
		
		ПоказатьВопрос(
			ОписаниеОповещения,
			НСтр("ru = 'Для автоматического обновления классификаторов необходимо
				|подключить Интернет-поддержку пользователей.'"),
			Ответы);
			
		Возврат;
	Иначе
		Форма.Элементы.БИПДекорацияОбновлениеКлассификаторовНеВыполняется.Видимость = Ложь;
	КонецЕсли;
	
	РаботаСКлассификаторамиВызовСервера.УстановитьВариантОбновленияКлассификаторов(
		Форма.БИПВариантОбновленияКлассификаторов);
	Форма.БИПВариантОбновленияКлассификаторовПредыдущееЗначение =
		Форма.БИПВариантОбновленияКлассификаторов;
	
КонецПроцедуры

// Обработчик события нажатие элемента формы ДекорацияРасписаниеОбновленияКлассификаторов
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Элемент - ЭлементФормы - поле ввода информации;
//
Процедура ИнтернетПоддержкаИСервисы_ДекорацияРасписаниеОбновленияКлассификаторовНажатие(
		Форма,
		Элемент) Экспорт
	
	Результат = РаботаСКлассификаторамиВызовСервера.НастройкиОбновленияКлассификаторов();
	Если Результат.Расписание <> Неопределено Тогда
		ДиалогРасписание = Новый ДиалогРасписанияРегламентногоЗадания(Результат.Расписание);
	Иначе
		ДиалогРасписание = Новый ДиалогРасписанияРегламентногоЗадания(Новый РасписаниеРегламентногоЗадания);
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПриИзмененииРасписания",
		ЭтотОбъект,
		Форма);
	
	ДиалогРасписание.Показать(ОписаниеОповещения);
	
КонецПроцедуры

// Обработчик события навигационной ссылки формы БИПДекорацияОбновлениеКлассификаторовНеВыполняетсяОбработкаНавигационнойСсылки
// на форме панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма панели администрирования;
//  Элемент - ЭлементФормы - поле ввода информации;
//  НавигационнаяСсылкаФорматированнойСтроки - Строка - навигационная ссылка;
//  СтандартнаяОбработка - Булево - признак стандартной обработки ссылки.
//
Процедура ИнтернетПоддержкаИСервисы_БИПДекорацияОбновлениеКлассификаторовНеВыполняетсяОбработкаНавигационнойСсылки(
		Форма,
		Элемент,
		НавигационнаяСсылкаФорматированнойСтроки,
		СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если Не ИнтернетПоддержкаПользователейКлиент.ДоступноПодключениеИнтернетПоддержки() Тогда
		ПоказатьПредупреждение(,
			НСтр("ru = 'Для автоматического обновления классификаторов необходимо
				|подключить Интернет-поддержку пользователей.'"));
		Возврат;
	КонецЕсли;
	
	ИнтернетПоддержкаПользователейКлиент.ПодключитьИнтернетПоддержкуПользователей(
		Неопределено,
		Форма);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.НастройкиПрограммы

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Определяет идентификаторы и номера версий, которые содержит файла с обновлениями.
//
// Параметры:
//  ИмяФайла - Строка - расположение архива с классификаторами.
//
// Возвращаемое значение:
//  Массив - содержит идентификаторы классификаторов и номер версий.
//
Функция ВерсииКлассификаторовВФайле(ИмяФайла) Экспорт
	
	#Если Не ВебКлиент Тогда
	
	ВерсииКлассификаторов = Новый Массив;
	
	Если ОбщегоНазначенияКлиентСервер.ПолучитьРасширениеИмениФайла(ИмяФайла) <> "zip" Тогда
		Возврат ВерсииКлассификаторов;
	КонецЕсли;
	
	ЧтениеZipФайла = Новый ЧтениеZipФайла(ИмяФайла);
	Для Каждого Элемент Из ЧтениеZipФайла.Элементы Цикл
		
		// Зашифрованные элементы архива не обрабатываются.
		Если Элемент.Зашифрован Тогда
			Продолжить;
		КонецЕсли;
		
		ПозицияРазделителя = СтрНайти(Элемент.ИмяБезРасширения, "_", НаправлениеПоиска.СКонца);
		
		// Если имя файла не соответствует шаблону [Идентификатор]_[Версия], подсистема не должна
		// выполнять его обработку.
		Если ПозицияРазделителя = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			Версия        = Число(СтрЗаменить(Сред(Элемент.ИмяБезРасширения, ПозицияРазделителя + 1), Символы.НПП, ""));
			Идентификатор = Лев(Элемент.ИмяБезРасширения, ПозицияРазделителя - 1);
		Исключение
			Версия = Неопределено;
			Идентификатор = Неопределено
		КонецПопытки;
		
		// Если имя файла содержит не корректные данные, подсистема не должна
		// выполнять его обработку.
		Если Не ЗначениеЗаполнено(Идентификатор) Или Не ЗначениеЗаполнено(Версия) Тогда
			Продолжить;
		КонецЕсли;
		
		ОписаниеВерсии = Новый Структура;
		ОписаниеВерсии.Вставить("Идентификатор", Идентификатор);
		ОписаниеВерсии.Вставить("Версия",        Версия);
		ОписаниеВерсии.Вставить("Имя",           Элемент.Имя);
		ВерсииКлассификаторов.Добавить(ОписаниеВерсии);
		
	КонецЦикла;
	
	ЧтениеZipФайла.Закрыть();
	
	Возврат ВерсииКлассификаторов;
	
	#Иначе
	
	ВызватьИсключение НСтр("ru = 'Интерактивная загрузка архива с классификаторами при работе в веб-клиенте запрещена.'");
	
	#КонецЕсли
	
КонецФункции

// Заполняет выбранный файл классификаторов на форме
// панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  ВыбранныеФайлы - Массив, Неопределено - содержит файлы выбранные в диалоге;
//  ДополнительныеПараметры - Структура - дополнительные параметры выбора.
//
Процедура ФайлКлассификаторовПослеВыбораФайла(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ВыбранныеФайлы.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры.Форма.БИПФайлКлассификаторов = ВыбранныеФайлы[0];
	РаботаСКлассификаторамиВызовСервера.УстановитьФайлКлассификаторов(
		ДополнительныеПараметры.Форма.БИПФайлКлассификаторов);
	
КонецПроцедуры

// Обрабатывает результат ответа на предложение подключения Интернет поддержки-пользователей на форме
// панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Результат - КодВозвратаДиалога - содержит ответ пользователя;
//  ДополнительныеПараметры - Структура - дополнительные параметры вопроса.
//
Процедура ПриОтветеНаВопросПодключенияИнтернетПоддержки(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения(
			"ПослеПодключенияИнтернетПоддержки",
			ЭтотОбъект,
			ДополнительныеПараметры);
		ИнтернетПоддержкаПользователейКлиент.ПодключитьИнтернетПоддержкуПользователей(
			ОписаниеОповещения,
			ДополнительныеПараметры.Форма);
	Иначе
		ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторов =
			ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторовПредыдущееЗначение;
	КонецЕсли;
	
КонецПроцедуры

// Обрабатывает результат подключения Интернет поддержки-пользователей на форме
// панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Результат - Структура, Неопределено - содержит результат ввода данных аутентификации;
//  ДополнительныеПараметры - Структура - дополнительные параметры ввода данных аутентификации.
//
Процедура ПослеПодключенияИнтернетПоддержки(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторов =
			ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторовПредыдущееЗначение;
	КонецЕсли;
	
	РаботаСКлассификаторамиВызовСервера.УстановитьВариантОбновленияКлассификаторов(
		ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторов);
	ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторовПредыдущееЗначение =
		ДополнительныеПараметры.Форма.БИПВариантОбновленияКлассификаторов;
	
КонецПроцедуры

// Заполняет представление расписание регламентного задания на форме
// панели администрирования "Интернет-поддержка и сервисы"
// Библиотеки стандартных подсистем.
//
// Параметры:
//  Расписание - РасписаниеРегламентногоЗадания, Неопределено - содержит результат заполнения расписания;
//  ДополнительныеПараметры - Структура - дополнительные параметры ввода расписания.
//
Процедура ПриИзмененииРасписания(Расписание, Форма) Экспорт
	
	Если Расписание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПериодПовтораВТечениеДня = Расписание.ПериодПовтораВТечениеДня;
	Если ПериодПовтораВТечениеДня > 0
		И ПериодПовтораВТечениеДня < 300 Тогда
		ПоказатьПредупреждение(,
			НСтр("ru = 'Интервал обновления не может быть задан чаще, чем один раз 5 минут.'"));
		Возврат;
	КонецЕсли;
	
	Элементы = Форма.Элементы;
	
	Элементы.ДекорацияРасписаниеОбновленияКлассификаторов.Заголовок =
		ИнтернетПоддержкаПользователейКлиентСервер.ПредставлениеРасписания(Расписание);
	
	РаботаСКлассификаторамиВызовСервера.ЗаписатьРасписаниеОбновления(Расписание);
	
КонецПроцедуры

// Возвращает имя события для журнала регистрации
//
// Возвращаемое значение:
//  Строка - имя события.
//
Функция ИмяСобытияЖурналаРегистрации() Экспорт
	
	Возврат НСтр("ru = 'Работа с классификаторами'",
		ОбщегоНазначенияКлиент.КодОсновногоЯзыка());
	
КонецФункции

#КонецОбласти
