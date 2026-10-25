# Free Screenshot Reader

## Choice
**Tesseract.js** runs in the browser. Free, no API key, no limits, private.

Optional fallback later: Google Gemini free tier (needs API key, has rate limits, sends image to Google). Not used in v1.

## How it works
1. Get image (shared or uploaded).
2. Pre-process: scale to ~1200px wide, grayscale, increase contrast (canvas).
3. `Tesseract.recognize(image, 'eng')` returns text.
4. `parseUpiText(text)` returns `{ amount, receiver, date, app, confidence }`.
5. Form is pre-filled. User confirms.

## Parser rules (`lib/ocr/parse.ts`)
- **Amount:** find patterns like `₹ 80`, `Rs. 80`, `₹1,250.50`. OCR often reads ₹ as `2`, `%`, `T`, `?`. So also try: the largest number on a line near words "Paid", "Sent", "Amount", or a line with only a number.
- **Receiver:** line after `Paid to`, `To`, `Sent to`, `Paid successfully to`. Trim UPI id.
- **Date:** formats `12 Nov 2026`, `12/11/2026`, `Nov 12, 2026`. If none, use today.
- **App:** detect keywords: `Google Pay`/`G Pay`, `PhonePe`, `Paytm`, `BHIM`.
- **Status:** if text has `Failed` or `Pending`, warn user. Do not auto-save.
- **Confidence:** high if amount + (receiver or app) found. Low otherwise. Low means user must check amount.

## Category guess (simple rules)
| Receiver contains | Category |
|---|---|
| canteen, cafe, hotel, restaurant, zomato, swiggy, bakery | Food |
| uber, ola, rapido, metro, irctc, redbus | Travel |
| jio, airtel, vi, recharge | Recharge |
| spotify, netflix, hotstar, youtube | Fun |
| anything else | Other (user picks) |

## Tests (required)
Save 10 sample text outputs in `lib/ocr/__fixtures__/` and test the parser with Vitest. Include a case where Rs symbol is read wrongly.

## Code sketch
```ts
import { createWorker } from 'tesseract.js';
export async function readScreenshot(file: Blob) {
  const worker = await createWorker('eng');
  const { data } = await worker.recognize(file);
  await worker.terminate();
  return parseUpiText(data.text);
}
```
Tip: Tesseract downloads language data on first use (about 10 MB). The service worker should cache it.
