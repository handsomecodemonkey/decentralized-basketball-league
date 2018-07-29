pragma solidity ^0.4.24;


contract BasketballLeague {

	/** Enums + Structs */
   
    struct Team {
        string metaDataLink;
        address owner; //Will be the address of a team DAO or can be an individual owner
    }

    /** Events */
    
    event TeamAdded(uint256 teamId);
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

    /*
    uint256 private teamCount;
    mapping(uint256 => Team) private teams;
    */

    /** Function Modifiers */
    modifier onlyCommisioner() {
        require(msg.sender == commisioner);
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

    function setMaxTeamSalary(uint256 _maxTeamSalary) public onlyCommisioner {
        maxTeamSalary = _maxTeamSalary;
    }
    
    function setMaxTeamSize(uint256 _maxTeamSize) public onlyCommisioner {
        maxTeamSize = _maxTeamSize;
    }

    function createNewTeam(string _metaData, address _owner) public onlyCommisioner {
        teamCount++;
        Team memory newTeam = Team(_metaData, _owner);
        teams[teamCount] = newTeam;
        emit TeamAdded(teamCount);
    }

}
