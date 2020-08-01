//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";
import "./TreasuryMainnet.sol";
import "./BridgeSideChain.sol";

contract BridgeMainnet {
    TreasuryMainnet public treasuryContract;
    BridgeSideChain public bridgeContract;

    // Call contract on side-chain to set this value
    function _magicBridge(address user, uint256 amount) internal {
        bridgeContract.pushBalance(user, amount);
    }

    function pushVoteValue(address user) public {
        uint256 depositAmount = treasuryContract.deposits(user);
        _magicBridge(user, depositAmount);
    }

    function setWinner(uint256 winner) public {
        treasuryContract.distributeFunds(winner);
    }
}
