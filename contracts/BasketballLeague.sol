pragma solidity ^0.4.24;


contract BasketballLeague {

	/** Enums + Structs */
   
    struct Team {
        string name;
        string metaData;
        address owner; //Will be the address of a team DAO or can be an individual owner
        uint256 stakedEth;
    }

    /** Events */
    
    event TeamAdded(uint256 teamId, string teamName);
    //event PlayerDrafted(uint256 assetId, uint256 teamId);
    //event PlayerRenounced(uint256 assetId, uint256 teamId);
    //event CommisionerChanged(address oldCommisioner, address newCommisioner);
    //event NewAssetCreated(AssetType assetType, uint256 assetId);
    //event EmergencyStopOn();
    //event EmergencyStopOff();

	/** Variables */
    address public commisioner; //Commisioner's job is to run the league and make new players.
   
   	//League Rules
    uint256 public maxTeamSalary;
    uint256 public maxTeamSize;

    //Teams
    uint256 private teamCount;
    mapping(uint256 => Team) private teams;

    //Proposals
    uint256 private proposalCount;
    mapping(uint256 => Team) public proposedTeams;

    /*
    uint256 private teamCount;
    mapping(uint256 => Team) private teams;
    */

    /** Function Modifiers */
    modifier onlyCommisioner() {
        require(msg.sender == commisioner);
        _;
    }

    modifier requiresStakedEth(uint _amount) {
    	require( (msg.value != 0) && (msg.value / (1 ether) >= _amount) );
    	_;
    }

	constructor(uint256 _maxTeamSalary, uint256 _maxTeamSize) public {
	    commisioner = msg.sender;
	    maxTeamSalary = _maxTeamSalary;
	    maxTeamSize = _maxTeamSize;
	    teamCount = 0;
	    //assetCount = 0; //Start at 0 so ids will start counting from 1
	    //emergencyStop = false;
	}

	//Returns total eth in the contract
	function ethPool() public view returns(uint) {
		return address(this).balance;
	}

	//Commisioner only functions
    function setMaxTeamSalary(uint256 _maxTeamSalary) public onlyCommisioner {
        maxTeamSalary = _maxTeamSalary;
    }
    
    function setMaxTeamSize(uint256 _maxTeamSize) public onlyCommisioner {
        maxTeamSize = _maxTeamSize;
    }

    function approveTeamProposal(uint256 _proposalId) public onlyCommisioner {
    	//TODO make sure you don't approve twice
    	Team memory team = proposedTeams[_proposalId];
    	delete proposedTeams[_proposalId];
    	createNewTeam(team);
    }

    function withdrawTeamProposal(uint256 _proposalId) public {
    	//TODO make sure you can't do twice
    	Team memory team = proposedTeams[_proposalId];
    	require(msg.sender == team.owner);
    	delete proposedTeams[_proposalId];
    	msg.sender.transfer(team.stakedEth);
    }

    //public functions
    function proposeNewTeam(string _name, string _metaData) public payable requiresStakedEth(maxTeamSalary) {
    	proposalCount++;
    	Team memory newTeam = Team(_name, _metaData, msg.sender, msg.value);
    	proposedTeams[proposalCount] = newTeam;
    }

    function createNewTeam(Team _newTeam) internal {
        teamCount++;
        teams[teamCount] = _newTeam;
        emit TeamAdded(teamCount, _newTeam.name);
    }

}
