import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:3001/');
  await page.getByRole('link', { name: 'New cat' }).click();
  await page.getByLabel('Name').click();
  await page.getByLabel('Name').fill('Floquinho');
  await page.getByLabel('Name').press('Tab');
  await page.getByLabel('Breed').fill('Brazilian short hair');
  await page.getByLabel('Favorite quote').click();
  await page.getByLabel('Favorite quote').fill('Miau!!');
  await page.getByRole('button', { name: 'Save Cat' }).click();
  await page.getByRole('link', { name: 'Back to cats' }).click();
});