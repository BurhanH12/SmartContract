//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract SolidityTest {



    enum FreshJuiceSize { SMAL , MEDIUM , LARGE , EXTRA_LARGE}

    FreshJuiceSize juice = FreshJuiceSize.MEDIUM;

    function getJuice() public view returns (FreshJuiceSize){
        return(juice);
        
    }

    function updateJuiceSize(FreshJuiceSize _juice) public {

        juice = _juice;
    }

    function verifyJuice() view public returns (bool) {

        return juice == FreshJuiceSize.EXTRA_LARGE;
        
    }

    // string public name = "Hello";

    // address[] users;
    // mapping (address => uint256) public userbalance;

    // function register() public {
    //     users.push(msg.sender);
    //     userbalance[msg.sender] = 1;
        
    // }

    // function TestArrays() public {
    //     uint[] memory a = new uint[](3);
    //     a[0] = 65;
    //     a[1] = 45;
    //     a[2] = 78;
    //     a[3] = 32;
    //     // for (uint256 i = 0; i < a.length; i++) {
    //     //     a[i] = 4*2;
    //     // }

    // }

    // // function updateName() public pure returns (string memory) {

    // //     string memory data1 = "Hello";
    // //     string memory data2 = "World";

    // //     string memory result = string (abi.encode(data1,data2));
        
    // //     return result; 
    // // }

}
