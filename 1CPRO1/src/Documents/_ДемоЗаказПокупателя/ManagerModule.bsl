///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ТекущиеДела

// См. ТекущиеДелаПереопределяемый.ПриОпределенииОбработчиковТекущихДел.
// 
// Параметры:
//  ТекущиеДела - см. ТекущиеДелаСлужебный.ТекущиеДела
//
Процедура ПриЗаполненииСпискаТекущихДел(ТекущиеДела) Экспорт
	
	Если Не ПравоДоступа("Редактирование", Метаданные.Документы._ДемоЗаказПокупателя) Тогда
		Возврат;
	КонецЕсли;
	
	КоличествоЗаказовПокупателя = КоличествоЗаказовПокупателя();
	
	СписокОтбора = Новый СписокЗначений;
	СписокОтбора.Добавить(Перечисления._ДемоСтатусыЗаказовПокупателей.НеСогласован);
	СписокОтбора.Добавить(Перечисления._ДемоСтатусыЗаказовПокупателей.Согласован);
	
	ОтборПоСтатусу = Новый Структура("СтатусЗаказа", СписокОтбора);
	
	ИдентификаторЗаказыПокупателя = "ЗаказыПокупателя";
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = ИдентификаторЗаказыПокупателя;
	Дело.ЕстьДела       = КоличествоЗаказовПокупателя.Всего > 0;
	Дело.Представление  = НСтр("ru = 'Заказы покупателя'");
	Дело.Количество     = КоличествоЗаказовПокупателя.Всего;
	Дело.Форма          = "Документ._ДемоЗаказПокупателя.Форма.ФормаСписка";
	Дело.ПараметрыФормы = Новый Структура("Отбор", ОтборПоСтатусу);
	Дело.Владелец       = Метаданные.Подсистемы._ДемоОрганайзер;
	
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = "ЗаказыПокупателяНеСогласовано";
	Дело.ЕстьДела       = КоличествоЗаказовПокупателя.НеСогласовано > 0;
	Дело.Важное         = Истина;
	Дело.Представление  = НСтр("ru = 'Не согласовано'");
	Дело.Количество     = КоличествоЗаказовПокупателя.НеСогласовано;
	Дело.Владелец       = ИдентификаторЗаказыПокупателя;
	
	Дело = ТекущиеДела.Добавить();
	Дело.Идентификатор  = "ЗаказыПокупателяСогласовано";
	Дело.ЕстьДела       = КоличествоЗаказовПокупателя.Согласовано > 0;
	Дело.Представление  = НСтр("ru = 'Согласовано'");
	Дело.Количество     = КоличествоЗаказовПокупателя.Согласовано;
	Дело.Владелец       = ИдентификаторЗаказыПокупателя;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ТекущиеДела

// СтандартныеПодсистемы.ШаблоныСообщений

// Вызывается при подготовке шаблонов сообщений и позволяет переопределить список реквизитов и вложений.
//
// Параметры:
//  Реквизиты               - ДеревоЗначений - список реквизитов шаблона:
//         ** Имя            - Строка - уникальное имя общего реквизита.
//         ** Представление  - Строка - представление общего реквизита.
//         ** Тип            - Тип    - тип реквизита. По умолчанию строка.
//         ** Формат         - Строка - формат вывода значения для чисел, дат, строк и булевых значений.
//  Вложения                - ТаблицаЗначений - печатные формы и вложения:
//         ** Имя            - Строка - уникальное имя вложения.
//         ** Представление  - Строка - представление варианта.
//         ** ТипФайла       - Строка - тип вложения, который соответствует расширению файла: "pdf", "png", "jpg", mxl"
//                                      и др.
//  ДополнительныеПараметры - Структура - дополнительные сведения о шаблоне сообщений.
//
Процедура ПриПодготовкеШаблонаСообщения(Реквизиты, Вложения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Вызывается в момент создания сообщений по шаблону для заполнения значений реквизитов и вложений.
//
// Параметры:
//  Сообщение - Структура:
//    * ЗначенияРеквизитов - Соответствие - список используемых в шаблоне реквизитов:
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * ЗначенияОбщихРеквизитов - Соответствие - список используемых в шаблоне общих реквизитов:
//      ** Ключ     - Строка - имя реквизита в шаблоне;
//      ** Значение - Строка - значение заполнения в шаблоне.
//    * Вложения - Соответствие:
//      ** Ключ     - Строка - имя вложения в шаблоне;
//      ** Значение - ДвоичныеДанные
//                  - Строка - двоичные данные или адрес во временном хранилище вложения.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект являющийся источником данных.
//  ДополнительныеПараметры - Структура -  дополнительная информация о шаблоне сообщения.
//
Процедура ПриФормированииСообщения(Сообщение, ПредметСообщения, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

// Заполняет список получателей SMS при отправке сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиSMS - ТаблицаЗначений:
//     * НомерТелефона - Строка - номер телефона, куда будет отправлено сообщение SMS;
//     * Представление - Строка - представление получателя сообщения SMS;
//     * Контакт       - Произвольный - контакт, которому принадлежит номер телефона.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект, являющийся источником данных.
//                   - Структура  - структура описывающая параметры шаблона:
//    * Предмет               - ЛюбаяСсылка - ссылка на объект, являющийся источником данных;
//    * ВидСообщения - Строка - вид формируемого сообщения: "ЭлектроннаяПочта" или "СообщениеSMS";
//    * ПроизвольныеПараметры - Соответствие - заполненный список произвольных параметров;
//    * ОтправитьСразу - Булево - признак мгновенной отправки;
//    * ПараметрыСообщения - Структура - дополнительные параметры сообщения.
//
Процедура ПриЗаполненииТелефоновПолучателейВСообщении(ПолучателиSMS, ПредметСообщения) Экспорт
	ШаблоныСообщений.ЗаполнитьПолучателей(ПолучателиSMS, ПредметСообщения, "Контрагент", Перечисления.ТипыКонтактнойИнформации.Телефон);
КонецПроцедуры

// Заполняет список получателей почты при отправке сообщения сформированного по шаблону.
//
// Параметры:
//   ПолучателиПисьма - ТаблицаЗначений - список получается письма:
//     * Адрес           - Строка - адрес электронной почты получателя;
//     * Представление   - Строка - представление получателя письма;
//     * Контакт         - Произвольный - контакт, которому принадлежит адрес электронной почты.
//  ПредметСообщения - ЛюбаяСсылка - ссылка на объект, являющийся источником данных.
//                   - Структура  - структура описывающая параметры шаблона:
//    * Предмет               - ЛюбаяСсылка - ссылка на объект, являющийся источником данных;
//    * ВидСообщения - Строка - вид формируемого сообщения: "ЭлектроннаяПочта" или "СообщениеSMS";
//    * ПроизвольныеПараметры - Соответствие - заполненный список произвольных параметров;
//    * ОтправитьСразу - Булево - признак мгновенной отправки письма;
//    * ПараметрыСообщения - Структура - дополнительные параметры сообщения;
//    * ПреобразовыватьHTMLДляФорматированногоДокумента - Булево - признак преобразование HTML текста
//             сообщения содержащего картинки в тексте письма из-за особенностей вывода изображений
//             в форматированном документе;
//    * УчетнаяЗапись - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - учетная запись для отправки письма.
//
Процедура ПриЗаполненииПочтыПолучателейВСообщении(ПолучателиПисьма, ПредметСообщения) Экспорт
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ШаблоныСообщений

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив Из Строка
//
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("АдресДоставки");
	Результат.Добавить("СтранаДоставки");
	Результат.Добавить("РегионДоставки");
	Результат.Добавить("ГородДоставки");
	
	Результат.Добавить("ЭлектроннаяПочта");
	Результат.Добавить("ДоменноеИмяСервера");
	
	Результат.Добавить("ПартнерыИКонтактныеЛица.ИдентификаторСтрокиТабличнойЧасти");
	Результат.Добавить("КонтактнаяИнформация.*");
	
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

// См. ЗапретРедактированияРеквизитовОбъектовПереопределяемый.ПриОпределенииОбъектовСЗаблокированнымиРеквизитами.
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	БлокируемыеРеквизиты = Новый Массив;
	
	БлокируемыеРеквизиты.Добавить("Организация");
	БлокируемыеРеквизиты.Добавить("Партнер");
	БлокируемыеРеквизиты.Добавить("Контрагент");
	БлокируемыеРеквизиты.Добавить("Договор");
	БлокируемыеРеквизиты.Добавить("СчетаНаОплату");
	
	Возврат БлокируемыеРеквизиты;
	
КонецФункции

// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

// СтандартныеПодсистемы.Взаимодействия

// Получить партнера и контактных лиц сделки.
//
// Параметры:
//  Ссылка  - ДокументСсылка._ДемоЗаказПокупателя - документ, контакты которого необходимо получить.
//
// Возвращаемое значение:
//   Массив   - массив, содержащий контакты документа.
// 
Функция ПолучитьКонтакты(Ссылка) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Ссылка) Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаПоКонтактам();
	Запрос.УстановитьПараметр("Предмет", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Новый Массив;
	КонецЕсли;

	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Контакт");
	
КонецФункции

// Конец СтандартныеПодсистемы.Взаимодействия

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Партнер)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

// СтандартныеПодсистемы.ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	БизнесПроцессы._ДемоЗаданиеСРолевойАдресацией.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Для использования в процедуре ДобавитьКомандыСозданияНаОсновании других модулей менеджеров объектов.
// Добавляет в список команд создания на основании этот объект.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
// Возвращаемое значение:
//  СтрокаТаблицыЗначений, Неопределено - описание добавленной команды.
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Возврат СозданиеНаОсновании.ДобавитьКомандуСозданияНаОсновании(КомандыСозданияНаОсновании, Метаданные.Документы._ДемоЗаказПокупателя);
	
КонецФункции

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает текст запроса по контактам взаимодействий, содержащимся в документе.
//
// Возвращаемое значение:
//   Строка
//
Функция ТекстЗапросаПоКонтактам(ЭтоФрагментЗапроса = Ложь) Экспорт
	
	ТекстЗапроса = "
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	_ДемоЗаказПокупателя.Партнер КАК Контакт 
		|ИЗ
		|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
		|ГДЕ
		|	_ДемоЗаказПокупателя.Ссылка = &Предмет
		|	И (НЕ _ДемоЗаказПокупателя.Партнер = ЗНАЧЕНИЕ(Справочник._ДемоПартнеры.ПустаяСсылка))
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	_ДемоЗаказПокупателяПартнерыИКонтактныеЛица.Партнер
		|ИЗ
		|	Документ._ДемоЗаказПокупателя.ПартнерыИКонтактныеЛица КАК _ДемоЗаказПокупателяПартнерыИКонтактныеЛица
		|ГДЕ
		|	_ДемоЗаказПокупателяПартнерыИКонтактныеЛица.Ссылка = &Предмет
		|	И (НЕ _ДемоЗаказПокупателяПартнерыИКонтактныеЛица.Партнер = ЗНАЧЕНИЕ(Справочник._ДемоПартнеры.ПустаяСсылка))
		|	И _ДемоЗаказПокупателяПартнерыИКонтактныеЛица.КонтактноеЛицо = ЗНАЧЕНИЕ(Справочник._ДемоКонтактныеЛицаПартнеров.ПустаяСсылка)
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	_ДемоЗаказПокупателяПартнерыИКонтактныеЛица.КонтактноеЛицо
		|ИЗ
		|	Документ._ДемоЗаказПокупателя.ПартнерыИКонтактныеЛица КАК _ДемоЗаказПокупателяПартнерыИКонтактныеЛица
		|ГДЕ
		|	_ДемоЗаказПокупателяПартнерыИКонтактныеЛица.Ссылка = &Предмет
		|	И (НЕ _ДемоЗаказПокупателяПартнерыИКонтактныеЛица.КонтактноеЛицо = ЗНАЧЕНИЕ(Справочник._ДемоКонтактныеЛицаПартнеров.ПустаяСсылка))";
	
	Если ЭтоФрагментЗапроса Тогда
		ТекстЗапроса = "
			| ОБЪЕДИНИТЬ ВСЕ
			|" + ТекстЗапроса;
	КонецЕсли;
		
	Возврат ТекстЗапроса;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления.

// Регистрирует на плане обмена ОбновлениеИнформационнойБазы объекты,
// которые необходимо обновить на новую версию.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	// Параметры выборки данных для многопоточного обновления.
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаОбъектов = "Документ._ДемоЗаказПокупателя";
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиСсылки();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	_ДемоЗаказПокупателя.Ссылка
		|ИЗ
		|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
		|ГДЕ
		|	_ДемоЗаказПокупателя.СтатусЗаказа = &ПустаяСсылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	_ДемоЗаказПокупателя.Дата УБЫВ";
	Запрос.Параметры.Вставить("ПустаяСсылка", Перечисления._ДемоСтатусыЗаказовПокупателей.ПустаяСсылка());
	
	Результат = Запрос.Выполнить().Выгрузить();
	МассивСсылок = Результат.ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивСсылок);
	
КонецПроцедуры

// Заполнить значение нового реквизита СтатусЗаказа у документа _ДемоЗаказПокупателя.
// 
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	// Имитация ошибки (проверка зацикливания) в отложенном обработчике.
	// Начало имитации ошибки.
	ИмитироватьОшибку = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ОбновлениеИБ", "ИмитироватьОшибкуПриОтложенномПараллельномОбновлении", Ложь);
	Если ИмитироватьОшибку Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		
		Если Не Параметры.Свойство("КоличествоЗапусков") Тогда
			Параметры.Вставить("КоличествоЗапусков", 1);
		Иначе
			Параметры.КоличествоЗапусков = Параметры.КоличествоЗапусков + 1;
		КонецЕсли;
		
		Если Параметры.КоличествоЗапусков = 3 Тогда
			ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ОбновлениеИБ", "ИмитироватьОшибкуПриОтложенномПараллельномОбновлении", Ложь);
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	// Конец имитации ошибки.
	
	// Выборка данных для многопоточного обновления.
	ЗаказыПокупателя = ОбновлениеИнформационнойБазы.ДанныеДляОбновленияВМногопоточномОбработчике(Параметры);
	
	ПроблемныхОбъектов = 0;
	ОбъектовОбработано = 0;
	
	Для каждого ЗаказПокупателя Из ЗаказыПокупателя Цикл
		
		Попытка
			
			ЗаполнитьСтатусЗаказаПокупателя(ЗаказПокупателя);
			ОбъектовОбработано = ОбъектовОбработано + 1;
			
		Исключение
			// Если не удалось обработать какой-либо заказ, повторяем попытку снова.
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось обработать заказ покупателя: %1 по причине:
					|%2'"), 
					ЗаказПокупателя.Ссылка, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				Метаданные.Документы._ДемоЗаказПокупателя, ЗаказПокупателя.Ссылка, ТекстСообщения);
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, "Документ._ДемоЗаказПокупателя");
	Если ОбъектовОбработано = 0 И ПроблемныхОбъектов <> 0 Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Процедуре ЗаполнитьСтатусыЗаказовПокупателей не удалось обработать некоторые заказы покупателей (пропущены): %1'"), 
				ПроблемныхОбъектов);
		ВызватьИсключение ТекстСообщения;
	Иначе
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,
			Метаданные.Документы._ДемоЗаказПокупателя,,
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Процедура ЗаполнитьСтатусыЗаказовПокупателей обработала очередную порцию заказов покупателей: %1'"),
					ОбъектовОбработано));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Заполняет значение нового реквизита СтатусЗаказ у переданного документа.
//
Процедура ЗаполнитьСтатусЗаказаПокупателя(ЗаказПокупателя)
	
	НачатьТранзакцию();
	Попытка
	
		// Блокируем объект от изменения другими сеансами.
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Документ._ДемоЗаказПокупателя");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", ЗаказПокупателя.Ссылка);
		Блокировка.Заблокировать();
		
		ДокументОбъект = ЗаказПокупателя.Ссылка.ПолучитьОбъект();
		
		// Если объект ранее был удален или обработан другими сеансами, пропускаем его.
		Если ДокументОбъект = Неопределено Тогда
			ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ЗаказПокупателя.Ссылка);
			ОтменитьТранзакцию();
			Возврат;
		КонецЕсли;
		Если ДокументОбъект.СтатусЗаказа <> Перечисления._ДемоСтатусыЗаказовПокупателей.ПустаяСсылка() Тогда
			ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ЗаказПокупателя.Ссылка);
			ОтменитьТранзакцию();
			Возврат;
		КонецЕсли;
		
		// Обработка объекта.
		Если Не ДокументОбъект.УдалитьЗаказЗакрыт И Не ДокументОбъект.Проведен Тогда
			ДокументОбъект.СтатусЗаказа = Перечисления._ДемоСтатусыЗаказовПокупателей.НеСогласован;
		ИначеЕсли Не ДокументОбъект.УдалитьЗаказЗакрыт И ДокументОбъект.Проведен Тогда
			ДокументОбъект.СтатусЗаказа = Перечисления._ДемоСтатусыЗаказовПокупателей.Согласован;
		Иначе
			ДокументОбъект.СтатусЗаказа = Перечисления._ДемоСтатусыЗаказовПокупателей.Закрыт;
		КонецЕсли;
		
		// Запись обработанного объекта.
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ДокументОбъект);
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

Функция КоличествоЗаказовПокупателя()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КОЛИЧЕСТВО(_ДемоЗаказПокупателя.Ссылка) КАК Количество
	|ИЗ
	|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
	|ГДЕ
	|	_ДемоЗаказПокупателя.СтатусЗаказа <> &ЗаказЗакрыт
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(_ДемоЗаказПокупателя.Ссылка)
	|ИЗ
	|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
	|ГДЕ
	|	_ДемоЗаказПокупателя.СтатусЗаказа = &ЗаказСогласован
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(_ДемоЗаказПокупателя.Ссылка)
	|ИЗ
	|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
	|ГДЕ
	|	_ДемоЗаказПокупателя.СтатусЗаказа = &ЗаказНеСогласован";
	
	Запрос.УстановитьПараметр("ЗаказСогласован", Перечисления._ДемоСтатусыЗаказовПокупателей.Согласован);
	Запрос.УстановитьПараметр("ЗаказЗакрыт", Перечисления._ДемоСтатусыЗаказовПокупателей.Закрыт);
	Запрос.УстановитьПараметр("ЗаказНеСогласован", Перечисления._ДемоСтатусыЗаказовПокупателей.НеСогласован);
	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	Результат = Новый Структура("Всего, Согласовано, НеСогласовано");
	Результат.Всего = РезультатЗапроса[0].Количество;
	Результат.Согласовано = РезультатЗапроса[1].Количество;
	Результат.НеСогласовано = РезультатЗапроса[2].Количество;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецЕсли