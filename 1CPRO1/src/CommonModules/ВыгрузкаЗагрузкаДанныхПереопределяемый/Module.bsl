///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types

#Область ПрограммныйИнтерфейс

// Заполняет массив типов, для которых при выгрузке необходимо использовать аннотацию
// ссылок в файлах выгрузки.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Типы - Массив Из ОбъектМетаданных - массив типов ОбъектМетаданных.
//
Процедура ПриЗаполненииТиповТребующихАннотациюСсылокПриВыгрузке(Типы) Экспорт
КонецПроцедуры

// Заполняет массив типов неразделенных данных, для которых поддерживается сопоставление ссылок
// при загрузке данных в другую информационную базу.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Типы - Массив Из ОбъектМетаданных - массив типов ОбъектМетаданных.
//
Процедура ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
КонецПроцедуры

// Заполняет массив типов неразделенных данных, для которых не требуется сопоставление ссылок
// при загрузке данных в другую информационную базу, т.к. корректное сопоставление ссылок
// гарантируется с помощью других механизмов.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Типы - Массив Из ОбъектМетаданных - массив типов ОбъектМетаданных.
//
Процедура ПриЗаполненииТиповОбщихДанныхНеТребующихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
КонецПроцедуры

// Заполняет массив типов, исключаемых из выгрузки и загрузки данных.
//
// Параметры:
//  Типы - Массив Из ОбъектМетаданных - массив типов ОбъектМетаданных.
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
КонецПроцедуры

// Вызывается перед выгрузкой данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер контейнера, используемый в процессе
//   выгрузки данных. См. комментарий к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ПередВыгрузкойДанных(Контейнер) Экспорт
	
КонецПроцедуры

// Вызывается при регистрации произвольных обработчиков выгрузки данных. 
// В данной процедуре требуется дополнить таблицу обработкчиков информацией 
// о регистрируемых произвольных обработчиках выгрузки данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//	ТаблицаОбработчиков - ТаблицаЗначений - описание:
//	 * ОбъектМетаданных - ОбъектМетаданных - при выгрузке данных которого должен вызываться регистрируемый обработчик
//	 * Обработчик - ОбщийМодуль - общий модуль, в котором реализован произвольный обработчик выгрузки данных. 
//		Набор экспортных процедур, которые должны быть реализованы в обработчике, зависит от установки значений 
//		следующих колонок таблицы значений.
//	 * Версия - Строка - номер версии интерфейса обработчиков выгрузки / загрузки данных, поддерживаемого обработчиком
//	 * ПередВыгрузкойТипа - Булево - флаг необходимости вызова обработчика перед
//      	выгрузкой всех объектов информационной базы, относящихся к данному объекту
//      	метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      	быть реализована экспортируемая процедура ПередВыгрузкойТипа(),
//      	поддерживающая следующие параметры:
//        		Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//        		Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          		аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          		выполнять выгрузку дополнительных данных - следует использовать
//          	    СериализаторXDTO, переданный в процедуру ПередВыгрузкойТипа() в качестве
//          		значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          		контекста СериализаторXDTO,
//        		ОбъектМетаданных - ОбъектМетаданных - перед выгрузкой данных которого
//          		был вызван обработчик,
//        		Отказ - Булево - если в процедуре ПередВыгрузкойТипа() установить значение
//          		данного параметра равным Истина - выгрузка объектов, соответствующих
//          		текущему объекту метаданных, выполняться не будет.
//	 * ПередВыгрузкойОбъекта - Булево - флаг необходимости вызова обработчика перед
//      	выгрузкой конкретного объекта информационной базы. Если присвоено значение
//      	Истина - в общем модуле обработчика должна быть реализована экспортируемая процедура
//      	ПередВыгрузкойОбъекта(), поддерживающая следующие параметры:
//        		Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//        		МенеджерВыгрузкиОбъекта - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерВыгрузкиДанныхИнформационнойБазы -
//          		менеджер выгрузки текущего объекта. Подробнее см. комментарий к программному интерфейсу обработки
//          		ВыгрузкаЗагрузкаДанныхМенеджерВыгрузкиДанныхИнформационнойБазы. Параметр передается только при вызове
//          		процедур обработчиков, для которых при регистрации указана версия не ниже 1.0.0.1,
//        		Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          		аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          		выполнять выгрузку дополнительных данных - следует использовать
//          	    СериализаторXDTO, переданный в процедуру ПередВыгрузкойОбъекта() в качестве
//          		значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          		контекста СериализаторXDTO,
//        		Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект,
//          		БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          		ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          		РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          		РегистрРасчетаНаборЗаписей, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          		объект данных информационной базы, перед выгрузкой которого был вызван обработчик.
//          		Значение, переданное в процедуру ПередВыгрузкойОбъекта() в качестве значения параметра
//          		Объект может быть модифицировано внутри обработчика ПередВыгрузкойОбъекта(), при
//          		этом внесенные изменения будут отражены в сериализации объекта в файлах выгрузки, но
//          		не будут зафиксированы в информационной базе
//        		Артефакты - Массив Из ОбъектXDTO - набор дополнительной информации, логически неразрывно
//          		связанной с объектом, но не являющейся его частью (артефакты объекта). Артефакты должны
//          		сформированы внутри обработчика ПередВыгрузкойОбъекта() и добавлены в массив, переданный
//          		в качестве значения параметра Артефакты. Каждый артефакт должен являться XDTO-объектом,
//          		для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          		{http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          		помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных. В дальнейшем
//          		артефакты, сформированные в процедуре ПередВыгрузкойОбъекта(), будут доступны в процедурах
//          		обработчиков загрузки данных (см. комментарий к процедуре ПриРегистрацииОбработчиковЗагрузкиДанных().
//        		Отказ - Булево - если в процедуре ПередВыгрузкойОбъекта() установить значение
//           		данного параметра равным Истина - выгрузка объекта, для которого был вызван обработчик,
//           		выполняться не будет.
//	 * ПослеВыгрузкиТипа - Булево - флаг необходимости вызова обработчика после выгрузки всех
//      	объектов информационной базы, относящихся к данному объекту метаданных. Если присвоено значение
//      	Истина - в общем модуле обработчика должна быть реализована экспортируемая процедура
//      	ПослеВыгрузкиТипа(), поддерживающая следующие параметры:
//        		Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          		контейнера, используемый в процессе выгрузи данных. Подробнее см. комментарий
//          		к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//        		Сериализатор - СериализаторXDTO - инициализированный с поддержкой выполнения
//          		аннотации ссылок. В случае, если в произвольном обработчике выгрузки требуется
//          		выполнять выгрузку дополнительных данных - следует использовать
//          	    СериализаторXDTO, переданный в процедуру ПослеВыгрузкиТипа() в качестве
//          		значения параметра Сериализатор, а не полученных с помощью свойства глобального
//          		контекста СериализаторXDTO,
//        		ОбъектМетаданных - ОбъектМетаданных - после выгрузки данных которого
//          		был вызван обработчик.
//
Процедура ПриРегистрацииОбработчиковВыгрузкиДанных(ТаблицаОбработчиков) Экспорт
КонецПроцедуры

// Вызывается после выгрузки данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер контейнера, используемый в процессе
//   выгрузки данных. См. комментарий к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ПослеВыгрузкиДанных(Контейнер) Экспорт
КонецПроцедуры

// Вызывается перед загрузкой данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер контейнера, используемый в процессе 
//  загрузки данных. См. комментарий к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ПередЗагрузкойДанных(Контейнер) Экспорт
КонецПроцедуры

// Вызывается при регистрации произвольных обработчиков загрузки данных. 
// В данной процедуре требуется дополнить эту таблицу значений информацией 
// о регистрируемых произвольных обработчиках загрузки данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  ТаблицаОбработчиков - ТаблицаЗначений - описание:
//	 * ОбъектМетаданных - ОбъектМетаданных - при загрузке данных которого должен вызываться регистрируемый обработчик,
//	 * Обработчик - ОбщийМодуль - общий модуль, в котором реализован произвольный
//      обработчик загрузки данных. Набор экспортных процедур, которые должны
//      быть реализованы в обработчике, зависит от установки значений следующих
//      колонок таблицы значений.
//	 * Версия - Строка - номер версии интерфейса обработчиков выгрузки / загрузки данных, поддерживаемого обработчиком.
//	 * ПередСопоставлениемСсылок - Булево - флаг необходимости вызова обработчика перед
//      сопоставлением ссылок (в исходной ИБ и в текущей), относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередСопоставлениемСсылок(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных - перед сопоставлением ссылок которого был вызван обработчик.
//        СтандартнаяОбработка - Булево - если процедуре ПередСопоставлениемСсылок()
//          установить значение данного параметра равным Ложь, вместо стандартного
//          сопоставления ссылок (поиск объектов в текущей ИБ с теми же значениями
//          естественного ключа, которые были выгружены из ИБ-источника) будет
//          вызвана функция СопоставитьСсылки() общего модуля, в процедуре
//          ПередСопоставлениемСсылок() которого значение параметра СтандартнаяОбработка
//          было установлено равным Ложь.
//          Параметры функции СопоставитьСсылки():
//            Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//              контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//              к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//            ТаблицаИсходныхСсылок - ТаблицаЗначений - содержащая информацию о ссылках,
//              выгруженных из исходной ИБ. Колонки:
//                ИсходнаяСсылка - ЛюбаяСсылка - ссылка объекта исходной ИБ, которую требуется
//                  сопоставить c ссылкой в текущей ИБ,
//                Остальные колонки равным полям естественного ключа объекта, которые в
//                  процессе выгрузки данных были переданы в функцию
//                  Обработка.ВыгрузкаЗагрузкаДанныхМенеджерВыгрузкиДанныхИнформационнойБазы.ТребуетсяСопоставитьСсылкуПриЗагрузке()
//          Возвращаемое значение функции СопоставитьСсылки() - ТаблицаЗначений, колонки:
//            ИсходнаяСсылка - ЛюбаяСсылка - ссылка объекта, выгруженная из исходной ИБ,
//            Ссылка - ЛюбаяСсылка -  сопоставленная исходной ссылка в текущей ИБ.
//        Отказ - Булево - если в процедуре ПередСопоставлениемСсылок() установить значение
//          данного параметра равным Истина - сопоставление ссылок, соответствующих
//          текущему объекту метаданных, выполняться не будет.
//	 * ПередЗагрузкойТипа - Булево - флаг необходимости вызова обработчика перед
//      загрузкой всех объектов данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередЗагрузкойТипа(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект - ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных -  перед загрузкой всех данных которого
//          был вызван обработчик,
//        Отказ - Булево - если в процедуре ПередЗагрузкойТипа() установить значение данного
//          параметра равным Истина - загрузка всех объектов данных соответствующих текущему
//          объекту метаданных выполняться не будет.
//	 * ПередЗагрузкойОбъекта - Булево - флаг необходимости вызова обработчика перед
//      загрузкой объекта данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПередЗагрузкойОбъекта(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект,
//          БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          РегистрРасчетаНаборЗаписей, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          объект данных информационной базы, перед загрузкой которого был вызван обработчик.
//          Значение, переданное в процедуру ПередЗагрузкойОбъекта() в качестве значения параметра
//          Объект может быть модифицировано внутри процедуры обработчика ПередЗагрузкойОбъекта().
//        Артефакты - Массив Из ОбъектXDTO - дополнительные данные, логически неразрывно связанные
//          с объектом данных, но не являющиеся его частью. Сформированы в экспортируемых процедурах
//          ПередВыгрузкойОбъекта() обработчиков выгрузки данных (см. комментарий к процедуре
//          ПриРегистрацииОбработчиковВыгрузкиДанных(). Каждый артефакт должен являться XDTO-объектом,
//          для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных.
//        Отказ - Булево - если в процедуре ПередЗагрузкойОбъекта() установить значение данного
//          параметра равным Истина - загрузка объекта данных выполняться не будет.
//	 * ПослеЗагрузкиОбъекта - Булево - флаг необходимости вызова обработчика после
//      загрузки объекта данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПослеЗагрузкиОбъекта(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект - ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        Объект - КонстантаМенеджерЗначения, СправочникОбъект, ДокументОбъект,
//          БизнесПроцессОбъект, ЗадачаОбъект, ПланСчетовОбъект, ПланОбменаОбъект,
//          ПланВидовХарактеристикОбъект, ПланВидовРасчетаОбъект, РегистрСведенийНаборЗаписей,
//          РегистрНакопленияНаборЗаписей, РегистрБухгалтерииНаборЗаписей,
//          РегистрРасчетаНаборЗаписей*, ПоследовательностьНаборЗаписей, ПерерасчетНаборЗаписей -
//          объект данных информационной базы, после загрузки которого был вызван обработчик.
//        Артефакты - Массив Из ОбъектXDTO - дополнительные данные, логически неразрывно связанные
//          с объектом данных, но не являющиеся его частью. Сформированы в экспортируемых процедурах
//          ПередВыгрузкойОбъекта() обработчиков выгрузки данных (см. комментарий к процедуре
//          ПриРегистрацииОбработчиковВыгрузкиДанных(). Каждый артефакт должен являться XDTO-объектом,
//          для типа которого в качестве базового типа используется абстрактный XDTO-тип
//          {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}Artefact. Допускается использовать XDTO-пакеты,
//          помимо изначально поставляемых в составе подсистемы ВыгрузкаЗагрузкаДанных.
//	 * ПослеЗагрузкиТипа - Булево - флаг необходимости вызова обработчика после
//      загрузки всех объектов данных, относящихся к данному объекту
//      метаданных. Если присвоено значение Истина - в общем модуле обработчика должна
//      быть реализована экспортируемая процедура ПослеЗагрузкиТипа(),
//      поддерживающая следующие параметры:
//        Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//          контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//          к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//        ОбъектМетаданных - ОбъектМетаданных - после загрузки всех объектов которого
//          был вызван обработчик.
//
Процедура ПриРегистрацииОбработчиковЗагрузкиДанных(ТаблицаОбработчиков) Экспорт
КонецПроцедуры

// Вызывается после загрузки данных.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер контейнера, используемый в процессе
//   загрузки данных. См. комментарий к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ПослеЗагрузкиДанных(Контейнер) Экспорт
КонецПроцедуры

// Вызывается перед загрузкой пользователя информационной базы.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//    контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//    к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//  Сериализация - ОбъектXDTO - {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}InfoBaseUser,
//    сериализация пользователя информационной базы,
//  ПользовательИБ - ПользовательИнформационнойБазы - десериализованный из выгрузки,
//  Отказ - Булево - при установке значения данного параметра внутри этой процедуры в
//    значение Ложь загрузка пользователя информационной базы будет пропущена.
//
Процедура ПриЗагрузкеПользователяИнформационнойБазы(Контейнер, Сериализация, ПользовательИБ, Отказ) Экспорт
КонецПроцедуры

// Вызывается после загрузки пользователя информационной базы.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//    контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//    к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера,
//  Сериализация - ОбъектXDTO - {http://www.1c.ru/1cFresh/Data/Dump/1.0.2.1}InfoBaseUser,
//    сериализация пользователя информационной базы,
//  ПользовательИБ - ПользовательИнформационнойБазы - десериализованный из выгрузки.
//
Процедура ПослеЗагрузкиПользователяИнформационнойБазы(Контейнер, Сериализация, ПользовательИБ) Экспорт
КонецПроцедуры

// Вызывается после загрузки всех пользователей информационной базы.
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Контейнер - ОбработкаОбъект.ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера - менеджер
//    контейнера, используемый в процессе загрузки данных. Подробнее см. комментарий
//    к программному интерфейсу обработки ВыгрузкаЗагрузкаДанныхМенеджерКонтейнера.
//
Процедура ПослеЗагрузкиПользователейИнформационнойБазы(Контейнер) Экспорт
КонецПроцедуры

// Заполняет массив метаданных, исключаемых из выгрузки в режиме для технической поддержки.
// Ссылки на исключаемые ссылочные данные так же будут очищены
// @skip-warning ПустойМетод - переопределяемый метод.
//
// Параметры:
//  Метаданные - Массив Из ОбъектМетаданных - массив типов ОбъектМетаданных.
//
Процедура ПриЗаполненииМетаданныхИсключаемыхИзВыгрузкиВРежимеДляТехническойПоддержки(Метаданные) Экспорт
КонецПроцедуры

#КонецОбласти