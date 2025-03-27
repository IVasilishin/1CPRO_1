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
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиФормы.Верх;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиКСписку(Команда)
	Закрыть();
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ПоказыватьТолькоПользовательскиеИзмененные", Истина);
	
	ОткрытьФорму("РегистрСведений.ПользовательскиеМакетыПечати.Форма.МакетыПечатныхФорм", ПараметрыФормы);
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура Проверено(Команда)
	ОтметитьВыполнениеДела();
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОтметитьВыполнениеДела()
	
	ВерсияМассив  = СтрРазделить(Метаданные.Версия, ".");
	ТекущаяВерсия = ВерсияМассив[0] + ВерсияМассив[1] + ВерсияМассив[2];
	ХранилищеОбщихНастроек.Сохранить("ТекущиеДела", "ПечатныеФормы", ТекущаяВерсия);
	
КонецПроцедуры

#КонецОбласти