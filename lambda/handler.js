const puppeteer = require('puppeteer-core');
const he = require('he');

exports.handler =  async function(event, context) {
  const html = he.decode(event['html']);
  const browser = await puppeteer.connect({ browserWSEndpoint: `wss://chrome.browserless.io?token=${process.env.BROWSER_TOKEN}` });
  const page = await browser.newPage();

  await page.setContent(html);
  const base64 = await page.screenshot({ encoding: "base64", fullPage: true })

  await browser.close();

  return { base64 }
}
