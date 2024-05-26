// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeeToken is ERC20, ERC20Burnable, Ownable {
    mapping(address => uint) public claimMap;

    modifier claimCheck(address to) {
        require(claimMap[to] <= 0, "already claimed");
        _;
    }

    constructor(address initialOwner) ERC20("BeeToken", "BT") Ownable(initialOwner) {
        _mint(msg.sender, 50000 * 10 ** decimals());
    }

    function claim(address to) public claimCheck(to) {
        claimMap[msg.sender] = 1;
        _mint(to, 50);
    }


    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
