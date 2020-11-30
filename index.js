const chromium = require('chrome-aws-lambda');
const AWS = require('aws-sdk');

const ezlmURL = 'https://ezlmappdc1f.adp.com/ezLaborManagerNet/Login/Login.aspx';
const client = 'ADPCANADAES';
const user = '';
const pass = '';

// get reference to S3 client
const s3 = new AWS.S3();

exports.handler = async event => {
  const browser = await chromium.puppeteer.launch({
    args: chromium.args,
    defaultViewport: chromium.defaultViewport,
    executablePath: await chromium.executablePath,
    headless: chromium.headless,
    ignoreHTTPSErrors: true,
  });
  let page = await browser.newPage();

  await page.goto(ezlmURL);
  await page.waitForSelector('#txtClientName');

  // enter client name
  await page.type('#txtClientName', client);
  await page.click('#btnSubmit')

  // enter username and password and login
  await page.waitForSelector('#txtPassword');
  await page.type('#txtUserID', user);
  await page.type('#txtPassword', pass);
  await page.click('#btnLogin_active');
  await page.waitForNavigation({ waitUntil: 'networkidle0' });

  // click clock in button
  const clockButton = await page.$('#UI4_ctBody_UCTodaysActivities_btnClockIn');
  await clockButton.hover();
  await clockButton.click();
  //await page.click('#UI4_ctBody_UCTodaysActivities_btnClockIn');

  // take a screenshot
  const buffer = await page.screenshot()

  // upload the image using the current timestamp as filename
  const result = await s3
    .putObject({
      Bucket: 'toms-stuff',
      Key: `${Date.now()}.png`,
      Body: buffer,
      ContentType: "image/png"
    })
    .promise();

  return "Success";
};
