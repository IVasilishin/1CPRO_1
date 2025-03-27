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
	
	ПроверитьВозможностьИспользованияФормы(Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ИнициализироватьРеквизитыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьПорядковыйНомерПерехода(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если НачальнаяВыгрузка Тогда
		ТекстПредупреждения = НСтр("ru = 'Отменить начальную выгрузку данных?'");
	Иначе
		ТекстПредупреждения = НСтр("ru = 'Отменить выгрузку данных?'");
	КонецЕсли;
	
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияПроизвольнойФормы(
		ЭтотОбъект, Отказ, ЗавершениеРаботы, ТекстПредупреждения, "ЗакрытьФормуБезусловно");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Оповестить("ВыполненОбменДанными");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаДалее(Команда)
	
	ИзменитьПорядковыйНомерПерехода(+1);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаНазад(Команда)
	
	ИзменитьПорядковыйНомерПерехода(-1);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаГотово(Команда)
	
	ПараметрЗакрытия = Неопределено;
	Если ВыгрузкаДанныхВыполнена Тогда
		ПараметрЗакрытия = УзелОбмена;
	КонецЕсли;
	
	ЗакрытьФормуБезусловно = Истина;
	Закрыть(ПараметрЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПодключения(Команда)
	
	Отбор              = Новый Структура("Корреспондент", УзелОбмена);
	ЗначенияЗаполнения = Новый Структура("Корреспондент", УзелОбмена);
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("НастройкиПодключенияЗавершение", ЭтотОбъект);
	
	ОбменДаннымиКлиент.ОткрытьФормуЗаписиРегистраСведенийПоОтбору(
		Отбор,
		ЗначенияЗаполнения,
		"НастройкиТранспортаОбменаДанными",
		ЭтотОбъект,
		,
		,
		ОповещениеОЗакрытии);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПроверкаПараметровПодключения

&НаКлиенте
Процедура ПриНачалеПроверкиПодключения()
	
	ПродолжитьОжидание = Истина;
	
	Если ПодключениеЧерезВнешнееСоединение Тогда
		Если ОбщегоНазначенияКлиент.ИнформационнаяБазаФайловая() Тогда
			ОбщегоНазначенияКлиент.ЗарегистрироватьCOMСоединитель(Ложь);
		КонецЕсли;
	КонецЕсли;
	
	ПриНачалеПроверкиПодключенияНаСервере(ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ИнициализироватьПараметрыОбработчикаОжидания(
			ПараметрыОбработчикаОжиданияПроверкиПодключения);
			
		ПодключитьОбработчикОжидания("ПриОжиданииПроверкиПодключения",
			ПараметрыОбработчикаОжиданияПроверкиПодключения.ТекущийИнтервал, Истина);
	Иначе
		ПриЗавершенииПроверкиПодключения();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОжиданииПроверкиПодключения()
	
	ПродолжитьОжидание = Ложь;
	ПриОжиданииПроверкиПодключенияНаСервере(ПараметрыОбработчикаПроверкиПодключения, ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжиданияПроверкиПодключения);
		
		ПодключитьОбработчикОжидания("ПриОжиданииПроверкиПодключения",
			ПараметрыОбработчикаОжиданияПроверкиПодключения.ТекущийИнтервал, Истина);
	Иначе
		ПараметрыОбработчикаОжиданияПроверкиПодключения = Неопределено;
		ПриЗавершенииПроверкиПодключения();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииПроверкиПодключения()
	
	ПриЗавершенииПроверкиПодключенияНаСервере();
	
	Если ДоступнаНастройкаТранспорта
		И Не ПроверкаПодключенияВыполнена Тогда
		УстановитьПорядковыйНомерПерехода(2); // Настройка подключения
	Иначе
		ИзменитьПорядковыйНомерПерехода(+1);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриНачалеПроверкиПодключенияНаСервере(ПродолжитьОжидание)
	
	Если ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WS
		И ЗапроситьПароль Тогда
		НастройкиПодключения = РегистрыСведений.НастройкиТранспортаОбменаДанными.НастройкиТранспортаWS(УзелОбмена, WSПароль);
	Иначе
		НастройкиПодключения = РегистрыСведений.НастройкиТранспортаОбменаДанными.НастройкиТранспорта(УзелОбмена, ВидТранспорта);
	КонецЕсли;
	НастройкиПодключения.Вставить("ВидТранспортаСообщенийОбмена", ВидТранспорта);
	
	НастройкиПодключения.Вставить("ИмяПланаОбмена", ОбменДаннымиПовтИсп.ПолучитьИмяПланаОбмена(УзелОбмена));
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	МодульПомощникНастройки.ПриНачалеПроверкиПодключения(
		НастройкиПодключения, ПараметрыОбработчикаПроверкиПодключения, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПриОжиданииПроверкиПодключенияНаСервере(ПараметрыОбработчика, ПродолжитьОжидание)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	ПродолжитьОжидание = Ложь;
	МодульПомощникНастройки.ПриОжиданииПроверкиПодключения(ПараметрыОбработчика, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗавершенииПроверкиПодключенияНаСервере()
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	СтатусЗавершения = Неопределено;
	МодульПомощникНастройки.ПриЗавершенииПроверкиПодключения(
		ПараметрыОбработчикаПроверкиПодключения, СтатусЗавершения);
		
	Если СтатусЗавершения.Отказ Тогда
		ПроверкаПодключенияВыполнена = Ложь;
		СообщениеОбОшибке = СтатусЗавершения.СообщениеОбОшибке;
	Иначе
		ПроверкаПодключенияВыполнена = СтатусЗавершения.Результат.ПодключениеУстановлено
			И СтатусЗавершения.Результат.ПодключениеРазрешено;
			
		Если Не ПроверкаПодключенияВыполнена
			И Не ПустаяСтрока(СтатусЗавершения.Результат.СообщениеОбОшибке) Тогда
			СообщениеОбОшибке = СтатусЗавершения.Результат.СообщениеОбОшибке;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПодключенияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ИнициализироватьПараметрыТранспорта();
	
КонецПроцедуры

#КонецОбласти

#Область РегистрацияИзменений

&НаКлиенте
Процедура ПриНачалеРегистрацииИзменений()
	
	ПродолжитьОжидание = Истина;
	ПриНачалеРегистрацииИзмененийНаСервере(ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ИнициализироватьПараметрыОбработчикаОжидания(
			ПараметрыОбработчикаОжиданияРегистрацииДанныхДляНачальнойВыгрузки);
			
		ПодключитьОбработчикОжидания("ПриОжиданииРегистрацииИзменений",
			ПараметрыОбработчикаОжиданияРегистрацииДанныхДляНачальнойВыгрузки.ТекущийИнтервал, Истина);
	Иначе
		ПриЗавершенииРегистрацииИзменений();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОжиданииРегистрацииИзменений()
	
	ПродолжитьОжидание = Ложь;
	ПриОжиданииРегистрацииИзмененийНаСервере(ПараметрыОбработчикаРегистрацииДанныхДляНачальнойВыгрузки, ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжиданияРегистрацииДанныхДляНачальнойВыгрузки);
		
		ПодключитьОбработчикОжидания("ПриОжиданииРегистрацииИзменений",
			ПараметрыОбработчикаОжиданияРегистрацииДанныхДляНачальнойВыгрузки.ТекущийИнтервал, Истина);
	Иначе
		ПараметрыОбработчикаОжиданияРегистрацииДанныхДляНачальнойВыгрузки = Неопределено;
		ПриЗавершенииРегистрацииИзменений();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииРегистрацииИзменений()
	
	ПриЗавершенииРегистрацииИзмененийНаСервере();
	
	ИзменитьПорядковыйНомерПерехода(+1);
	
КонецПроцедуры

&НаСервере
Процедура ПриНачалеРегистрацииИзмененийНаСервере(ПродолжитьОжидание)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	НастройкиРегистрации = Новый Структура;
	НастройкиРегистрации.Вставить("УзелОбмена", УзелОбмена);
	
	МодульПомощникНастройки.ПриНачалеРегистрацииДанныхДляНачальнойВыгрузки(
		НастройкиРегистрации, ПараметрыОбработчикаРегистрацииДанныхДляНачальнойВыгрузки, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПриОжиданииРегистрацииИзмененийНаСервере(ПараметрыОбработчика, ПродолжитьОжидание)
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	ПродолжитьОжидание = Ложь;
	МодульПомощникНастройки.ПриОжиданииРегистрацииДанныхДляНачальнойВыгрузки(
		ПараметрыОбработчика, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗавершенииРегистрацииИзмененийНаСервере()
	
	МодульПомощникНастройки = ОбменДаннымиСервер.МодульПомощникСозданияОбменаДанными();
	
	СтатусЗавершения = Неопределено;
	МодульПомощникНастройки.ПриЗавершенииРегистрацииДанныхДляНачальнойВыгрузки(
		ПараметрыОбработчикаРегистрацииДанныхДляНачальнойВыгрузки, СтатусЗавершения);
		
	Если СтатусЗавершения.Отказ Тогда
		РегистрацияИзмененийВыполнена = Ложь;
		СообщениеОбОшибке = СтатусЗавершения.СообщениеОбОшибке;
	Иначе
		РегистрацияИзмененийВыполнена = СтатусЗавершения.Результат.ДанныеЗарегистрированы;
			
		Если Не РегистрацияИзмененийВыполнена
			И Не ПустаяСтрока(СтатусЗавершения.Результат.СообщениеОбОшибке) Тогда
			СообщениеОбОшибке = СтатусЗавершения.Результат.СообщениеОбОшибке;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ВыгрузкаДанных

&НаКлиенте
Процедура ПриНачалеВыгрузкиДанныхДляСопоставления()
	
	ПроцентВыполнения = 0;
	
	ПродолжитьОжидание = Истина;
	ПриНачалеВыгрузкиДанныхДляСопоставленияНаСервере(ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		
		Если ЭтоОбменСПриложениемВСервисе Тогда
			ОбменДаннымиКлиент.ИнициализироватьПараметрыОбработчикаОжидания(
				ПараметрыОбработчикаОжиданияВыгрузкиДанныхДляСопоставления);
				
			ПодключитьОбработчикОжидания("ПриОжиданииВыгрузкиДанныхДляСопоставления",
				ПараметрыОбработчикаОжиданияВыгрузкиДанныхДляСопоставления.ТекущийИнтервал, Истина);
		Иначе
			ОповещениеОЗавершении = Новый ОписаниеОповещения("ВыгрузкаДанныхДляСопоставленияЗавершение", ЭтотОбъект);
		
			ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
			ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
			ПараметрыОжидания.ВыводитьПрогрессВыполнения = ИспользоватьПрогресс;
			ПараметрыОжидания.ОповещениеОПрогрессеВыполнения = Новый ОписаниеОповещения("ВыгрузкаДанныхДляСопоставленияПрогресс", ЭтотОбъект);
			
			ДлительныеОперацииКлиент.ОжидатьЗавершение(ПараметрыОбработчикаВыгрузкиДанныхДляСопоставления.ФоновоеЗадание,
				ОповещениеОЗавершении, ПараметрыОжидания);
		КонецЕсли;
			
	Иначе
			
		ПриЗавершенииВыгрузкиДанныхДляСопоставления();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОжиданииВыгрузкиДанныхДляСопоставления()
	
	ПродолжитьОжидание = Ложь;
	ПриОжиданииВыгрузкиДанныхДляСопоставленияНаСервере(ПараметрыОбработчикаВыгрузкиДанныхДляСопоставления, ПродолжитьОжидание);
	
	Если ПродолжитьОжидание Тогда
		ОбменДаннымиКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжиданияВыгрузкиДанныхДляСопоставления);
		
		ПодключитьОбработчикОжидания("ПриОжиданииВыгрузкиДанныхДляСопоставления",
			ПараметрыОбработчикаОжиданияВыгрузкиДанныхДляСопоставления.ТекущийИнтервал, Истина);
	Иначе
		ПараметрыОбработчикаОжиданияВыгрузкиДанныхДляСопоставления = Неопределено;
		ПриЗавершенииВыгрузкиДанныхДляСопоставления();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииВыгрузкиДанныхДляСопоставления()
	
	ПроцентВыполнения = 100;
	
	ПриЗавершенииВыгрузкиДанныхДляСопоставленияНаСервере();
	ИзменитьПорядковыйНомерПерехода(+1);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузкаДанныхДляСопоставленияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		ПриЗавершенииВыгрузкиДанныхДляСопоставления();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузкаДанныхДляСопоставленияПрогресс(Прогресс, ДополнительныеПараметры) Экспорт
	
	Если Прогресс = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураПрогресса = Прогресс.Прогресс;
	Если СтруктураПрогресса <> Неопределено Тогда
		ПроцентВыполнения = СтруктураПрогресса.Процент;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриНачалеВыгрузкиДанныхДляСопоставленияНаСервере(ПродолжитьОжидание)
	
	НастройкиВыгрузки = Новый Структура;
	
	Если ЭтоОбменСПриложениемВСервисе Тогда
		НастройкиВыгрузки.Вставить("Корреспондент", УзелОбмена);
		НастройкиВыгрузки.Вставить("ОбластьДанныхКорреспондента", ОбластьДанныхКорреспондента);
		
		МодульПомощникИнтерактивногоОбмена = ОбменДаннымиСервер.МодульПомощникИнтерактивногоОбменаДаннымиВМоделиСервиса();
	Иначе
		НастройкиВыгрузки.Вставить("УзелОбмена", УзелОбмена);
		НастройкиВыгрузки.Вставить("ВидТранспорта", ВидТранспорта);
		
		Если ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WS
			И ЗапроситьПароль Тогда
			НастройкиВыгрузки.Вставить("WSПароль", WSПароль);
		КонецЕсли;
		
		МодульПомощникИнтерактивногоОбмена = ОбменДаннымиСервер.МодульПомощникИнтерактивногоОбменаДанными();
	КонецЕсли;
	
	Если МодульПомощникИнтерактивногоОбмена = Неопределено Тогда
		ПродолжитьОжидание = Ложь;
		Возврат;
	КонецЕсли;
	
	МодульПомощникИнтерактивногоОбмена.ПриНачалеВыгрузкиДанныхДляСопоставления(
		НастройкиВыгрузки, ПараметрыОбработчикаВыгрузкиДанныхДляСопоставления, ПродолжитьОжидание);
	
КонецПроцедуры
	
&НаСервереБезКонтекста
Процедура ПриОжиданииВыгрузкиДанныхДляСопоставленияНаСервере(ПараметрыОбработчика, ПродолжитьОжидание)
	
	МодульПомощникИнтерактивногоОбмена = ОбменДаннымиСервер.МодульПомощникИнтерактивногоОбменаДаннымиВМоделиСервиса();
	
	Если МодульПомощникИнтерактивногоОбмена = Неопределено Тогда
		ПродолжитьОжидание = Ложь;
		Возврат;
	КонецЕсли;
	
	МодульПомощникИнтерактивногоОбмена.ПриОжиданииВыгрузкиДанныхДляСопоставления(ПараметрыОбработчика, ПродолжитьОжидание);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗавершенииВыгрузкиДанныхДляСопоставленияНаСервере()
	
	Если ЭтоОбменСПриложениемВСервисе Тогда
		МодульПомощникИнтерактивногоОбмена = ОбменДаннымиСервер.МодульПомощникИнтерактивногоОбменаДаннымиВМоделиСервиса();
	Иначе
		МодульПомощникИнтерактивногоОбмена = ОбменДаннымиСервер.МодульПомощникИнтерактивногоОбменаДанными();
	КонецЕсли;
	
	Если МодульПомощникИнтерактивногоОбмена = Неопределено Тогда
		ВыгрузкаДанныхВыполнена = Ложь;
		Возврат;
	КонецЕсли;
	
	СтатусЗавершения = Неопределено;
	
	МодульПомощникИнтерактивногоОбмена.ПриЗавершенииВыгрузкиДанныхДляСопоставления(
		ПараметрыОбработчикаВыгрузкиДанныхДляСопоставления, СтатусЗавершения);
		
	Если СтатусЗавершения.Отказ Тогда
		ВыгрузкаДанныхВыполнена = Ложь;
		СообщениеОбОшибке = СтатусЗавершения.СообщениеОбОшибке;
	Иначе
		ВыгрузкаДанныхВыполнена = СтатусЗавершения.Результат.ДанныеВыгружены;
			
		Если Не ВыгрузкаДанныхВыполнена
			И Не ПустаяСтрока(СтатусЗавершения.Результат.СообщениеОбОшибке) Тогда
			СообщениеОбОшибке = СтатусЗавершения.Результат.СообщениеОбОшибке;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ИнициализацияФормыПриСоздании

&НаСервере
Процедура ПроверитьВозможностьИспользованияФормы(Отказ = Ложь)
	
	// Обязательная должны быть переданы параметры выполнения выгрузки данных.
	Если Не Параметры.Свойство("УзелОбмена") Тогда
		ТекстСообщения = НСтр("ru = 'Форма не предназначена для непосредственного использования.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , , , Отказ);
		Возврат;
	КонецЕсли;
	
	Если ОбменДаннымиПовтИсп.ЭтоУзелРаспределеннойИнформационнойБазы(Параметры.УзелОбмена) Тогда
		ТекстСообщения = НСтр("ru = 'Начальная выгрузка не поддерживается для узлов распределенных информационных баз.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , , , Отказ);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьРеквизитыФормы()
	
	УзелОбмена = Параметры.УзелОбмена;
	
	Если Параметры.Свойство("НачальнаяВыгрузка") Тогда
		РежимВыгрузкиДанных = "НачальнаяВыгрузка";
		НачальнаяВыгрузка = Истина;
	Иначе
		РежимВыгрузкиДанных = "ОбычнаяВыгрузка";
	КонецЕсли;
	
	НаименованиеПриложения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(УзелОбмена, "Наименование");
	
	Параметры.Свойство("ЭтоОбменСПриложениемВСервисе", ЭтоОбменСПриложениемВСервисе);
	Параметры.Свойство("ОбластьДанныхКорреспондента",  ОбластьДанныхКорреспондента);
	
	ИнициализироватьПараметрыТранспорта();
		
	УстановитьНаименованиеПриложенияВНадписяхФормы();
	
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьПараметрыТранспорта()
	
	ВидТранспорта = РегистрыСведений.НастройкиТранспортаОбменаДанными.ВидТранспортаСообщенийОбменаПоУмолчанию(УзелОбмена);
	
	Если Не ЗначениеЗаполнено(ВидТранспорта) Тогда
		ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим;
	КонецЕсли;
	
	ПодключениеЧерезВнешнееСоединение = (ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.COM);
	
	ИспользоватьПрогресс = Не ЭтоОбменСПриложениемВСервисе
		И Не ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WS
		И Не ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим;
		
	ЗапроситьПароль              = Ложь;
	ПроверкаПодключенияВыполнена = Ложь;
	ВыгрузкаДанныхВыполнена      = Ложь;
	
	ДоступнаНастройкаТранспорта  = Не (ЭтоОбменСПриложениемВСервисе
		Или ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим);
	
	Если ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WS Тогда
			
		НастройкиТранспорта = РегистрыСведений.НастройкиТранспортаОбменаДанными.НастройкиТранспортаWS(УзелОбмена);
		
		ЗапроситьПароль = Не (НастройкиТранспорта.WSЗапомнитьПароль
			Или ОбменДаннымиСервер.ПарольСинхронизацииДанныхЗадан(УзелОбмена));
			
	ИначеЕсли ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим Тогда
			
		ПроверкаПодключенияВыполнена = Истина;
		ВыгрузкаДанныхВыполнена      = Истина;
		
	КонецЕсли;
	
	ЗаполнитьТаблицуПереходов();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНаименованиеПриложенияВНадписяхФормы()
	
	Элементы.ДекорацияНадписьПароль.Заголовок = СтрЗаменить(Элементы.ДекорацияНадписьПароль.Заголовок,
		"%НаименованиеПриложения%", НаименованиеПриложения);
	
	Элементы.ДекорацияНадписьВыгрузкаДанныхБезПрогресса.Заголовок = СтрЗаменить(Элементы.ДекорацияНадписьВыгрузкаДанныхБезПрогресса.Заголовок,
		"%НаименованиеПриложения%", НаименованиеПриложения);
	
	Элементы.ДекорацияНадписьВыгрузкаДанныхПрогресс.Заголовок = СтрЗаменить(Элементы.ДекорацияНадписьВыгрузкаДанныхПрогресс.Заголовок,
		"%НаименованиеПриложения%", НаименованиеПриложения);
	
	Элементы.ДекорацияНадписьВыгрузкаЗавершена.Заголовок = СтрЗаменить(Элементы.ДекорацияНадписьВыгрузкаЗавершена.Заголовок,
		"%НаименованиеПриложения%", НаименованиеПриложения);
	
КонецПроцедуры

#КонецОбласти

#Область СценарииРаботыПомощника

&НаСервере
Функция ДобавитьСтрокуТаблицыПереходов(ИмяОсновнойСтраницы, ИмяСтраницыНавигации, ИмяСтраницыДекорации = "")
	
	СтрокаПереходов = ТаблицаПереходов.Добавить();
	СтрокаПереходов.ПорядковыйНомерПерехода = ТаблицаПереходов.Количество();
	СтрокаПереходов.ИмяОсновнойСтраницы = ИмяОсновнойСтраницы;
	СтрокаПереходов.ИмяСтраницыНавигации = ИмяСтраницыНавигации;
	СтрокаПереходов.ИмяСтраницыДекорации = ИмяСтраницыДекорации;
	
	Возврат СтрокаПереходов;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуПереходов()
	
	ТаблицаПереходов.Очистить();
	
	НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаНачало", "СтраницаНавигацияНачало");
	НовыйПереход.ИмяОбработчикаПриОткрытии = "СтраницаНачало_ПриОткрытии";
	
	Если ДоступнаНастройкаТранспорта Тогда
		НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаНастройкиПодключения", "СтраницаНавигацияПродолжение");
		НовыйПереход.ИмяОбработчикаПриОткрытии = "СтраницаНастройкиПодключения_ПриОткрытии";
	КонецЕсли;
	
	Если ЗапроситьПароль Тогда
		НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаЗапросПароля", "СтраницаНавигацияПродолжение");
		НовыйПереход.ИмяОбработчикаПриПереходеДалее = "СтраницаЗапросПароля_ПриПереходеДалее";
	КонецЕсли;
	
	Если Не ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим Тогда
		НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаПроверкаПодключения", "СтраницаНавигацияОжидание");
		НовыйПереход.ДлительнаяОперация = Истина;
		НовыйПереход.ИмяОбработчикаДлительнойОперации = "СтраницаПроверкаПодключения_ДлительнаяОперация";
	КонецЕсли;
	
	НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаРегистрацияИзменений", "СтраницаНавигацияОжидание");
	НовыйПереход.ИмяОбработчикаПриОткрытии = "СтраницаРегистрацияИзменений_ПриОткрытии";
	НовыйПереход.ДлительнаяОперация = Истина;
	НовыйПереход.ИмяОбработчикаДлительнойОперации = "СтраницаРегистрацияИзменений_ДлительнаяОперация";
	
	Если Не ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.WSПассивныйРежим Тогда
		Если ИспользоватьПрогресс Тогда
			НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаВыгрузкаДанныхПрогресс", "СтраницаНавигацияОжидание");
		Иначе
			НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаВыгрузкаДанныхБезПрогресса", "СтраницаНавигацияОжидание");
		КонецЕсли;
		НовыйПереход.ИмяОбработчикаПриОткрытии = "СтраницаВыгрузкаДанных_ПриОткрытии";
		НовыйПереход.ДлительнаяОперация = Истина;
		НовыйПереход.ИмяОбработчикаДлительнойОперации = "СтраницаВыгрузкаДанных_ДлительнаяОперация";
	КонецЕсли;
	
	НовыйПереход = ДобавитьСтрокуТаблицыПереходов("СтраницаОкончание", "СтраницаНавигацияОкончание");
	НовыйПереход.ИмяОбработчикаПриОткрытии = "СтраницаОкончание_ПриОткрытии";
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийПереходов

&НаКлиенте
Функция Подключаемый_СтраницаНачало_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	Элементы.РежимВыгрузкиДанных.Доступность = Не НачальнаяВыгрузка;
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаНастройкиПодключения_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	ПропуститьСтраницу = ЭтоПереходДалее;
	
	Возврат Неопределено;
		
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаЗапросПароля_ПриПереходеДалее(Отказ)
	
	Если Не ЗапроситьПароль Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ПустаяСтрока(WSПароль) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			НСтр("ru = 'Укажите пароль.'"), , "WSПароль", , Отказ);
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаПроверкаПодключения_ДлительнаяОперация(Отказ, ПерейтиДалее)
	
	ПерейтиДалее = Ложь;
	ПриНачалеПроверкиПодключения();
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаРегистрацияИзменений_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	Если Не ПроверкаПодключенияВыполнена Тогда
		ПропуститьСтраницу = Истина;
		Возврат Неопределено;
	Иначе
		Если РежимВыгрузкиДанных = "ОбычнаяВыгрузка" Тогда
			ПропуститьСтраницу = Истина;
			РегистрацияИзмененийВыполнена = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаРегистрацияИзменений_ДлительнаяОперация(Отказ, ПерейтиДалее)
	
	ПерейтиДалее = Ложь;
	ПриНачалеРегистрацииИзменений();
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаВыгрузкаДанных_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	ПропуститьСтраницу = Не ПроверкаПодключенияВыполнена
		Или Не РегистрацияИзмененийВыполнена;
		
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаВыгрузкаДанных_ДлительнаяОперация(Отказ, ПерейтиДалее)
	
	ПерейтиДалее = Ложь;
	ПриНачалеВыгрузкиДанныхДляСопоставления();
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Функция Подключаемый_СтраницаОкончание_ПриОткрытии(Отказ, ПропуститьСтраницу, ЭтоПереходДалее)
	
	Если Не ПроверкаПодключенияВыполнена Тогда
		Элементы.ПанельСостояниеЗавершения.ТекущаяСтраница = Элементы.СтраницаЗавершениеОшибкаПроверкаПодключения;
	ИначеЕсли Не РегистрацияИзмененийВыполнена Тогда
		Элементы.ПанельСостояниеЗавершения.ТекущаяСтраница = Элементы.СтраницаЗавершениеОшибкаРегистрацияИзменений;
	ИначеЕсли Не ВыгрузкаДанныхВыполнена Тогда
		Элементы.ПанельСостояниеЗавершения.ТекущаяСтраница = Элементы.СтраницаЗавершениеОшибкаВыгрузкаДанных;
	Иначе
		Элементы.ПанельСостояниеЗавершения.ТекущаяСтраница = Элементы.СтраницаЗавершениеУспех;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область ДополнительныеОбработчикиПереходов

&НаКлиенте
Процедура ИзменитьПорядковыйНомерПерехода(Итератор)
	
	ОчиститьСообщения();
	
	УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + Итератор);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПорядковыйНомерПерехода(Знач Значение)
	
	ЭтоПереходДалее = (Значение > ПорядковыйНомерПерехода);
	
	ПорядковыйНомерПерехода = Значение;
	
	Если ПорядковыйНомерПерехода < 1 Тогда
		
		ПорядковыйНомерПерехода = 1;
		
	КонецЕсли;
	
	ПорядковыйНомерПереходаПриИзменении(ЭтоПереходДалее);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядковыйНомерПереходаПриИзменении(Знач ЭтоПереходДалее)
	
	// Выполняем обработчики событий перехода.
	ВыполнитьОбработчикиСобытийПерехода(ЭтоПереходДалее);
	
	// Устанавливаем отображение страниц.
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Элементы.ПанельОсновная.ТекущаяСтраница  = Элементы[СтрокаПереходаТекущая.ИмяОсновнойСтраницы];
	Элементы.ПанельНавигации.ТекущаяСтраница = Элементы[СтрокаПереходаТекущая.ИмяСтраницыНавигации];
	
	Элементы.ПанельНавигации.ТекущаяСтраница.Доступность = Не (ЭтоПереходДалее И СтрокаПереходаТекущая.ДлительнаяОперация);
	
	// Устанавливаем текущую кнопку по умолчанию.
	КнопкаДалее = ПолучитьКнопкуФормыПоИмениКоманды(Элементы.ПанельНавигации.ТекущаяСтраница, "КомандаДалее");
	
	Если КнопкаДалее <> Неопределено Тогда
		
		КнопкаДалее.КнопкаПоУмолчанию = Истина;
		
	Иначе
		
		КнопкаГотово = ПолучитьКнопкуФормыПоИмениКоманды(Элементы.ПанельНавигации.ТекущаяСтраница, "КомандаГотово");
		
		Если КнопкаГотово <> Неопределено Тогда
			
			КнопкаГотово.КнопкаПоУмолчанию = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если ЭтоПереходДалее И СтрокаПереходаТекущая.ДлительнаяОперация Тогда
		
		ПодключитьОбработчикОжидания("ВыполнитьОбработчикДлительнойОперации", 0.1, Истина);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикиСобытийПерехода(Знач ЭтоПереходДалее)
	
	// Обработчики событий переходов.
	Если ЭтоПереходДалее Тогда
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода - 1));
		
		Если СтрокиПерехода.Количество() > 0 Тогда
			СтрокаПерехода = СтрокиПерехода[0];
		
			// Обработчик ПриПереходеДалее.
			Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеДалее)
				И Не СтрокаПерехода.ДлительнаяОперация Тогда
				
				ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
				ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеДалее);
				
				Отказ = Ложь;
				
				Результат = Вычислить(ИмяПроцедуры);
				
				Если Отказ Тогда
					
					УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
					
					Возврат;
					
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;
		
	Иначе
		
		СтрокиПерехода = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода + 1));
		
		Если СтрокиПерехода.Количество() > 0 Тогда
			СтрокаПерехода = СтрокиПерехода[0];
		
			// Обработчик ПриПереходеНазад.
			Если Не ПустаяСтрока(СтрокаПерехода.ИмяОбработчикаПриПереходеНазад)
				И Не СтрокаПерехода.ДлительнаяОперация Тогда
				
				ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ)";
				ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПерехода.ИмяОбработчикаПриПереходеНазад);
				
				Отказ = Ложь;
				
				Результат = Вычислить(ИмяПроцедуры);
				
				Если Отказ Тогда
					
					УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
					
					Возврат;
					
				КонецЕсли;
				
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	Если СтрокаПереходаТекущая.ДлительнаяОперация И Не ЭтоПереходДалее Тогда
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
		Возврат;
	КонецЕсли;
	
	// обработчик ПриОткрытии
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПропуститьСтраницу, ЭтоПереходДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаПриОткрытии);
		
		Отказ = Ложь;
		ПропуститьСтраницу = Ложь;
		
		Результат = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			
			Возврат;
			
		ИначеЕсли ПропуститьСтраницу Тогда
			
			Если ЭтоПереходДалее Тогда
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
				
				Возврат;
				
			Иначе
				
				УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
				
				Возврат;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбработчикДлительнойОперации()
	
	СтрокиПереходаТекущие = ТаблицаПереходов.НайтиСтроки(Новый Структура("ПорядковыйНомерПерехода", ПорядковыйНомерПерехода));
	
	Если СтрокиПереходаТекущие.Количество() = 0 Тогда
		ВызватьИсключение НСтр("ru = 'Не определена страница для отображения.'");
	КонецЕсли;
	
	СтрокаПереходаТекущая = СтрокиПереходаТекущие[0];
	
	// Обработчик ОбработкаДлительнойОперации.
	Если Не ПустаяСтрока(СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации) Тогда
		
		ИмяПроцедуры = "Подключаемый_[ИмяОбработчика](Отказ, ПерейтиДалее)";
		ИмяПроцедуры = СтрЗаменить(ИмяПроцедуры, "[ИмяОбработчика]", СтрокаПереходаТекущая.ИмяОбработчикаДлительнойОперации);
		
		Отказ = Ложь;
		ПерейтиДалее = Истина;
		
		Результат = Вычислить(ИмяПроцедуры);
		
		Если Отказ Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода - 1);
			
			Возврат;
			
		ИначеЕсли ПерейтиДалее Тогда
			
			УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
			
			Возврат;
			
		КонецЕсли;
		
	Иначе
		
		УстановитьПорядковыйНомерПерехода(ПорядковыйНомерПерехода + 1);
		
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьКнопкуФормыПоИмениКоманды(ЭлементФормы, ИмяКоманды)
	
	Для Каждого Элемент Из ЭлементФормы.ПодчиненныеЭлементы Цикл
		
		Если ТипЗнч(Элемент) = Тип("ГруппаФормы") Тогда
			
			ЭлементФормыПоИмениКоманды = ПолучитьКнопкуФормыПоИмениКоманды(Элемент, ИмяКоманды);
			
			Если ЭлементФормыПоИмениКоманды <> Неопределено Тогда
				
				Возврат ЭлементФормыПоИмениКоманды;
				
			КонецЕсли;
			
		ИначеЕсли ТипЗнч(Элемент) = Тип("КнопкаФормы")
			И СтрНайти(Элемент.ИмяКоманды, ИмяКоманды) > 0 Тогда
			
			Возврат Элемент;
			
		Иначе
			
			Продолжить;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#КонецОбласти
