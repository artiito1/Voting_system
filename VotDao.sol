// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.4;
import "@openzeppelin/contracts/utils/Counters.sol";

contract VoteDao{

    using Counters for Counters.Counter;
    
    Counters.Counter public pollingIdCounter;
    
    address public admin;
    constructor(){
        admin = msg.sender;
    }

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

    // EVETNS
    event pollingCreated(uint indexed pollingId, string title, uint expirationDate, uint createdAt);

    //Modifier 
    modifier onlyAdmin(){
        require(msg.sender == admin,"Only Admin Can create This Operations");
        _;
    }
    modifier pollingExist(uint pollingId){
        require(pollings[pollingId].exists,"Polling dose not exist");
        _;
    }

    //Create Vote
    function createPoll(string memory _title, uint _durationInSecond, string memory _imageHash, string memory _description) public onlyAdmin{
        
        //ownerships modifire

        //validation of inputs
        require(_durationInSecond>0,"Duration must ve greather Than 0");
        require(bytes(_title).length>3,"_title must ve greather Than 3");
        require(bytes(_imageHash).length>3,"_imageHash must ve greather Than 3");
        require(bytes(_description).length>3,"_description must ve greather Than 3");
        

        pollingIdCounter.increment(); // 0 => 1 

        uint newPollingId = pollingIdCounter.current();

        pollings[newPollingId].title=_title;
        pollings[newPollingId].description=_description;
        pollings[newPollingId].expirationDate=block.timestamp +_durationInSecond;
        pollings[newPollingId].imageHash=_imageHash;
        pollings[newPollingId].rejectVotes=0;
        pollings[newPollingId].acceptVotes=0;
        pollings[newPollingId].notInterestedVotes=0;
        pollings[newPollingId].exists=true;

        //event
        emit pollingCreated(newPollingId, _title, block.timestamp+_durationInSecond, block.timestamp);
    }

    function getPollDetailes(uint _id)public view pollingExist(_id) returns(
        string memory title,
        uint expirationDate,
        string memory imageHash,
        string memory description,
        uint rejectVotes,
        uint acceptVotes,
        uint notInterestedVotes){
            Poll storage selectItem = pollings[_id];
            return (
            selectItem.title,
            selectItem.expirationDate,
            selectItem.imageHash,
            selectItem.description,
            selectItem.rejectVotes,
            selectItem.acceptVotes,
            selectItem.notInterestedVotes
            );
        }
    //get all vote by status 
    //get all votes already voted 
}