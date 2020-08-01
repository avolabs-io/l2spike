//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";
import "./VoterSideChain.sol";
import "./BridgeMainnet.sol";

contract BridgeSideChain {
    VoterSideChain public voteContract;
    BridgeMainnet public bridgeMainnet;

    function pushBalance(address user, uint256 amount) public {
        voteContract.setVoteBalance(user, amount);
    }

    function pushWinner(uint256 proposalId) public {
        _magicAcross(proposalId);
    }

    function _magicAcross(uint256 id) internal {
        bridgeMainnet.setWinner(id);
    }
}
