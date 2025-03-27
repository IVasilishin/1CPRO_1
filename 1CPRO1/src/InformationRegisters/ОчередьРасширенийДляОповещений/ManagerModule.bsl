///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Процедура УстановитьОповещение(Знач ИдентификаторРасширения, Знач Пользователь, Знач Состояние) Экспорт
	
	Если ТипЗнч(ИдентификаторРасширения) <> Тип("УникальныйИдентификатор") Тогда
		ИдентификаторРасширения = Новый УникальныйИдентификатор(ИдентификаторРасширения);
	КонецЕсли;
	
	НоваяЗапись = РегистрыСведений.ОчередьРасширенийДляОповещений.СоздатьМенеджерЗаписи();
	НоваяЗапись.ИдентификаторРасширения = ИдентификаторРасширения;
	НоваяЗапись.Пользователь = Пользователь;
	НоваяЗапись.Состояние = Состояние;
	
	УстановитьПривилегированныйРежим(Истина);
	НоваяЗапись.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
