// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Token {
    mapping(address => uint256) public s_balances;

    function name() public pure returns (string memory) {
        return "Token";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address addr) public view returns (uint256) {
        return s_balances[addr];
    }

    function transfer(address addr, uint256 amount) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(addr);
        s_balances[msg.sender] -= amount;
        s_balances[addr] += amount;
        require(balanceOf(msg.sender) + balanceOf(addr) == previousBalances);
    }
}
