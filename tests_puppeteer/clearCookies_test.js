
Feature('Debug #954');

Scenario('Clear Cookies', async (I) => {
  await I.amOnPage('/');
  await I.wait(2);
});
