// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FitnessToken is ERC20, Ownable {
    // Enum to represent different fitness rewards
    enum FitnessReward { GEAR, EQUIPMENT, PLAN, DISCOUNT }

    // Mapping to store the prices of fitness rewards
    mapping(FitnessReward => uint256) public rewardPrices;

    // Constructor to initialize the token contract
    constructor(address _owner) ERC20("FitnessToken", "FIT") Ownable(_owner) {
        // Mint initial tokens to the contract owner
        _mint(msg.sender, 10000 * 10 ** decimals());
        
        // Set prices for each fitness reward
        rewardPrices[FitnessReward.GEAR] = 25;
        rewardPrices[FitnessReward.EQUIPMENT] = 50;
        rewardPrices[FitnessReward.PLAN] = 75;
        rewardPrices[FitnessReward.DISCOUNT] = 100;
    }

    // Function to mint new tokens (onlyOwner)
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    // Function to redeem fitness rewards
    function redeemReward(FitnessReward _reward) external {
        // Get the price of the selected reward
        uint256 rewardPrice = rewardPrices[_reward];
        // Ensure the caller has enough tokens to redeem the reward
        require(balanceOf(msg.sender) >= rewardPrice, "Insufficient funds");
        // Burn tokens to redeem the reward
        _burn(msg.sender, rewardPrice);
    }

    // Function to check token balance of a player
    function checkTokenBalance(address _player) external view returns (uint256) {
        return balanceOf(_player);
    }

    // Function to burn tokens
    function burnTokens(uint256 _amount) external {
        // Ensure the caller has enough tokens to burn
        require(balanceOf(msg.sender) >= _amount, "Insufficient funds");
        // Burn the specified amount of tokens
        _burn(msg.sender, _amount);
    }
}
