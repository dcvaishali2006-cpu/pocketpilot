# Testing

## Automatic (Vitest)
| File | Must test |
|---|---|
| lib/budget.ts | free budget, daily limit, last day of month, spent over budget, zero days left |
| lib/split.ts | equal split with rounding, exact must sum to total, percent must sum to 100, simplify debts |
| lib/ocr/parse.ts | 10 fixtures, wrong rupee symbol, failed payment |

Run: `npm run test`

## Manual checklist
- [ ] Login and logout
- [ ] Set pocket money, see dashboard change
- [ ] Add fixed expense, free budget reduces
- [ ] Add expense, notification arrives
- [ ] Delete expense, numbers go back
- [ ] Share screenshot from GPay (Android, installed PWA)
- [ ] OCR fills amount correctly
- [ ] Group: 4 people, 3 expenses, balances match the example in PRD
- [ ] Settle up clears the balance
- [ ] Own share appears in personal expenses, friends' share does not
- [ ] A second user cannot see the first user's data (RLS)
- [ ] Works offline for viewing (nice to have)

## Goa example for split tests
Total paid: Rohan 4000, You 1200, Amit 800. 4 people equal. Each share 1500.
Expected net: Rohan +2500, You -300, Amit -700, Sneha -1500.
