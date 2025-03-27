///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Оповещение = Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект);
	ПроверкаЛегальностиПолученияОбновленияКлиент.ПоказатьПроверкуЛегальностиПолученияОбновления(Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаКомандыЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Перем ТекстСообщения;
	
	Если Результат = Истина Тогда
		ТекстСообщения = НСтр("ru = 'Легальность получения обновления подтверждена.'");
	Иначе
		ТекстСообщения = НСтр("ru = 'Обновление получено нелегально.'");
	КонецЕсли;
	
	ПоказатьПредупреждение(,ТекстСообщения);
	
КонецПроцедуры

#КонецОбласти