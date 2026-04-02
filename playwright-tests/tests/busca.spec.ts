import { test, expect } from '@playwright/test';

async function abrirBusca(page) {
  for (let i = 0; i < 3; i++) {
    await page.click('a[aria-label="Search button"]');

    const input = page.locator('#search-field');

    try {
      await input.waitFor({ state: 'visible', timeout: 2000 });
      return;
    } catch {}
  }

  throw new Error('Campo de busca não abriu');
}

test('Busca com termo válido', async ({ page }) => {
  await page.goto('https://blogdoagi.com.br/');

  await abrirBusca(page);

  const input = page.locator('#search-field');
  await input.fill('INSS');
  await input.press('Enter');

  await expect(page.locator('body')).toContainText('INSS');
});

test('Busca com termo inválido', async ({ page }) => {
  await page.goto('https://blogdoagi.com.br/');

  await abrirBusca(page);

  const input = page.locator('#search-field');
  await input.fill('asdasdasd123');
  await input.press('Enter');

  await expect(page.locator('body')).toContainText('nada foi encontrado');
});

test('Busca com caracteres especiais', async ({ page }) => {
  await page.goto('https://blogdoagi.com.br/');

  await abrirBusca(page);

  const input = page.locator('#search-field');
  await input.fill('!@#$%^&*()');
  await input.press('Enter');

  await expect(page.locator('body')).toContainText('nada foi encontrado');
});

test('Busca sem digitar termo', async ({ page }) => {
  await page.goto('https://blogdoagi.com.br/');

  await abrirBusca(page);

  const input = page.locator('#search-field');

  await input.press('Enter');

  await expect(page.locator('article').first()).toBeVisible();
});

test('Busca com digitando espaço vazio', async ({ page }) => {
  await page.goto('https://blogdoagi.com.br/');

  await abrirBusca(page);

  const input = page.locator('#search-field');
  await input.fill('  ');
  await input.press('Enter');

  await expect(page.locator('article').first()).toBeVisible();
});