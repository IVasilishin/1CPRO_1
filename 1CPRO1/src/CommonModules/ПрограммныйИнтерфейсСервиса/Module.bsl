///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types

#Область ПрограммныйИнтерфейс

// Возвращает свойства версии программного интерфейса менеджера сервиса.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  Структура - свойства версии внешнего программного интерфейса:
//   * Версия - Число - номер версии внешнего программного интерфейса.
//   * ВерсияМенеджераСервиса - Строка - номер версии менеджера сервиса.
//   * ЧасовойПоясМенеджераСервиса - Строка - часовой пояс менеджера сервиса.
//
Функция СвойстваВерсииИнтерфейса() Экспорт
КонецФункции

#Область Account

// Возвращает список тарифов обслуживающей организации.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодОО - Число - код обслуживающей организации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - список тарифов:
//   * Код - Строка - код тарифа
//   * Наименование - Строка - наименование тарифа
//   * КодБазовогоТарифа - Строка - код базового тарифа
//
Функция ТарифыОбслуживающейОрганизации(КодОО) Экспорт
КонецФункции

// Возвращает HTML-страницу выбора тарифа обслуживающей организации абонента этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодОО - Число - код обслуживающей организации.
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Строка - HTML-страница выбора тарифа обслуживающей организации.
//
Функция СтраницаВыбораТарифаОбслуживающейОрганизации(КодОО,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Возвращает список обслуживающих организаций абонента этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Возвращаемое значение:
//  ТаблицаЗначений - обслуживающие организации абонента:
//   * Код - Число - код (номер) обслуживающей организации
//   * Наименование - Строка - наименование обслуживающей организации
//   * Город - Строка - город
//   * Сайт - Строка - сайт
//   * Почта - Строка - электронная почта
//   * Телефон - Строка - телефон
//   * РазрешеноПодписыватьНаТарифы - Булево - разрешено подписывать на тарифы
//   * РазрешеноАвтоматическоеВыставлениеСчетов - Булево - разрешено автоматическое выставление счетов
//   * РазрешеноПереопределениеТарифов - Булево - разрешено переопределение тарифов
//
Функция ОбслуживающиеОрганизацииАбонента() Экспорт
КонецФункции

// Возвращает список пользователей абонента этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - пользователи абонента:
//   * Логин - Строка - логин (имя) пользователя
//   * ПолноеИмя - Строка - полное имя пользователя
//   * Почта - Строка - электронная почта пользователя
//   * РольПользователя - ПеречислениеСсылка.РолиПользователейАбонентов - роль пользователя
//   * РазрешенноеКоличествоСеансов - Число - разрешенное количество сеансов
//   * ВременныйДоступ - Булево - временный доступ
//
Функция ПользователиАбонента() Экспорт
КонецФункции

// Возвращает свойства пользователя абонента по логину.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  Логин - Строка - Логин (Имя) пользователя.
// 
// Возвращаемое значение:
//  Структура - свойства пользователя абонента:
//   * Логин - Строка - логин (имя) пользователя
//   * ПолноеИмя - Строка - полное имя пользователя
//   * Почта - Строка - электронная почта пользователя
//   * РольПользователя - ПеречислениеСсылка.РолиПользователейАбонентов - роли пользователя
//   * РазрешенноеКоличествоСеансов - Число - разрешенное количество сеансов
//   * ВременныйДоступ - Булево - временный доступ
//
Функция СвойстваПользователяАбонента(Логин) Экспорт
КонецФункции

// Создает новую учетную запись пользователя сервиса и подключает созданного пользователя к абоненту этого приложения. 
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ПараметрыСоздания - Структура - см. метод ПрограммныйИнтерфейсСервиса.НовыйПараметрыСозданияПользователя
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Булево - признак создания учетной записи Истина - создана, Ложь - произошла ошибка.
//
Функция СоздатьПользователяАбонента(ПараметрыСоздания,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Устанавливает указанному пользователю абонента этого приложения указанную роль.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  Логин - Строка - логин (имя) пользователя. 
//  Роль - ПеречислениеСсылка.РолиПользователейАбонентов - устанавливаемая роль пользователя.
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message".
// 
// Возвращаемое значение:
//  Булево - установки роли Истина - установлено, Ложь - произошла ошибка.
//
Функция УстановитьРольПользователяАбонента(Логин, Роль,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Возвращает список абонентов текущего пользователя.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - список абонентов:
//    * Наименование - Строка - наименование абонента
//    * Код - Число - код абонента
//    * РольПользователя - ПеречислениеСсылка.РолиПользователейАбонентов - роль текущего пользователя абонента.
//
Функция Абоненты() Экспорт
КонецФункции

// Возвращает дополнительные сведения (реквизиты и свойства) абонента этого приложения.
// Реализует метод внешнего программного интерфейса - account/attached_info.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Параметры:
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message".
// 
// Возвращаемое значение:
//  Структура - дополнительные реквизиты и свойства абонента:
//   * Реквизиты - ТаблицаЗначений - дополнительные реквизиты абонента:
//     ** Ключ - Строка - имя дополнительного реквизита
//     ** Тип - Строка - тип значения 
//     ** Значение - Строка, Число, Дата, Булево - значение дополнительного реквизита
//   * Свойства - ТаблицаЗначений - дополнительные свойства абонента:
//     ** Ключ - Строка - имя дополнительного свойства
//     ** Тип - Строка - тип значения
//     ** Значение - Строка, Число, Дата, Булево - значение дополнительного свойства
//
Функция ДополнительныеСведенияАбонента(ВызыватьИсключениеПриОшибке = Истина,
		КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Возвращает информацию о тарифе обслуживающей организаций.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодОО - Число - код обслуживающей организации.
//  КодТарифа - Строка - код тарифа обслуживающей организации. 
// 
// Возвращаемое значение:
//  Структура - информация о тарифе:
//   * Код - Строка - код тарифа
//   * Наименование - Строка - наименование тарифа
//   * КодТарифаПровайдера - Строка - код тарифа провайдера
//   * ОписаниеДляАбонентов - ФорматированныйДокумент - описание тарифа для абонентов.
//   * ПериодыДействия - ТаблицаЗначений - периоды действия тарифа:
//     ** Код - Строка - код периода действия
//     ** Наименование - Строка - наименование периода действия
//     ** Сумма - Число - стоимость
//     ** Комментарий - Строка - комментарий к периоду действия
//
Функция ТарифОбслуживающейОрганизации(КодОО, КодТарифа) Экспорт
КонецФункции

#КонецОбласти

#Область Application

// Возвращает список прикладных конфигураций, доступных абоненту этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - доступные конфигурации:
//    * Код - Строка - код конфигурации
//    * Наименование - Строка - синоним конфигурации 
//    * Имя - Строка - имя конфигурации (как оно задано в конфигураторе).
//    * Описание - Строка - описание конфигурации 
//    * КодАбонента - Число - код абонента. 
//
Функция Конфигурации() Экспорт
КонецФункции

#КонецОбласти

#Область Tenant

// Возвращает данные абонента этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//	Пользователь - СправочникСсылка.Пользователи - пользователь абонента которого требуется определить	
// 
// Возвращаемое значение:
//  Структура - данные абонента:
//    * Наименование - Строка - наименование абонента
//    * Код - Число - код абонента
//    * РольПользователя - ПеречислениеСсылка.РолиПользователейАбонентов - роль текущего пользователя абонента.
//
Функция АбонентЭтогоПриложения(Знач Пользователь = Неопределено) Экспорт
КонецФункции

// Возвращает список приложений, доступных пользователю абонента этого приложения. 
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - доступные приложения:
//   * Код - Число - код (номер) приложения
//   * Наименование - Строка - наименование
//   * КодАбонентаВладельца - Число - код абонента, владельца приложения
//   * КодКонфигурации - Число - код конфигурации
//   * ВерсияКонфигурации - Строка - версия конфигурации
//   * НаименованиеКонфигурации - Строка - наименование конфигурации
//   * СостояниеПриложения - ПеречислениеСсылка.СостоянияПриложений - состояние приложения
//   * АдресПриложения - Строка - URL-адрес приложения
//   * ЧасовойПояс - Строка - часовой пояс приложения
//
Функция Приложения() Экспорт
КонецФункции

// Возвращает информацию об указанном приложении.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодПриложения - Строка - код приложения (номер области).
// 
// Возвращаемое значение:
//  Структура - свойства приложения:
//   * Код - Число - код (номер) приложения
//   * Наименование - Строка- наименование
//   * КодАбонентаВладельца - Число - код абонента, владельца приложения
//   * КодКонфигурации - Число - код конфигурации
//   * ВерсияКонфигурации - Строка - версия конфигурации
//   * НаименованиеКонфигурации - Строка - наименование конфигурации
//   * СостояниеПриложения - ПеречислениеСсылка.СостоянияПриложений - состояние приложения
//   * АдресПриложения - Строка - URL-адрес приложения
//   * ЧасовойПояс - Строка - часовой пояс приложения
//
Функция СвойстваПриложения(КодПриложения) Экспорт
КонецФункции

// Возвращает список пользователей, которым разрешен доступ к указанному приложению.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодПриложения - Число - код приложения (номер области)
// 
// Возвращаемое значение:
//  ТаблицаЗначений - пользователи, которым разрешен доступ:
//   * Логин - Строка - логин (имя) пользователя
//   * Роль - ПеречислениеСсылка.ПраваПользователяПриложения - право пользователя на текущее приложение в менеджере сервиса 
//
Функция ПользователиПриложения(КодПриложения) Экспорт
КонецФункции

// Устанавливает пользователю с указанным логином доступ к указанному приложению и назначает указанную роль для работы в
// приложении. @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ПараметрыДобавления - Структура - см. метод ПрограммныйИнтерфейсСервиса.НовыйПараметрыДобавленияПользователяВПриложение
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Булево - результат установки права доступа к приложению: Истина - право установлено, Ложь - произошла ошибка.
//
Функция ДобавитьПользователяВПриложение(ПараметрыДобавления,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Отменяет пользователю с указанным логином доступ к указанному приложению.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  Логин - Строка - Логин (Имя) пользователя.
//  КодПриложения - Число - код приложения (номер области)
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Булево - результат отмены права доступа к приложению: Истина - право отменено, Ложь - произошла ошибка.
//
Функция УдалитьПользователяИзПриложения(Логин, КодПриложения,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

// Метод создает новое приложение с указанной прикладной конфигурацией.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ПараметрыСоздания - см. НовыйПараметрыСозданияПриложения
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Структура - результат создания приложения:
//   * Код - Число - код созданного приложения (номер области)
//   * СостояниеПриложения - ПеречислениеСсылка.СостоянияПриложений - состояние приложения после создания.
//   * АдресПриложения - Строка - адрес созданного приложения.
//
Функция СоздатьПриложение(ПараметрыСоздания,
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

#КонецОбласти

#Область Tariff

// Возвращает информацию о тарифе сервиса по коду тарифа.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  КодТарифа - Строка - код тарифа.
//
// Возвращаемое значение:
//  Структура - информация о тарифе:
//   * Код - Строка - код тарифа
//   * Наименование - Строка - наименование тарифа
//   * ОписаниеДляОбслуживающихОрганизаций - Строка - описание тарифа для обслуживающей организации.
//   * ОписаниеДляАбонентов - ФорматированныйДокумент - описание тарифа для абонентов.
//   * ДатаНачалаДействия - Дата - дата начала действия тарифа.
//   * ДатаОкончанияДействия - Дата - дата окончания действия тарифа.
//   * ПериодДействияПродлевающейПодписки - Число - период (в днях), в течение которого действует продлевающая подписка
//                                                  (если разрешено продление).
//   * ПериодДействияРасширяющейПодписки - Число - период (в днях), в течение которого действует расширяющая подписка.
//   * ПериодДобавленияПродлевающейПодписки - Число - период (в днях) после завершения действия подписки, в течение
//                                                    которого можно создать продлевающую подписку.
//   * РасширениеТарифа - Булево - признак, что тариф является расширением
//   * Платный - Булево - признак, что тариф является платным (содержит платные периоды действия)
//   * Услуги - ТаблицаЗначений - услуги тарифа:
//     ** Код - Строка - код услуги
//     ** Наименование - Строка - Наименование услуги
//     ** ТипУслуги - ПеречислениеСсылка.ТипыУслуг - тип услуги
//     ** Описание - Строка - Описание услуги
//     ** КоличествоЛицензий - Число - количество лицензий на услугу, включенное в тариф
//     ** КоличествоДопЛицензийРасширяющейПодписки - Число - количество лицензий на услугу, которое может быть
//                                                           предоставлено расширяющей подпиской
//     ** ИдентификаторПоставщика - Строка - идентификатор поставщика услуги
//     ** НаименованиеПоставщика - Строка - наименование поставщика услуги
//   * Расширения - ТаблицаЗначений - расширения тарифа:
//     ** Код - Строка - код тарифа-расширения
//     ** Наименование - Строка - наименование тарифа-расширения
//   * Конфигурации - ТаблицаЗначений - конфигурации тарифа:
//     ** Код - Строка - код конфигурации
//     ** Наименование - Строка - имя конфигурации
//     ** Описание - Строка - описание конфигурации
//   * ПериодыДействия - ТаблицаЗначений - периоды действия тарифа:
//     ** Код - Строка - код периода действия
//     ** Наименование - Строка - наименование периода действия
//     ** Сумма - Число - стоимость
//     ** Комментарий - Строка - комментарий к периоду действия
//
Функция ТарифСервиса(КодТарифа) Экспорт
КонецФункции

// Возвращает список тарифов сервиса, доступных абоненту этого приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Возвращаемое значение:
//  ТаблицаЗначений - список тарифов сервиса:
//   * Код - Строка - код тарифа
//   * Наименование - Строка - наименование тарифа
//   * ОписаниеДляОбслуживающихОрганизаций - Строка - описание тарифа для обслуживающей организации.
//   * ОписаниеДляАбонентов - ФорматированныйДокумент - описание тарифа для абонентов.
//   * ДатаНачалаДействия - Дата - дата начала действия тарифа.
//   * ДатаОкончанияДействия - Дата - дата окончания действия тарифа.
//   * ПериодДействияПродлевающейПодписки - Число - период (в днях), в течение которого действует продлевающая подписка
//                                                  (если разрешено продление).
//   * ПериодДействияРасширяющейПодписки - Число - период (в днях), в течение которого действует расширяющая подписка.
//   * ПериодДобавленияПродлевающейПодписки - Число - период (в днях) после завершения действия подписки, в течение
//                                                    которого можно создать продлевающую подписку.
//   * РасширениеТарифа - Булево - признак, что тариф является расширением
//   * Платный - Булево - признак, что тариф является платным (содержит платные периоды действия)
//
Функция ТарифыСервиса() Экспорт
КонецФункции

#КонецОбласти

#Область Subscription

// Возвращает список существующих подписок абонента текущего приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Возвращаемое значение:
//  ТаблицаЗначений - существующие подписки абонента:
//   * КодАбонента - Число - код (номер) абонента
//   * Номер - Строка - номер подписки
//   * Дата - Дата - дата регистрации подписки
//   * ТипПодписки - ПеречислениеСсылка.ТипыПодписокСервиса - тип подписки
//   * КодОбслуживающейОрганизации - Число - код (номер) абонента обслуживающей организации
//   * ДатаПодключения - Дата - дата подключения тарифа по подписке
//   * ДатаОтключения - Дата - дата отключения тарифа
//   * КодТарифа - Строка - код тарифа в подписке
//   * КодТарифаОбслуживающейОрганизации - Строка - код тарифа обслуживающей организации
//   * НомерОсновнойПодписки - Строка - номер основной подписки, если текущая подписка на тариф-расширение.
//
Функция ПодпискиАбонента() Экспорт
КонецФункции

#КонецОбласти

#Область Promo_code

// Выполняет активацию указанного промо-кода для абонента текущего приложения.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  Промокод - Строка - используемый промокод.
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Булево - результат использования: Истина - промокод активирован, Ложь - произошла ошибка.
//
Функция ИспользоватьПромокод(Промокод, ВызыватьИсключениеПриОшибке = Истина,
		КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
КонецФункции

#КонецОбласти

#Область Sessions

// Выполняет завершение сеансов пользователей.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Параметры:
// 	НомераСеансов - Массив Из Число - номера сеансов, которые требуется завершить.
// 	Пользователь - СправочникСсылка.Пользователи - пользователь абонента, от имени которого выполняется операция.
// 
Процедура ЗавершитьСеансы(Знач НомераСеансов, Знач Пользователь = Неопределено) Экспорт
КонецПроцедуры

#КонецОбласти

#Область Task

// Возвращает список активных задач плользователя из МС, относящихся к текущей области пользователя
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  ТаблицаЗначений - результат выполнения задачи: Истина - задача выполнена, Ложь - произошла ошибка.
//		*НомерЗадачи - Строка - номер задачи
//		*НаименованиеЗадачи - Строка - номер задачи
Функция Задачи() Экспорт

КонецФункции

// Возвращает описание задачи пользователя.
// @skip-warning ПустойМетод - особенность реализации.
// Параметры:
//  НомерЗадачи - Строка - номер задачи, для которой требуется получить данные.
// Возвращаемое значение:
//  Структура - Описание задачи.
//		*type - Строка - тип задачи
//		*author - Строка - автор задачи
//		*description - Строка - описание задачи
//		*tenant - Строка - Наименование приложения
//		*subscriber - Строка - 	Наименование ведущего абонента (Абонент ОО или ЛК)
//		*backup_type - Строка - Вид запрашиваемой резервной копии (Для тех.поддержки или нет)
Функция СвойстваЗадачи(НомерЗадачи) Экспорт
	
КонецФункции

// Выполнение задачи пользователя, отказ или согласование.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//  ПараметрыЗапроса - Структура - см. метод ПрограммныйИнтерфейсСервиса.НовыйПараметрыДобавленияПользователяВПриложение
//  ВызыватьИсключениеПриОшибке - Булево - признак вызова исключения при ошибке получения данных.
//  КодСостояния - Число - возвращаемый параметр - код состояния ответа HTTP-сервиса.
//  КодОтвета - Число - возвращаемый параметр - заполняется из ответа значением свойства "general.response".
//  Сообщение - Строка - возвращаемый параметр - заполняется из ответа значением свойства "general.message". 
// 
// Возвращаемое значение:
//  Булево - результат выполнения задачи: Истина - задача выполнена, Ложь - произошла ошибка.
Функция ВыполнитьЗадачу(ПараметрыЗапроса, 
		ВызыватьИсключениеПриОшибке = Истина, КодСостояния = 0, КодОтвета = 0, Сообщение = "") Экспорт
		
КонецФункции

#КонецОбласти

// Возвращает шаблон параметров создания пользователя для метода ПрограммныйИнтерфейсСервиса.СоздатьПользователяАбонента.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  Структура - шаблон параметров создания пользователя:
//	 * Логин - Строка - логин (имя пользователя)
//	 * Пароль - Строка - пароль пользователя
//   * ПочтаОбязательна - Булево - признак обязательной установки почты (по умолчанию = Истина)
//   * Почта - Строка - электронная почта
//   * РольПользователя - ПеречислениеСсылка.РолиПользователейАбонентов - роль пользователя (по умолчанию = ПользовательАбонента)
//   * ПолноеИмя - Строка - полное имя (наименование) пользователя
//   * Телефон - Строка - телефон пользователя
//   * ЧасовойПояс - Строка - рабочий часовой пояс пользователя
//
Функция НовыйПараметрыСозданияПользователя() Экспорт
КонецФункции

// Возвращает шаблон параметров создания приложения для метода ПрограммныйИнтерфейсСервиса.СоздатьПриложение.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  Структура - шаблон параметров создания приложения:
//	 * Наименование - Строка - наименование создаваемого приложения.
//	 * КодКонфигурации - Строка - кон конфигурации (вид приложения) 
//   * ЧасовойПояс - Строка - рабочий часовой пояс приложения
Функция НовыйПараметрыСозданияПриложения() Экспорт
КонецФункции

// Возвращает шаблон параметров добавления пользователя в приложение для метода ПрограммныйИнтерфейсСервиса.ДобавитьПользователяВПриложение.
// @skip-warning ПустойМетод - особенность реализации.
// 
// Возвращаемое значение:
//  Структура - шаблон параметров добавления пользователя в приложение:
//	 * КодПриложения - Строка - наименование создаваемого приложения.
//	 * Логин - Строка - логин (имя пользователя) 
//   * Право - ПеречислениеСсылка.ПраваПользователяПриложения - право пользователя на приложение в менеджере сервиса 
//
Функция НовыйПараметрыДобавленияПользователяВПриложение() Экспорт
КонецФункции

#КонецОбласти

