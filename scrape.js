
                                 // This script uses Puppeteer to scrape a website and save the title, description, and headings into a JSON file

const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL || 'https://quotes.toscrape.com';

(async () => {
                                                         // Launch headless Chromium browser with safe flags
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    executablePath: '/usr/bin/chromium',       
  });

  const page = await browser.newPage();
  console.log(`Navigating to ${url}...`);
  await page.goto(url, { waitUntil: 'domcontentloaded' });

                                                        // Extract data from the webpage
  const data = await page.evaluate(() => {
    const title = document.querySelector('title')?.innerText || 'No title found';
    const description = document.querySelector('meta[name="description"]')?.content || 'No description';
    const headings = Array.from(document.querySelectorAll('h1, h2')).map(h => h.innerText.trim());
    return { title, description, headings };
  });

                                                      // Data to a JSON file
  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  console.log('✅ Scraping complete. Data saved to scraped_data.json');

  await browser.close();
})();
