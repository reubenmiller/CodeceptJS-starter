
Feature('Test Example');

Scenario('Test scenario for Internet Explorer @ie', async (I) => {
  await I.amOnPage('/');
  await I.wait(2);
});

Scenario('Test scenario for chrome @chrome', async (I) => {
  await I.amOnPage('/');
  await I.wait(2);
});
