///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция Зашифровать(Знач Данные, Знач Получатели, Знач ТипШифрования, Знач ПараметрыШифрования) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Получатели", Получатели);
	ПараметрыПроцедуры.Вставить("ТипШифрования", ТипШифрования);
	ПараметрыПроцедуры.Вставить("ПараметрыШифрования", ПараметрыШифрования);
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(Данные));
	Данные = СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Данные);
	ПараметрыПроцедуры.Вставить("Данные", Данные);
			
	АдресаФайловРезультата = Новый Массив;
	Если ПараметрыПроцедуры.ВернутьРезультатКакАдресВоВременномХранилище Тогда
		Если ТипЗнч(Данные) = Тип("Массив") Тогда 
			ВсегоЭлементов = Данные;
		Иначе
			ВсегоЭлементов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Данные);
		КонецЕсли;		
		// @skip-warning НеиспользуемаяПеременная - особенность реализации.
		Для Каждого Элемент Из ВсегоЭлементов Цикл
			АдресаФайловРезультата.Добавить(ПоместитьВоВременноеХранилище(Неопределено, Новый УникальныйИдентификатор));
		КонецЦикла;
	КонецЕсли;
	ПараметрыПроцедуры.Вставить("АдресаФайловРезультата", АдресаФайловРезультата);
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.Зашифровать", ПараметрыПроцедуры);
	
КонецФункции

Функция ЗашифроватьБлок(Знач Данные, Знач Получатель) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Получатель", Получатель);
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(Данные));
	Данные = СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Данные);
	ПараметрыПроцедуры.Вставить("Данные", Данные);
			
	Если ПараметрыПроцедуры.ВернутьРезультатКакАдресВоВременномХранилище Тогда
		ПараметрыПроцедуры.Вставить("АдресФайлаРезультата", ПоместитьВоВременноеХранилище(Неопределено, Новый УникальныйИдентификатор));
	КонецЕсли;
		
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ЗашифроватьБлок", ПараметрыПроцедуры);
	
КонецФункции

Функция Расшифровать(Знач ЗашифрованныеДанные, Знач Сертификат, Знач ТипШифрования, Знач ПараметрыШифрования) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ЗашифрованныеДанные", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(ЗашифрованныеДанные));
	ПараметрыПроцедуры.Вставить("Сертификат", Сертификат);
	ПараметрыПроцедуры.Вставить("ТипШифрования", ТипШифрования);
	ПараметрыПроцедуры.Вставить("ПараметрыШифрования", ПараметрыШифрования);
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(ЗашифрованныеДанные));
	
	УстановитьПривилегированныйРежим(Истина);
	ПараметрыПроцедуры.Вставить("МаркерыБезопасности", ПараметрыСеанса.МаркерыБезопасности);
	УстановитьПривилегированныйРежим(Ложь);
	
	АдресаФайловРезультата = Новый Массив;
	АдресаФайловРезультата.Добавить(ПоместитьВоВременноеХранилище(Неопределено, Новый УникальныйИдентификатор));
	ПараметрыПроцедуры.Вставить("АдресаФайловРезультата", АдресаФайловРезультата);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.Расшифровать", ПараметрыПроцедуры);
	
КонецФункции

Функция РасшифроватьБлок(Знач ЗашифрованныеДанные, Знач Получатель, Знач КлючеваяИнформация, Знач ПараметрыШифрования) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ЗашифрованныеДанные", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(ЗашифрованныеДанные));
	ПараметрыПроцедуры.Вставить("Получатель", Получатель);
	ПараметрыПроцедуры.Вставить("КлючеваяИнформация", КлючеваяИнформация);	
	ПараметрыПроцедуры.Вставить("ПараметрыШифрования", ПараметрыШифрования);
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(ЗашифрованныеДанные));
	
	УстановитьПривилегированныйРежим(Истина);
	ПараметрыПроцедуры.Вставить("МаркерыБезопасности", ПараметрыСеанса.МаркерыБезопасности);
	УстановитьПривилегированныйРежим(Ложь);
	
	АдресФайлаРезультата = ПоместитьВоВременноеХранилище(Неопределено, Новый УникальныйИдентификатор);
	ПараметрыПроцедуры.Вставить("АдресФайлаРезультата", АдресФайлаРезультата);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.РасшифроватьБлок", ПараметрыПроцедуры);
	
КонецФункции

Функция Подписать(Знач Данные, Знач Подписант, Знач ТипПодписи, Знач ПараметрыПодписания) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Подписант", Подписант);
	ПараметрыПроцедуры.Вставить("ТипПодписи", ТипПодписи);
	ПараметрыПроцедуры.Вставить("ПараметрыПодписания", ПараметрыПодписания);
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(Данные));
	Данные = СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Данные);
	ПараметрыПроцедуры.Вставить("Данные", Данные);
	
	УстановитьПривилегированныйРежим(Истина);
	ПараметрыПроцедуры.Вставить("МаркерыБезопасности", ПараметрыСеанса.МаркерыБезопасности);
	УстановитьПривилегированныйРежим(Ложь);
	
	АдресаФайловРезультата = Новый Массив;
	Если ПараметрыПроцедуры.ВернутьРезультатКакАдресВоВременномХранилище Тогда
		Если ТипЗнч(Данные) = Тип("Массив") Тогда 
			ВсегоЭлементов = Данные;
		Иначе
			ВсегоЭлементов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Данные);
		КонецЕсли;		
		// @skip-warning НеиспользуемаяПеременная - особенность реализации.
		Для Каждого Элемент Из ВсегоЭлементов Цикл
			АдресаФайловРезультата.Добавить(ПоместитьВоВременноеХранилище(Неопределено, Новый УникальныйИдентификатор));
		КонецЦикла;
	КонецЕсли;
	ПараметрыПроцедуры.Вставить("АдресаФайловРезультата", АдресаФайловРезультата);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.Подписать", ПараметрыПроцедуры);	
	
КонецФункции

Функция ПроверитьПодпись(Знач Подпись, Знач Данные, Знач ТипПодписи, Знач ПараметрыПодписания) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Данные", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Данные));
	ПараметрыПроцедуры.Вставить("Подпись", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Подпись));
	ПараметрыПроцедуры.Вставить("ТипПодписи", ТипПодписи);
	ПараметрыПроцедуры.Вставить("ПараметрыПодписания", ПараметрыПодписания);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ПроверитьПодпись", ПараметрыПроцедуры);	
	
КонецФункции

Функция ПроверитьСертификат(Знач Сертификат) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Сертификат", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Сертификат));
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ПроверитьСертификат", ПараметрыПроцедуры);	

КонецФункции

Функция ПолучитьСвойстваСертификата(Знач Сертификат) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Сертификат", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Сертификат));
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ПолучитьСвойстваСертификата", ПараметрыПроцедуры);	
	
КонецФункции

Функция ПолучитьСертификатыИзПодписи(Знач Подпись) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Подпись", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Подпись));
	ПараметрыПроцедуры.Вставить("ВернутьРезультатКакАдресВоВременномХранилище", СервисКриптографииСлужебный.ВернутьРезультатКакАдресВоВременномХранилище(Подпись));
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ПолучитьСертификатыИзПодписи", ПараметрыПроцедуры);	
	
КонецФункции

Функция ПолучитьСвойстваКриптосообщения(Знач Криптосообщение, Знач ТолькоКлючевыеСвойства) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Криптосообщение", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Криптосообщение));
	ПараметрыПроцедуры.Вставить("ТолькоКлючевыеСвойства", ТолькоКлючевыеСвойства);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ПолучитьСвойстваКриптосообщения", ПараметрыПроцедуры);
	
КонецФункции

Функция ХешированиеДанных(Знач Данные, Знач АлгоритмХеширования, Знач ПараметрыХеширования) Экспорт
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Данные", СервисКриптографииСлужебный.ИзвлечьДвоичныеДанныеПриНеобходимости(Данные));
	ПараметрыПроцедуры.Вставить("АлгоритмХеширования", АлгоритмХеширования);
	ПараметрыПроцедуры.Вставить("ПараметрыХеширования", ПараметрыХеширования);
	
	Возврат СервисКриптографииСлужебный.ВыполнитьВФоне("СервисКриптографииСлужебный.ХешированиеДанных", ПараметрыПроцедуры);	
	
КонецФункции

#КонецОбласти
