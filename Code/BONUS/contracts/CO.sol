pragma solidity ^0.5.0;

import npm init'openzeppelin-solidity/contracts/token/ERC20/IERC20.sol';
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract CO is IERC20, Ownable {

	//declaration of variables
    string _name;
  	string _symbol;
	uint256 _totSupply;

	//Mapping of balances: adresses to their corresponding balance
	mapping(address => uint256) balances;

	//constructor
	constructor(string memory name, string memory symbol, uint8 decimals, uint256 totSupply) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
		_totSupply = totSupply;

        _balances[msg.sender] = _totSupply;
    }

	//minting new coins
	function mint(address recipient, uint256 price, uint8 numTokens) public onlyOwner {
		uint totalTransactionP = price * numTokens;
		uint correctP = buyPrice(numTokens);
		require(totalTransactionP == correctP, "Price does not align with curve.");

		_totSupply = _totSupply + totalTransactionP ;
		_balances[recipient] = _balances[recipient] + totalTransactionP;
		emit Transfer(address(0), recipient, totalTransactionP);
	}

	//burn coins
	function burn(address account, uint256 amount) public onlyOwner {
		require(account != address(0), "Choose another adress. Zero account.");
		require (_balances[account] => amount, "Burn amount exceeds balance of account.");
        _totalSupply = _totalSupply - amount;
        emit Transfer(account, address(0), amount);
	}

	//curve is f(x) = 0.01x + 0.2 , x ∈ ℕ
	function buyPrice(int nTokensPurchased) public view returns (uint8) {
		int pricePerToken = 0.01 * _totalSupply + 0.2;
		int totalBuyPrice = pricePerToken * nTokensPurchased;
		return totalBuyPrice;
	}

	function sellPrice(int nTokensSold) public view returns (uint8) {
		int pricePerToken = 0.01 * _totalSupply + 0.2;
		int totalSellPrice = pricePerToken * nTokensPurchased;
		return totalSellPrice;
	}

	// # of tokens 
   function totalSupply() external view returns (uint256) {
       return _totSupply;
   }

	//acc balance of account with address _sender
   function balanceOf(address _owner) external view returns (uint256){
       return _balances[_owner];
   }

   // amount of tokens that owner can send to a recipient.
   function allowance(address owner, address spender) external view returns (uint256){
      return _allowed[owner][spender];
   }

   function transfer(address recipient, uint256 amount) external returns (bool){
		require(amount <= _balances[msg.sender], "Insufficient funds");
		require(recipient != address(0), "Cannot shoose address");

        emit Transfer(msg.sender, recipient, amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        return true;
  }

  function approve(address spender, uint256 amount) external returns (bool){
      _allowed[msg.spender][spender] = amount;
      emit Approval(msg.spender, spender, amount);
      return true;
    }


	function transferFrom(address spender, address recipient, uint256 amount) external returns (bool){
		require(amount <= _balances[spender], "Spend amount must not exceed balance of account");
		require(amount <= _allowed[spender][msg.spender], "Spend amount cannot exceed allocated spend limit");
		require(spender != address(0), "Address zero cannot be used");

		_balances[spender] = _balances[spender].sub(amount);
		_balances[recipient] = _balances[recipient].add(amount);
		
		//remove what is spent
		_allowed[spender][msg.spender] = _allowed[spender][msg.spender] - amount; 
		emit Transfer(spender, recipient, amount);
		return true;
   }

   //self destruct
    function kill() onlyOwner {  
		address owner = msg.sender;
		if(msg.sender == owner) {
		selfdestruct(owner); 
	}

}
