///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда		
		
		Возврат;
		
	КонецЕсли;
	
	ЗначениеКонстанты = Константы.ИспользоватьЭлектроннуюПодписьВМоделиСервиса.Получить();
	ДополнительныеСвойства.Вставить("ТекущееЗначение", ЗначениеКонстанты);
			
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда		
		
		Возврат;
		
	КонецЕсли;
	
	Если ДополнительныеСвойства.ТекущееЗначение <> Значение Тогда
		
		ОбновитьПовторноИспользуемыеЗначения();
		
		Если Значение Тогда			
			ЭлектроннаяПодписьВМоделиСервисаПереопределяемый.ПриВключенииСервисаКриптографии();			
		КонецЕсли;
		
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти

#КонецЕсли