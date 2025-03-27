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
	Если ДополнительныеСвойства.Свойство("ПометкаУдаленияЗаметки") И ДополнительныеСвойства.ПометкаУдаленияЗаметки Тогда
		Возврат;
	КонецЕсли;
		
	Если ЗначениеЗаполнено(Родитель) И Родитель.Автор <> Автор Тогда
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru = 'Нельзя указывать группу другого пользователя.'"));
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоГруппа Тогда 
		ДатаИзменения = ТекущаяДатаСеанса();
		ПредставлениеПредмета = ОбщегоНазначения.ПредметСтрокой(Предмет);
		
		Позиция = СтрНайти(ТекстСодержания, Символы.ПС);
		Если Позиция > 0 Тогда
			Тема = Сред(ТекстСодержания, 1, Позиция - 1);
		Иначе
			Тема = ТекстСодержания;
		КонецЕсли;
		
		Если ПустаяСтрока(Тема) Тогда 
			Тема = "<" + НСтр("ru = 'Пустая заметка'") + ">";
		КонецЕсли;
		
		МаксимальнаяДлинаНаименования = Метаданные().ДлинаНаименования;
		Если СтрДлина(Тема) > МаксимальнаяДлинаНаименования Тогда
			Тема = Лев(Наименование, МаксимальнаяДлинаНаименования - 3) + "...";
		КонецЕсли;
		
		Наименование = Тема;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли