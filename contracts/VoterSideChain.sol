//SPDX-License-Identifier: Unlicense
pragma solidity ^0.6.8;

import "@nomiclabs/buidler/console.sol";
import "./BridgeSideChain.sol";

contract VoterSideChain {
    mapping(uint256 => uint256) public proposalIdToVotes;
    mapping(address => bool) public hasVoted;
    mapping(address => uint256) public voteBalance;

    uint256 topVotes;
    uint256 topProposalId;
    uint256 votingThreshold;

    BridgeSideChain public bridgeContract;
    modifier hasBalance() {
        require(
            voteBalance[msg.sender] != 0,
            "Vote Balance not recieved from mainnet"
        );
        _;
    }

    modifier votingNotFinished() {
        require(votingThreshold < 6, "Voting not yet finished ");
        _;
    }

    modifier votingIsFinished() {
        require(votingThreshold > 5, "Voting finished ");
        _;
    }

    // TODO: Only bridge can call this
    function setVoteBalance(address user, uint256 amount) public {
        voteBalance[user] = amount;
    }

    function vote(uint256 proposal) public hasBalance votingNotFinished {
        proposalIdToVotes[proposal] =
            proposalIdToVotes[proposal] +
            voteBalance[msg.sender];
        hasVoted[msg.sender] = true;

        if (proposalIdToVotes[proposal] > topVotes) {
            topVotes = proposalIdToVotes[proposal];
            topProposalId = proposal;
        }

        votingThreshold = votingThreshold + 1;
    }

    function winnnerWinnerChickenDinner() public votingIsFinished {
        bridgeContract.pushWinner(topProposalId);
    }

    // TODO:
    // Function to get balance from mainchain for user...
}
