# Flac-Radio
An open source radio application developed as a learning project.  The project is still in development, and constructive feedback is welcome.

# План новой архитектуры Flac-Radio

## Почему меняем
Текущая структура смешивает ответственности между слоями (`core/data/services/features`), из-за чего:
- трудно предсказать, где должен жить новый код;
- появляются «толстые» файлы с несколькими ролями;
- накапливаются лишние абстракции (много геттеров/провайдеров/обёрток без явной пользы).

Цель: перейти к **feature-first + clean boundaries** с минимально необходимой абстракцией.

---

## Принципы (обязательные правила)

1. **Feature-first как основа структуры**  
   Весь прикладной код живёт внутри `lib/src/features/*`.
2. **Слои внутри каждой фичи**  
   `presentation -> application -> domain -> data` (зависимости только вниз).
3. **Infrastructure отдельно**  
   То, что не относится к конкретной фиче (router, дизайн-система, DI bootstrap, платформа), хранится в `lib/src/shared`.
4. **Один файл — одна причина для изменения**  
   Файл не должен одновременно быть UI, бизнес-логикой и persistence.
5. **Абстракция только при наличии второго сценария**  
   Интерфейс вводится, если есть минимум 2 реализации или реальная потребность в тестовой подмене.
6. **Публичный API фичи через barrel**  
   Внешний мир импортирует только `features/<name>/<name>.dart`, а не внутренние файлы.

---

## Целевая структура каталогов

```text
lib/src/
  app/
    app.dart
    bootstrap.dart            # запуск, сборка root providers
    router.dart

  shared/
    ui/                       # AppScaffold, общие виджеты, тема
    l10n/
    platform/                 # lifecycle, permissions, etc.
    di/                       # DI helpers (без feature-логики)
    utils/

  features/
    radio/
      radio.dart              # public API фичи
      presentation/
        pages/
        widgets/
        view_models/
      application/
        use_cases/
      domain/
        entities/
        repositories/
      data/
        repositories/
        sources/
        dto/

    player/
      player.dart
      presentation/
      application/
      domain/
      data/

    settings/
      settings.dart
      presentation/
      application/
      domain/
      data/

    about/
      about.dart
      presentation/
```

---

## Новая карта ответственности

### 1) `presentation`
- Экраны, виджеты, state-holder (ViewModel/Controller).
- Никакого доступа к `SharedPreferences`, `AudioPlayer`, raw DTO.
- ViewModel вызывает use-case из `application`.

### 2) `application`
- Оркестрация сценариев (`PlayStation`, `ChangeTheme`, `ResetSettings`).
- Содержит бизнес-правила уровня приложения.
- Не зависит от Flutter UI.

### 3) `domain`
- Сущности и интерфейсы репозиториев.
- Без зависимостей на внешние библиотеки/плагины.

### 4) `data`
- Реализации репозиториев, источники данных, DTO/mappers.
- Здесь допустимы `shared_preferences`, `just_audio`, и другие plugin APIs.

### 5) `shared`
- Переиспользуемое между фичами, но не бизнес-специфичное.
- Пример: локализация, app theme tokens, базовые UI-компоненты.

---

## Как решить текущие проблемы точечно

### Проблема 1: «data попадает в core, services в features»

Вводим **жёсткую матрицу размещения**:
- `features/*/domain`: только сущности + repo contracts;
- `features/*/data`: реализации repo + storage/network;
- `features/*/application`: use-cases;
- `features/*/presentation`: UI + state-holder;
- `shared/*`: только cross-feature код.

И добавляем правило ревью: **любой новый файл должен соответствовать матрице**.

### Проблема 2: перегруженные файлы

Ограничения:
- файл > 200 строк — кандидат на разделение;
- класс ViewModel > 7 публичных методов — разбить на use-cases;
- один виджет-файл = один экран/крупный блок, секции — в отдельные `widgets/sections`.

### Проблема 3: «бесконечные геттеры и провайдеры»

Упрощения:
- Один state-object на фичу вместо россыпи мелких геттеров.
- Провайдеры регистрируются **на уровне фичи** через `FeatureModule`.
- `app/bootstrap.dart` только подключает feature-модули.
- Не создавать «сервис-прокси», если он просто делегирует 1:1.

---

## DI-модель (без хаоса в провайдерах)

```dart
abstract interface class FeatureModule {
  List<SingleChildWidget> providers();
}
```

- У каждой фичи свой модуль: `radio_module.dart`, `player_module.dart`, `settings_module.dart`.
- Глобальный bootstrap собирает список модулей и flatten providers.
- Жизненный цикл (init/dispose) находится рядом с реализацией зависимости.

---

## План миграции (итеративно, без big-bang)

### Этап 0 — Подготовка (1 день)
1. Создать новые директории `features/*/{presentation,application,domain,data}` и `shared/*`.
2. Добавить `architecture-checklist.md` для PR (короткий список правил).

### Этап 1 — Settings вертикаль (1-2 дня)
1. Перенести `SettingsService` в `features/settings/application` и разложить на use-cases:
    - `LoadSettingsUseCase`
    - `UpdateThemeUseCase`
    - `UpdateLocaleUseCase`
    - `ResetSettingsUseCase`
2. `SharedPrefsSettingsRepository` перенести в `features/settings/data`.
3. UI настроек оставить в `presentation`, сменив зависимости на use-cases.

### Этап 2 — Player вертикаль (1-2 дня)
1. Вынести управление воспроизведением в `features/player/application`.
2. Адаптер `just_audio` — в `features/player/data/sources`.
3. ViewModel нижней панели — в `features/player/presentation`.

### Этап 3 — Radio вертикаль (1-2 дня)
1. `RadioStation` и контракты репозиториев — в `domain`.
2. `LocalRadioStationRepository` — в `data`.
3. `RadioStationFeedViewModel` оставить в `presentation`, но зависеть от use-case.

### Этап 4 — App bootstrap cleanup (1 день)
1. Заменить общий «комбайн» провайдеров на подключение feature-модулей.
2. Удалить дублирующиеся theme/service реализации.
3. `core` распилить: доменное перенести в фичи, общее — в `shared`.

---

## Definition of Done для архитектурной миграции

Считаем переход успешным, если:
- нет бизнес-кода в `app` и `shared`;
- нет импортов из `features/*/data` напрямую в UI;
- каждая фича имеет public API файл (`<feature>.dart`);
- количество root-level providers в bootstrap сократилось минимум на 40%;
- новые PR проходят checklist без исключений.

---

## Минимальные правила для команды

1. Перед добавлением абстракции ответить в PR: «Какие 2 сценария она покрывает?»
2. Новая фича создаётся только по шаблону слоёв.
3. Если файл перегружен — рефакторинг обязателен до merge.
4. Запрещены «временные» размещения файлов вне своей фичи.
5. Любая зависимость из UI в data-слой считается архитектурным дефектом.
