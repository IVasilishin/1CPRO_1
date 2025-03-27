///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Создает структуру описания типа инцидента, которую требуется заполнить и передать функции СоздатьЗаписьТипа.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИмяТипа	 - Строка - Имя типа инцидента. Имя должно быть уникальным, например: Конфигурация1.ПОдсистема1.Инцидент1.
// 
// Возвращаемое значение:
//   - Структура - поля структуры:
// 		* ТипИнцидента - Строка - имя типа
//		* УровеньИнцидента - Строка - "Информация", "Предупреждение" (по умолчанию), "Ошибка", "КритическаяОшибка"
//		* Подсистема - Строка - подсистема с точки зрения ЦКК
//		* КонтекстИнформационнойБазы - Булево - определять контекст подключения. По умолчанию нет.
//		* ПроцедураПроверки - Строка - имя процедуры, которая будет вызываться периодически, если есть открытые инциденты указанного типа для проверки
//			их актуальности. Если указано "Авто", будет использована проверка по полю "Актуален" из регистра открытых инцидентов.
//		* МинутМеждуИнцидентами - Число - ограничивать частоту отсылки инцидентов. По умолчанию 0: не ограничивать
//		* Теги - Структура - с полями:
//		   ** Оборудование - Булево - 
//		   ** Доступность - Булево - 
//		   ** Производительность - Булево - 
//		   ** ПрикладнаяОшибка - Булево - 
//		   ** Дополнительные - Строка - в строку можно разместить произвольные теги, разделенные пробелом.
//
Функция СоздатьОписаниеТипаИнцидента(ИмяТипа) Экспорт
КонецФункции

// Создает запись типа инцидента и помещает ее в словарь. Если в словаре тип уже зарегистрирован, он будет перезаписан.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  СловарьТипов - Соответствие из КлючИЗначение:
//   * Ключ - Строка - имя типа инцидента
//   * Значение - см. СоздатьОписаниеТипаИнцидента
//  Описание - Структура:
//   * ТипИнцидента - Строка
//   * УровеньИнцидента - Строка
//   * Подсистема - Строка
//   * КонтекстИнформационнойБазы - Булево
//   * ПроцедураПроверки - Строка
//   * МинутМеждуИнцидентами - Число
//   * Теги - Структура:
//    ** Оборудование - Булево
//    ** Доступность - Булево
//    ** Производительность - Булево
//    ** ПрикладнаяОшибка - Булево
//    ** Дополнительные - Строка
Процедура СоздатьЗаписьТипа(Знач СловарьТипов, Знач Описание) Экспорт
КонецПроцедуры

// Регистрирует типы инцидентов в ИБ.
// @skip-warning ПустойМетод - особенность реализации.
//
Процедура ЗарегистрироватьТипыИнцидентовВЦКК() Экспорт
КонецПроцедуры

// Открывает инцидент. Если адрес ЦКК не указан, ничего не делает. Если инцидент отсылается чаще 
// указанных в типе ограничений, такая отсылка будет проигнорирована без вызова исключений. 
// Если указано Асинхронно=Истина, то метод будет выполнен с помощью менеджера фоновых заданий.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ТипИнцидента - Строка - Идентификатор типа инцидента. Должен быть среди зарегистрированных типов.
//  КодИнцидента - Строка - Строковый идентификатор инцидента. Должен быть уникален внутри типа. Если повторяется, 
//  						считается, что инцидент еще раз и счетчик срабатываний его в ЦКК увеличится.
//  ТекстСообщения - Строка - текст сообщения инцидента.
//  Асинхронно - Булево - флаг асинхронного выполнения.
//
Процедура ОткрытьИнцидент(Знач ТипИнцидента, Знач КодИнцидента, Знач ТекстСообщения, Знач Асинхронно = Ложь) Экспорт
КонецПроцедуры

// Помечает инцидент в регистре ИнцидентыОткрытые как неактуальный. 
// Инцидент закроется в ЦКК при следующем вызове проверки на актуальность.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ТипИнцидента - Строка - Идентификатор типа инцидента.
//  КодИнцидента - Строка - Идентификатор инцидента. 
//
Процедура ПометитьИнцидентКакНеактуальный(Знач ТипИнцидента, Знач КодИнцидента) Экспорт
КонецПроцедуры

// Отсылает счетчик в ЦКК, используя InputStatistics/InputStatisticsDate (СИНХРОННАЯ ОТСЫЛКА СЧЕТЧИКА).
// Когда указаны массивы в параметрах ИдентификаторСчетчика/ЗначениеСчетчика, происходит передача всего
// массива за один вызов.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ИдентификаторСчетчика - Строка - Идентификатор счетчика для ЦКК, разделенные точками
//  ЗначениеСчетчика - Число - Значение счетчика на передаваемый (указанный) момент времени
//  Данные - Соответствие из КлючИЗначение:
//	 * Ключ - Строка - идентификатор счетчика
//	 * Значение - Число - значение счетчика (если указано, имеет приоритет)
//  ДатаСчетчика - Дата - Если указано, используется InputStatisticsDate, иначе - InputStatistics.
//
Процедура ОтослатьСтатистику(Знач ИдентификаторСчетчика, Знач ЗначениеСчетчика, Знач Данные = Неопределено, Знач ДатаСчетчика = неопределено) Экспорт
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Вызывается из регламентной процедуры МониторингЦКК
// @skip-warning ПустойМетод - особенность реализации.
// 
Процедура ВыполнитьМониторингЦКК() Экспорт
КонецПроцедуры

// См. РаботаВМоделиСервиса.ПриОпределенииИсключенийНеразделенныхДанных
// 
// Параметры:
//	Исключения - Массив Из ОбъектМетаданных - исключения.
//
Процедура ПриОпределенииИсключенийНеразделенныхДанных(Исключения) Экспорт

	Исключения.Добавить(Метаданные.РегистрыСведений.ОграничениеСкоростиОтсылкиИнцидентов);
	Исключения.Добавить(Метаданные.РегистрыСведений.ИнцидентыОткрытые);
	Исключения.Добавить(Метаданные.РегистрыСведений.ИнцидентыОтложенныеПроверки);
	Исключения.Добавить(Метаданные.Константы.ТипыИнцидентовЦККАктуальны);
	
КонецПроцедуры

// См. ТехнологияСервиса.ВыгрузкаЗагрузкаДанных\ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки 
//  в ВыгрузкаЗагрузкаДанныхСлужебныйСобытия
// Параметры:
//	Типы - Массив Из ОбъектМетаданных - исключаемые типы.
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.РегистрыСведений.ОграничениеСкоростиОтсылкиИнцидентов);
	Типы.Добавить(Метаданные.РегистрыСведений.ИнцидентыОткрытые);
	Типы.Добавить(Метаданные.РегистрыСведений.ИнцидентыОтложенныеПроверки);
	Типы.Добавить(Метаданные.Константы.ТипыИнцидентовЦККАктуальны);
	
КонецПроцедуры

// См. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий
// Параметры:
//	Настройки - см. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий.Настройки
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.МониторингЦКК;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	
КонецПроцедуры

#КонецОбласти