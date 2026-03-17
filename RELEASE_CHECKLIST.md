# 🚀 Release Checklist

## 🔢 Versioning
- [ ] Обновлён version в pubspec.yaml
- [ ] versionCode увеличен
- [ ] versionName корректен

## 📝 Changelog
- [ ] Обновлён CHANGELOG.md
- [ ] Добавлены изменения
- [ ] Указана дата

## 🧪 Smoke Tests
- [ ] Приложение запускается
- [ ] Нет crash при старте
- [ ] Работает основной функционал
- [ ] Навигация работает

## 🎵 Player (project-specific)
- [ ] Радио запускается
- [ ] Переключение работает
- [ ] Фоновый режим работает
- [ ] Пауза/стоп работают

## 🔐 Signing
- [ ] Keystore сохранён
- [ ] key.properties не в репозитории

## 📦 Build
- [ ] flutter clean выполнен
- [ ] AAB собран

## ☁️ Release
- [ ] Создан Git tag
- [ ] Загружен AAB в Google Play
- [ ] Заполнено описание релиза

## 🔄 Rollback plan
- [ ] Есть предыдущий стабильный билд
- [ ] Понятно как откатиться