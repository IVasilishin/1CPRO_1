///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types

#Область ПрограммныйИнтерфейс

// Устанавливает пользователю права по умолчанию.
// Вызывается при работе в модели сервиса, в случае обновления в менеджере
// сервиса прав пользователя без прав администрирования.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Пользователь - СправочникСсылка.Пользователи - пользователь, 
//                 которому требуется установить права по умолчанию.
//  ДоступРазрешен - Булево - признак разрешения доступа. 
//                   Если Истина - доступ разрешается, если Ложь - доступ запрещается.
//
Процедура УстановитьПраваПоУмолчанию(Пользователь, ДоступРазрешен = Истина) Экспорт
КонецПроцедуры

// Устанавливает пользователю права доступа к API области данных.
// Вызывается при работе в модели сервиса, в случае обновления в менеджере 
// сервиса прав пользователя без прав администрирования.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Пользователь - СправочникСсылка.Пользователи - пользователь, которому требуется установить права доступа к API.
//  ДоступРазрешен - Булево - признак разрешения доступа.  
//                   Если Истина - доступ разрешается, если Ложь - доступ запрещается.
//
Процедура УстановитьДоступКAPIОбластиДанных(Пользователь, ДоступРазрешен = Истина) Экспорт
КонецПроцедуры

#КонецОбласти 
