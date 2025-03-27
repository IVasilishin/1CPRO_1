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
	
	КлючеваяОперация = Параметры.НастройкиИстории.КлючеваяОперация;
	ДатаНачала = Параметры.НастройкиИстории.ДатаНачала;
	ДатаОкончания = Параметры.НастройкиИстории.ДатаОкончания;
	Приоритет = КлючеваяОперация.Приоритет;
	ЦелевоеВремя = КлючеваяОперация.ЦелевоеВремя;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("КлючеваяОперация", КлючеваяОперация);
	Запрос.УстановитьПараметр("ДатаНачала", (ДатаНачала - Дата(1,1,1)) * 1000);
	Запрос.УстановитьПараметр("ДатаОкончания", (ДатаОкончания - Дата(1,1,1)) * 1000);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗамерыВремени.Пользователь КАК Пользователь,
	|	ЗамерыВремени.ВремяВыполнения КАК Длительность,
    |   ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(2015,1,1), СЕКУНДА, (ЗамерыВремени.ДатаНачалаЗамера/1000) - 63555667200) КАК ВремяОкончания
	|ИЗ
	|	РегистрСведений.ЗамерыВремени КАК ЗамерыВремени
	|ГДЕ
	|	ЗамерыВремени.КлючеваяОперация = &КлючеваяОперация
	|	И ЗамерыВремени.ДатаНачалаЗамера МЕЖДУ &ДатаНачала И &ДатаОкончания
	|УПОРЯДОЧИТЬ ПО
	|	ВремяОкончания";
    
    Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	КоличествоЗамеровЧисло = Выборка.Количество();
	КоличествоЗамеров = Строка(КоличествоЗамеровЧисло) + ?(КоличествоЗамеровЧисло < 100, " (недостаточно)", "");
	
	Пока Выборка.Следующий() Цикл
		
		СтрокаИстории = История.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаИстории, Выборка);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИстория

// Запрещает редактирование ключевой операции из формы обработки
// т.к. могут пострадать внутренние механизмы.
//
&НаКлиенте
Процедура КлючеваяОперацияОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

#КонецОбласти
