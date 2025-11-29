---
title: "Пример REST API документации"
weight: 40
---

# Пример документации REST API

*Это пример технической документации для REST API интернет-магазина. Документ демонстрирует навыки написания API документации с использованием стандартов OpenAPI.*

## Обзор

Этот API предоставляет программный интерфейс для управления интернет-магазином, включая управление товарами, заказами и пользователями.

## Базовая информация

- **Базовый URL**: `https://api.store.example.com/v1`
- **Формат данных**: JSON
- **Аутентификация**: Bearer Token (OAuth 2.0)

## Аутентификация

Для доступа к API необходимо получить токен доступа через OAuth 2.0 flow.

```bash
POST /oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=password&username=user&password=pass&client_id=your_client_id
```

## Эндпоинты

### Товары

#### Получить список товаров

```http
GET /products
```

**Параметры запроса:**
- `category` (опционально): ID категории
- `limit` (опционально): Количество элементов (по умолчанию 20)
- `offset` (опционально): Смещение (по умолчанию 0)

**Пример ответа:**

```json
{
  "data": [
    {
      "id": 1,
      "name": "Ноутбук Lenovo ThinkPad",
      "price": 89999,
      "category": "electronics",
      "in_stock": true
    }
  ],
  "pagination": {
    "total": 150,
    "limit": 20,
    "offset": 0
  }
}
```

#### Создать товар

```http
POST /products
Authorization: Bearer {token}
Content-Type: application/json
```

**Тело запроса:**

```json
{
  "name": "Новый товар",
  "price": 1000,
  "category": "electronics",
  "description": "Описание товара"
}
```

## Статусы ответов

| Код | Описание |
|-----|----------|
| 200 | Успешный запрос |
| 201 | Ресурс создан |
| 400 | Ошибка в запросе |
| 401 | Не авторизован |
| 403 | Доступ запрещен |
| 404 | Ресурс не найден |
| 500 | Внутренняя ошибка сервера |

## Ошибки

Все ошибки возвращаются в следующем формате:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Неверные данные",
    "details": {
      "field": "price",
      "reason": "must be positive"
    }
  }
}
```
