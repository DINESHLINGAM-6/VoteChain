// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VotingSystem {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint256 votedCandidateId;
    }

    address public admin;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;
    uint256 public candidatesCount;
    bool public votingOpen;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    modifier votingIsOpen() {
        require(votingOpen, "Voting is not open.");
        _;
    }

    constructor() {
        admin = msg.sender;
        votingOpen = true;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function registerVoter(address _voterAddress) public onlyAdmin {
        require(!voters[_voterAddress].isRegistered, "Voter is already registered.");
        voters[_voterAddress] = Voter(true, false, 0);
    }

    function vote(uint256 _candidateId) public votingIsOpen {
        require(voters[msg.sender].isRegistered, "Voter is not registered.");
        require(!voters[msg.sender].hasVoted, "Voter has already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedCandidateId = _candidateId;
        candidates[_candidateId].voteCount++;
    }

    function endVoting() public onlyAdmin {
        votingOpen = false;
    }

    function getWinner() public view returns (string memory) {
        require(!votingOpen, "Voting is still open.");
        uint256 winningVoteCount = 0;
        uint256 winningCandidateId = 0;

        for (uint256 i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }

        return candidates[winningCandidateId].name;
    }
}