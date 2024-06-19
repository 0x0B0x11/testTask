# Тестовое задание helm chart

## Описание

Разворачивание образа nginxdemos/hello через helm chart


## Использование
```
git clone https://github.com/0x0B0x11/testask/  
cd testask  
helm package .  # пакетирование  
helm install testask-0.1.0.tgz --generate-name # установка пакета через helm в k8s  
```
# Тестовое задание чек-лист деплоя на прод

- Утверждена стратегия выкатки на прод  
- Пулл реквест с релизом в мастер должен быть открыт, прием изменений остановлен, ветка заморожена  
- Автотесты должны быть пройдены   
- Выкатка на деве прошла успешно и qa провели проверку  
- Все заинтересованные лица оповещены, дата и время деплоя утверждены  
- План быстрого отката изменений подготовлен
- Бекап данных пользователей актуален


