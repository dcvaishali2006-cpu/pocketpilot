# API and Server Actions

All actions need a logged-in user (except cron). Validate with zod. Return `{ ok: true, data }` or `{ ok: false, error }`.

## Server actions (`app/actions/`)
| Action | Input | Does |
|---|---|---|
| setMonthlyBudget | month, pocketMoney | Upsert monthly_budgets |
| addFixedExpense | name, amount, dueDay | Insert |
| updateFixedExpense | id, fields | Update |
| deleteFixedExpense | id | Delete |
| addExpense | amount, categoryId, note, receiver, spentOn, source | Insert, compute summary, send push |
| updateExpense / deleteExpense | id | Edit or remove |
| getDashboard | month | Returns summary from lib/budget |
| createGroup | name, members[] | Insert group and members |
| addGroupExpense | groupId, paidBy, amount, title, splitType, splits[] | Insert, create personal share |
| settleUp | groupId, from, to, amount | Insert settlement |
| saveSubscription | endpoint, keys | Upsert push_subscriptions |

## Route handlers
| Route | Method | Purpose |
|---|---|---|
| /share-target | POST | Handled by service worker (receives shared image) |
| /api/push/subscribe | POST | Save push subscription |
| /api/push/test | POST | Send test notification to self |
| /api/cron/daily | POST | Daily summary, warnings, reminders. Needs `Bearer CRON_SECRET` |

## Push payload
```json
{ "title": "Rs 80 - Food", "body": "Spent Rs 2,400. Left Rs 2,153. Safe today: Rs 151.", "url": "/dashboard" }
```
