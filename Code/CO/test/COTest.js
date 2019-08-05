const CO = artifacts.require("CO");

contract('CO', (accounts) => {

  const _name = "CO";
  const _symbol = "CO";
  const _totSupply = 100;


  //before we conduct the other tests
  beforeEach(async function() {
    token = await CO.new(_totSupply, _name, _symbol);
  });

  //tests on burn, mint and destroy

//mint test
it('should mint the prescribed 100 tokens', async function () {
  let token = await CO.deployed()
  
  // mint 100 co coins 
  await token.mint(accounts[0], 20, 100, { 'from': accounts[0] })
  
  //view new balance
  let bal = await token.balanceOf(accounts[0])
  let totSupply = await token.totalSupply()
  
  //check balance
  assert.equal(bal.toNumber(), 100, "Account did not contain 100.")
  assert.equal(totSupply.toNumber(), 100, "Total supply did not equal 100.")
});


//burn test
it('should burn required tokens', async function () {
  let token = await CO.deployed()
  
  // burn 50 coins
  await token.burn(accounts[0], 50, { 'from': accounts[0] })
  
  //view new balance
  let bal = await token.balanceOf(accounts[0])
  let totSupply = await token.totalSupply()
  
  //check balance
  assert.equal(bal.toNumber(), 50, "Account did not contain 50.")
  assert.equal(totSupply.toNumber(), 50, "Total supply did not equal 50.")
});

  
});
