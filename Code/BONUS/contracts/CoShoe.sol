pragma solidity ^0.5.0;

//import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "./CO.sol";

contract COInterface {
	function balanceOf(address _owner) external view returns (uint256) {}
	function transferFrom(address spender, address recipient, uint256 amount) external returns (bool) {}
	function buyPrice(int nTokensPurchased) public view returns (uint8) {}
}

contract CoShoe is ERC721 {
	//state variable of price, shoes sold
	//uint price = 0.5 ether; price does not need to be defined
	uint shoesSold = 0;
	uint totalSupply = 100;

	//each shoe is a struct with owner, name, image and if sold
	struct Shoe {
		address owner;
		string name;
		string image;
		bool sold;
	}

	//public array shoes that holds instances of Shoe
	Shoe[] public shoes;

	// define the mapping of owner to shoes owned
     mapping (address => uint[]) public ownedShoes;

	//constructor 
	constructor() public {
		name = "";
		image = "";
		sold = false;
		owner = "";
		Shoe memory newShoe = Shoe(name, owner, image, sold);
		shoes.push(newShoe);
  	}
 
  function buyShoe(string name1, string image1) public {
		require (shoesSold <101 , 'All shoes have been sold. Cannot execute sale.'); //101 as the supply has been set at 100
		//require(price == msg.value, 'Error: Price has not been paid');
		uint ownerBal = balanceOf(msg.sender);
		require(ownerBal > 0, 'Owner does not own a Co Token'); //check if owner has a CoToken
		transferFrom(msg.sender, shoes[currentShoe].owner, ownerBal);


		uint currentShoe =  shoesSold;  //know that the first shoe is stored in index 0, therefore the next shoe is the one we see
		shoes[currentShoe].owner = msg.sender;
		shoes[currentShoe].name = name1;
		shoes[currentShoe].image = image1;
		shoes[currentShoe].sold = true;
		shoesSold++; 
  }

//returns an array of bools that are set to true if the equivalent index in shoes belongs to caller of this function
  //function checkPurchases() public returns(bool[]){
// }

  function owner() public view returns (address) {
    return owner;
  }

  function name() public view returns (string memory) {
    return name;
  }

  function image() public view returns (string memory) {
    return image;
  }

  function sold() public view returns (bool) {
    return sold;
  }

  function numTokens() external view returns(uint) {
    // return the # minted tokens
    return totalSupply;
  }

  function getShoesSold() external view returns(uint) {
    // return the # minted tokens
    return shoeSold;
  }
}
