// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import{Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import{DeployFundMe} from "../../script/DeployFundMe.s.sol";
import{FundFundMe} from "../../script/Interactions.s.sol";

contract InterationsTest is Test {
    FundMe fundMe;

    address USER = makeAddr ("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALLANCE = 10 ether;
    uint256 constant GAS_PRICE = 1 ether;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal (USER, STARTING_BALLANCE);
    }

    function testUserCanFundInteractions() public{
        FundFundMe fundFundMe = new FundFundMe();
        vm.prank(USER);
        vm.deal(USER, SEND_VALUE);
        fundFundMe.fundFundMe(address(fundMe));

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }
}