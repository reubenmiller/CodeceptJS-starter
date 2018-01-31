
const chai = require('chai');
const expect = chai.expect;

Feature('REST Test Example');

Scenario('test chai external url @rest', async(I) => {
  const res =  await I.sendGetRequest('http://google.com');
  expect(res).to.have.property('body');
  expect(res.body).to.contain('google');
});

Scenario('rest test chai should pass', async(I) => {
  expect({foo: 'bar'}).to.have.property('foo');
});

Scenario('rest test chai should fail', async(I) => {
    expect({foo: 'bar'}).to.have.property('foofoo');
});
