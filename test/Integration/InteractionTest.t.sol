// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import{Test, console} from "lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import{DeployFundMe} from "../../script/DeployFundMe.s.sol";
import{FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

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
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}