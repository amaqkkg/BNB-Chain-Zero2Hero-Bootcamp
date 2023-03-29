// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BadgerCoin.sol";

contract TestBadgerCoin is Test {
    BadgerCoin badgerCoin;

    function setUp() public {
        badgerCoin = new BadgerCoin();
    }

    function testMintShouldRevertWhenPause() public {
        badgerCoin.pause();
        vm.expectRevert();
        badgerCoin.mint(address(1), 100_000);
    }

    function testTransferShouldRevertWhenPause() public {
        badgerCoin.pause();
        vm.expectRevert();
        badgerCoin.transfer(address(1), 100);
    }

    function testTransferAfterUnPause() public {
        badgerCoin.pause();
        badgerCoin.unpause();
        badgerCoin.transfer(address(1), 1000);
        assertEq(
            badgerCoin.balanceOf(address(1)),
            1000,
            "balance is not equal to 1000"
        );
    }
}
