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
	
	ОбъектМетаданных = МультиязычностьСервер.ОбъектМетаданных(Параметры.Объект);
	Если ОбъектМетаданных = Неопределено Тогда
		ОбъектМетаданных = МультиязычностьСервер.ОбъектМетаданных(Параметры.Ссылка);
	КонецЕсли;
	
	ТолькоПросмотр = Не ПравоДоступа("Изменение", ОбъектМетаданных);
	
	МультиязычныеСтрокиВРеквизитах = МультиязычностьСервер.МультиязычныеСтрокиВРеквизитах(ОбъектМетаданных);
	Реквизит = ОбъектМетаданных.Реквизиты.Найти(Параметры.ИмяРеквизита);
	Если Реквизит = Неопределено Тогда
		Для каждого СтандартныйРеквизит Из ОбъектМетаданных.СтандартныеРеквизиты Цикл
			Если СтрСравнить(СтандартныйРеквизит.Имя, Параметры.ИмяРеквизита) = 0 Тогда
				Реквизит = СтандартныйРеквизит;
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	СуффиксОсновногоЯзыка         = "";
	СуффиксДополнительногоЯзыка1 = "Язык1";
	СуффиксДополнительногоЯзыка2 = "Язык2";
	
	Если СтрСравнить(Константы.ОсновнойЯзык.Получить(), ТекущийЯзык().КодЯзыка) <> 0 Тогда
		СуффиксОсновногоЯзыка = МультиязычностьСервер.СуффиксТекущегоЯзыка();
		Если СуффиксОсновногоЯзыка = "Язык1" Тогда
			СуффиксДополнительногоЯзыка1  = "";
		ИначеЕсли СуффиксОсновногоЯзыка = "Язык2" Тогда
			СуффиксДополнительногоЯзыка2 = "";
		КонецЕсли;
		
	КонецЕсли;
	
	НаборЯзыков = Новый ТаблицаЗначений;
	НаборЯзыков.Колонки.Добавить("КодЯзыка",      ОбщегоНазначения.ОписаниеТипаСтрока(10));
	НаборЯзыков.Колонки.Добавить("Представление", ОбщегоНазначения.ОписаниеТипаСтрока(150));
	НаборЯзыков.Колонки.Добавить("Суффикс",       ОбщегоНазначения.ОписаниеТипаСтрока(50));
	
	Если МультиязычныеСтрокиВРеквизитах Тогда
		
		ПредставленияЯзыков = Новый Соответствие;
		Для Каждого ЯзыкКонфигурации Из Метаданные.Языки Цикл
			ПредставленияЯзыков.Вставить(ЯзыкКонфигурации.КодЯзыка, ЯзыкКонфигурации.Представление());
		КонецЦикла;
		
		НовыйЯзык = НаборЯзыков.Добавить();
		НовыйЯзык.КодЯзыка = Константы.ОсновнойЯзык.Получить();
		НовыйЯзык.Представление = ПредставленияЯзыков[НовыйЯзык.КодЯзыка];
		НовыйЯзык.Суффикс = СуффиксОсновногоЯзыка;
		
		Если МультиязычностьСервер.ИспользуетсяПервыйДополнительныйЯзык() Тогда
			НовыйЯзык = НаборЯзыков.Добавить();
			НовыйЯзык.КодЯзыка = МультиязычностьСервер.КодПервогоДополнительногоЯзыкаИнформационнойБазы();
			НовыйЯзык.Представление = ПредставленияЯзыков[НовыйЯзык.КодЯзыка];
			НовыйЯзык.Суффикс = СуффиксДополнительногоЯзыка1;
		КонецЕсли;
		
		Если МультиязычностьСервер.ИспользуетсяВторойДополнительныйЯзык() Тогда
			НовыйЯзык = НаборЯзыков.Добавить();
			НовыйЯзык.КодЯзыка = МультиязычностьСервер.КодВторогоДополнительногоЯзыкаИнформационнойБазы();
			НовыйЯзык.Представление = ПредставленияЯзыков[НовыйЯзык.КодЯзыка];
			НовыйЯзык.Суффикс = СуффиксДополнительногоЯзыка2;
		КонецЕсли;
		
	Иначе
		
		Для Каждого ЯзыкКонфигурации Из Метаданные.Языки Цикл
		
			НовыйЯзык = НаборЯзыков.Добавить();
			НовыйЯзык.КодЯзыка = ЯзыкКонфигурации.КодЯзыка;
			НовыйЯзык.Представление = ЯзыкКонфигурации.Представление();
		
		КонецЦикла;
		
	КонецЕсли;
	
	Если Реквизит = Неопределено Тогда
		ШаблонОшибки = НСтр("ru = 'При открытии формы ВводНаРазныхЯзыках в параметре ИмяРеквизита указан не существующий реквизит %1'");
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонОшибки, Параметры.ИмяРеквизита);
	КонецЕсли;
	
	Если Реквизит.МногострочныйРежим Тогда
		СтандартныеПодсистемыСервер.УстановитьКлючНазначенияФормы(ЭтотОбъект, "МногострочныйРежим");
	КонецЕсли;
	
	Для Каждого ЯзыкКонфигурации Из НаборЯзыков Цикл
		НоваяСтрока = Языки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ЯзыкКонфигурации);
		НоваяСтрока.Имя = "_" + СтрЗаменить(Новый УникальныйИдентификатор, "-", "");
	КонецЦикла;
	
	СформироватьПоляВводаНаРазныхЯзыках(Реквизит.МногострочныйРежим, Параметры.ТолькоПросмотр Или ТолькоПросмотр);
	
	Если Не ПустаяСтрока(Параметры.Заголовок) Тогда
		Заголовок = Параметры.Заголовок;
	Иначе
		Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 на разных языках'"), Реквизит.Представление());
		Если ПустаяСтрока(Заголовок) Тогда
			Заголовок = Реквизит.Представление();
		КонецЕсли;
	КонецЕсли;
	
	ОписаниеЯзыка = ОписаниеЯзыка(ТекущийЯзык().КодЯзыка);
	Если ОписаниеЯзыка <> Неопределено Тогда
		ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ТекущиеЗначение;
	КонецЕсли;
	
	Если МультиязычныеСтрокиВРеквизитах Тогда
		
		ОсновнойЯзык = ОбщегоНазначения.КодОсновногоЯзыка();
		
		ОписаниеЯзыка = ОписаниеЯзыка(Константы.ОсновнойЯзык.Получить());
		Если ПустаяСтрока(СуффиксОсновногоЯзыка) Тогда
			ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ТекущиеЗначение;
		Иначе
			ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ЗначенияРеквизитов[Параметры.ИмяРеквизита + СуффиксОсновногоЯзыка];
		КонецЕсли;
		
		Если МультиязычностьСервер.ИспользуетсяПервыйДополнительныйЯзык() Тогда
			ОписаниеЯзыка = ОписаниеЯзыка(Константы.ДополнительныйЯзык1.Получить());
			Если ПустаяСтрока(СуффиксДополнительногоЯзыка1) Тогда
				ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ТекущиеЗначение;
			Иначе
				ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ЗначенияРеквизитов[Параметры.ИмяРеквизита + СуффиксДополнительногоЯзыка1];
			КонецЕсли;
		КонецЕсли;
		
		Если МультиязычностьСервер.ИспользуетсяВторойДополнительныйЯзык() Тогда
			ОписаниеЯзыка = ОписаниеЯзыка(Константы.ДополнительныйЯзык2.Получить());
			Если ПустаяСтрока(СуффиксДополнительногоЯзыка2) Тогда
				ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ТекущиеЗначение;
			Иначе
				ЭтотОбъект[ОписаниеЯзыка.Имя] = Параметры.ЗначенияРеквизитов[Параметры.ИмяРеквизита + СуффиксДополнительногоЯзыка2];
			КонецЕсли;
		КонецЕсли;
		
	Иначе
		
		ОсновнойЯзык = Метаданные.ОсновнойЯзык.КодЯзыка;
		
		Для каждого Представление Из Параметры.Представления Цикл
			
			ОписаниеЯзыка = ОписаниеЯзыка(Представление.КодЯзыка);
			Если ОписаниеЯзыка <> Неопределено Тогда
				Если СтрСравнить(ОписаниеЯзыка.КодЯзыка, ТекущийЯзык().КодЯзыка) = 0 Тогда
					ЭтотОбъект[ОписаниеЯзыка.Имя] = ?(ЗначениеЗаполнено(Параметры.ТекущиеЗначение), Параметры.ТекущиеЗначение, Представление[Параметры.ИмяРеквизита]);
				Иначе
					ЭтотОбъект[ОписаниеЯзыка.Имя] = Представление[Параметры.ИмяРеквизита];
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если Не Модифицированность Тогда
		Закрыть();
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура("ОсновнойЯзык", ОсновнойЯзык);
	Результат.Вставить("ЗначенияНаРазныхЯзыках", Новый Массив);
	Результат.Вставить("ХранениеВТабличнойЧасти", Не МультиязычныеСтрокиВРеквизитах);
	
	Для каждого Язык Из Языки Цикл
		
		Если Язык.КодЯзыка = ТекущийЯзык() Тогда
			Результат.Вставить("СтрокаНаТекущемЯзыке", ЭтотОбъект[Язык.Имя]);
		КонецЕсли;
		
		Если ТекущийЯзык() = ОсновнойЯзык И Язык.КодЯзыка = ОсновнойЯзык Тогда
			Продолжить;
		КонецЕсли;
		
		Значения = Новый Структура;
		Значения.Вставить("КодЯзыка",          Язык.КодЯзыка);
		Значения.Вставить("ЗначениеРеквизита", ЭтотОбъект[Язык.Имя]);
		Значения.Вставить("Суффикс",           Язык.Суффикс);
		
		Результат.ЗначенияНаРазныхЯзыках.Добавить(Значения);
	КонецЦикла;
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьПоляВводаНаРазныхЯзыках(МногострочныйРежим, ТолькоПросмотр)
	
	Добавлять = Новый Массив;
	ТипСтрока = Новый ОписаниеТипов("Строка");
	Для Каждого ЯзыкКонфигурации Из Языки Цикл
		НовыйРеквизит = Новый РеквизитФормы(ЯзыкКонфигурации.Имя, ТипСтрока,, ЯзыкКонфигурации.Представление);
		НовыйРеквизит.СохраняемыеДанные = Истина;
		Добавлять.Добавить(НовыйРеквизит);
	КонецЦикла;
	
	ИзменитьРеквизиты(Добавлять);
	РодительЭлементов = Элементы.ГруппаЯзыки;
	
	Для Каждого ЯзыкКонфигурации Из Языки Цикл
		
		Если СтрСравнить(ЯзыкКонфигурации.КодЯзыка, ТекущийЯзык().КодЯзыка) = 0 И РодительЭлементов.ПодчиненныеЭлементы.Количество() > 0 Тогда
			Элемент = Элементы.Вставить(ЯзыкКонфигурации.Имя, Тип("ПолеФормы"), РодительЭлементов, РодительЭлементов.ПодчиненныеЭлементы.Получить(0));
			ТекущийЭлемент = Элемент;
		Иначе
			Элемент = Элементы.Добавить(ЯзыкКонфигурации.Имя, Тип("ПолеФормы"), РодительЭлементов);
		КонецЕсли;
		
		Элемент.ПутьКДанным        = ЯзыкКонфигурации.Имя;
		Элемент.Вид                = ВидПоляФормы.ПолеВвода;
		Элемент.Ширина             = 40;
		Элемент.МногострочныйРежим = МногострочныйРежим;
		Элемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
		Элемент.ТолькоПросмотр     = ТолькоПросмотр;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ОписаниеЯзыка(КодЯзыка)
	
	Отбор = Новый Структура("КодЯзыка", КодЯзыка);
	НайденныеЭлементы = Языки.НайтиСтроки(Отбор);
	Если НайденныеЭлементы.Количество() > 0 Тогда
		Возврат НайденныеЭлементы[0];
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции


#КонецОбласти