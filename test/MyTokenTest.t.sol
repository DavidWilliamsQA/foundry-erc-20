// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public mt;
    DeployMyToken public deployer;

    address fred = makeAddr("fred");
    address barney = makeAddr("barney");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployMyToken();
        mt = deployer.run();

        vm.prank(msg.sender);
        mt.transfer(fred, STARTING_BALANCE);
    }

    function testFredBalance() public view {
        assertEq(mt.balanceOf(fred), STARTING_BALANCE);
    }

    function testAllowancesWork() public {
        uint256 initialAllowance = 1000;

        vm.prank(fred);
        mt.approve(barney, initialAllowance);

        uint256 TRANSFER_AMOUNT = 500;

        vm.prank(barney);
        mt.transferFrom(fred, barney, TRANSFER_AMOUNT);

        assertEq(mt.balanceOf(barney), TRANSFER_AMOUNT);
        assertEq(mt.balanceOf(fred), STARTING_BALANCE - 500);
    }
}
