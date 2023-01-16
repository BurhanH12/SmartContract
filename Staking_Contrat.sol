// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.1/token/ERC20/ERC20.sol";

contract BURHAN is ERC20 {
    constructor() ERC20("BURHAN", "BUR") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}

contract stakecontract is BURHAN{

    mapping(address => uint256) public amountstaked;
    uint256 stakestart = 0;
    uint256 stakestop = 0; 
    IERC20 token;
    constructor (IERC20 _token){
        token = _token;
    }

    function stake(uint256 tokenstostake) public {  //stake function that takes a uint
        require(token.balanceOf(msg.sender) > tokenstostake, "Not enough tokens"); //check if the user has enough tokens than what he's trying to stake
        require(tokenstostake > 0, "cannot stake 0 tokens"); //Check if the user is not staking 0 tokens
        token.transferFrom(msg.sender,address(this), tokenstostake); //transfer the tokens from the user to contract
        stakestart = block.timestamp;   //to take the time the user stakes his tokens
        amountstaked[msg.sender] = tokenstostake;
    }

    function unstake(uint256 tokenstounstake) public{
        require(tokenstounstake > amountstaked[(msg.sender)]); //user cannot unstake more than what's at stake
        token.transfer(msg.sender,tokenstounstake + reward); //transfer the tokens + reward to the user
        
    
    }

     uint256 public reward;
    uint256 public stakedTokens;

       function calculateReward(address staker) public returns (uint256) {  //to calulate the reward for staking

        stakedTokens = amountstaked[staker];   //to save the amount staked in a variable
        reward = stakedTokens / 1000; //take 0.01% of the total amount staked
        uint256 difftime =  block.timestamp - stakestart; //calculate the time the tokens were at stake
        reward *= difftime;  //Multiply the reward by the time at stake
        return reward;
    }


}
