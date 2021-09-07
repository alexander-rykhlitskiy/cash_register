import { test, expect, chromium } from '@playwright/test';

test('basket', async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext();

  // Start tracing before creating / navigating a page.
  await context.tracing.start({ screenshots: true, snapshots: true });
  const page = await context.newPage();
  page.setDefaultTimeout(5000);

  await page.goto("http://localhost:3000");

  const addGreenTeaLinkSelector = 'table tr:has-text("Green Tea") :text("Add to basket")';

  for (let i = 0; i < 3; i++) {
    await page.click(addGreenTeaLinkSelector);
  }

  await expect(page.locator('text=Amount')).toHaveText(/.*6\.22€.*/);
  await context.tracing.stop({ path: "trace.zip" });
});
