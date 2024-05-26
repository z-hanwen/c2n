// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract TokenSales is Ownable {
    using Math for uint;
    uint private startTime;
    uint private endTime;
    uint public saleAmount;
    IERC20 private saleToken;
    mapping(address => uint) private approveMap;
    address[] private approvedAccountArray;

    event sale(address indexed from, address indexed to, uint256 value);

    constructor(address initialOwner, IERC20 token, uint starTimeStamp, uint endTimeStamp) Ownable(initialOwner) {
        require(starTimeStamp < endTimeStamp, "time setup error");
        require(starTimeStamp > block.timestamp, "starTimeStamp setup error");
        require(endTimeStamp - 1 days > starTimeStamp, "startTime and endTime at least one day apart");

        startTime = starTimeStamp;
        endTime = endTimeStamp;
        saleToken = token;
    }

    function sale(address userAccount, uint amount) public {
        require(block.timestamp > startTime && block.timestamp < endTime, "Not during sales time");

        uint balance = saleToken.balanceOf(msg.sender);
        require(balance >= amount, "insufficient remaining funds");

        saleToken.approve(userAccount, amount);
        approveMap[userAccount] = amount;

        emit sale(msg.sender, userAccount, amount);
    }

    function distribute() public {


    }


}