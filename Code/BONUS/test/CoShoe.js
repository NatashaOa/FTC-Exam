// import the  artifacts from contract

const CoShoe = artifacts.require('CoShoe');

contract('CoShoe', (accounts) => {

// predefined parameters
  const name = 'Best Shoe 1.1'
  const image = 'imagePlace1.com'
  
  it('should mint 100 tokens', async () => {
    // fetch instance of CoShoe contract
    let CoShoeInstance = await CoShoe.deployed()
    // get the # of tokens
    let tokenCounter = await CoShoeInstance.numTokens()
    // check there are 100 tokens
    assert.equal(tokenCounter, 100, 'initial number not equal to zero')
  });

  it('should transfer ownership and update shoesSold', async () => {
    // fetch instance of CoShoe contract
    let CoShoeInstance = await CoShoe.deployed()
    // register a song from account 0
    await CoShoeInstance.buyShoe(name,image)
    //get name
    let totShoesSold = await CoShoeInstance.getShoesSold()
    //check name changed
    assert.equal(shoe['name'], name, 'Name not changed')
    //check image changed
    assert.equal(shoe['image'], image, 'Image not changed')
    //check shoes solde increased
    assert.equal(totShoesSold, 1, 'Shoes sold not incremented')

  });
  
});
