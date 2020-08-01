//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";

contract TreasuryMainnet {
    mapping(address => uint256) public deposits;
    uint256 public winner;

    function addDeposit(uint256 amount) public {
        deposits[msg.sender] = deposits[msg.sender] + amount;
    }

    function distributeFunds(uint256 _winner) public {
        // send money to winner
        winner = _winner;
        console.log("The winner is now:", winner);
    }
}
