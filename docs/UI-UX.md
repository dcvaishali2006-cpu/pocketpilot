# UI / UX

## Rules
- Mobile first. Bottom tab bar.
- Big numbers. Few words. Simple English.
- Colors: green = safe, orange = careful (over 80%), red = over limit.
- Dark mode supported.

## Screens
| Screen | Route | Content |
|---|---|---|
| Login | /login | Google button |
| Dashboard | /dashboard | Big "Safe today" number, progress bar, 4 cards (Budget, Fixed, Spent, Left), category chart, last 5 expenses |
| Add | /add | Amount keypad, category chips, note, "Scan screenshot" button |
| Expenses | /expenses | List grouped by date, filters |
| Fixed | /fixed | List of subscriptions, add button, next due date |
| Goals | /goals | Savings goals with progress |
| Groups | /groups | List of groups with "You owe / You get" |
| Group detail | /groups/[id] | Expenses, balances, Settle up button |
| Report | /report | Month totals, top category, comparison with last month |
| Settings | /settings | Pocket money, notifications on/off, install app, logout |

## Dashboard wireframe
```
+--------------------------+
| Safe to spend today      |
|        Rs 151            |
| [=====-----] 40% used    |
+--------------------------+
| Budget 5,000 | Fixed 447 |
| Spent 2,400  | Left 2,153|
+--------------------------+
| Category chart           |
+--------------------------+
| Recent expenses          |
+--------------------------+
| Home  Add  List  Groups  |
+--------------------------+
```

## Add flow
Amount first (keypad auto-open). Category chips (last used first). Save. Done in 3 taps.
