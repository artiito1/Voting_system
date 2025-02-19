// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.4;

contract VoteDao{
    struct Poll{
        string title;
        uint expirationDate;
        string imageHash;
        string description;
        mapping (address=>bool) hashVoted;
        uint rejectVotes;
        uint acceptVotes;
        uint notInterestedVotes;
        bool exists;
    }

    mapping (uint=>Poll) private pollings;
    
    mapping (address=>uint[]) private userVotedPollings;


}