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
//vote struct
    struct Vote{
        address voter;
        string choice;
        uint time;
    }
/////////////////////////////
//poll struct
    struct Poll{
        string title;
        uint expirationDate;
        string imageHash;
        string description;
        mapping (address=>bool) hasVoted;
        uint rejectVotes;
        uint acceptVotes;
        uint notInterestedVotes;
        bool exists;
        Vote [] votes;
    }

    mapping (uint=>Poll) private pollings;

    mapping (address=>uint[]) private userVotedPollings;


/////////////////////////////
// EVETNS
    event pollingCreated(uint indexed pollingId, string title, uint expirationDate, uint createdAt);
    event Voted(uint indexed pollingId, address indexed voter, string choice, uint createdAt);

/////////////////////////////
//Modifier
    modifier onlyAdmin(){
        require(msg.sender == admin,"Only Admin Can create This Operations");
        _;
    }
    modifier pollingExist(uint pollingId){
        require(pollings[pollingId].exists,"Polling dose not exist");
        _;
    }
    modifier notExpired(uint pollingId){
        require(block.timestamp < pollings[pollingId].expirationDate,"Polling has Ended");
        _;
    }
    modifier hasNotVoted(uint pollingId){
        require(!pollings[pollingId].hasVoted[msg.sender],"You have Already Voted");
        _;
    }
/////////////////////////////
//functions

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

    // Do vote
    function vote(uint pollingId, string memory _choice) public pollingExist(pollingId) notExpired(pollingId) hasNotVoted(pollingId) {
        //pollings[pollingId]
        require(keccak256(abi.encodePacked(_choice)) == keccak256("Yes")||
        keccak256(abi.encodePacked(_choice)) == keccak256("No") ||
        keccak256(abi.encodePacked(_choice)) == keccak256("NoInterested")
        ,"Invaild Voting Choice");

        //Update Counter for choice
        if(keccak256(abi.encodePacked(_choice)) == keccak256("Yes")){

            pollings[pollingId].acceptVotes++;
        
        }else if( keccak256(abi.encodePacked(_choice)) == keccak256("No")){

            pollings[pollingId].rejectVotes++;

        }else if(keccak256(abi.encodePacked(_choice)) == keccak256("NoInterested")){

            pollings[pollingId].notInterestedVotes++;
        }

        pollings[pollingId].hasVoted[msg.sender] = true;
        userVotedPollings[msg.sender].push(pollingId);

        Vote memory newVote = Vote(msg.sender,_choice,block.timestamp);
        pollings[pollingId].votes.push(newVote);

        //event for vote 
        emit Voted(pollingId,msg.sender, _choice, block.timestamp);
    }

    function getVotes(uint pollingId)public view returns(Vote[] memory){
        return pollings[pollingId].votes;
    }


    //for frontend maybe
    function pollExpirationStatus (uint pollingId)public view returns (bool){
        return block.timestamp < pollings[pollingId].expirationDate; // true or flase
    }
    

    function getAllPollings() public view returns(uint[] memory active,uint[] memory ended){
        uint total = pollingIdCounter.current();
        uint activeCount = 0;
        uint endedCount = 0;
        
        //get count of each array
        for (uint i = 1; i<=total; i++){
            if(pollings[i].expirationDate > block.timestamp){
                activeCount++;
            }else {
                endedCount++;
            }
        }

        active = new uint[](activeCount);
        ended = new uint[](endedCount);

        uint activeIndex = 0;
        uint endedIndex = 0;
        for(uint i= 1 ; i <= total ; i++){
            if(pollings[i].expirationDate > block.timestamp){
                active[activeIndex]=i;
                activeIndex++;
            }else {
                ended[endedIndex] = i;
                endedIndex++;
            }         
        }
    } 

    function getUserPollsAllreadyVoted() public view returns(uint[] memory){
        return userVotedPollings[msg.sender];
    }

    //get all votes already voted 
}