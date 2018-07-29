pragma solidity ^0.4.24;


contract BasketballLeague {

	/** Enums + Structs */
   

    /*
    struct Team {
        string metaDataLink;
        address teamOrganizationAddress; //Will be the address of a team DAO or can be an individual owner
        uint256 rosterCount;
    }

    /** Events */
    /*
    event TeamAdded(uint256 teamId);
    event PlayerDrafted(uint256 assetId, uint256 teamId);
    event PlayerRenounced(uint256 assetId, uint256 teamId);
    event CommisionerChanged(address oldCommisioner, address newCommisioner);
    event NewAssetCreated(AssetType assetType, uint256 assetId);
    event EmergencyStopOn();
    event EmergencyStopOff();

	/** Variables */
    address public commisioner; //Commisioner's job is to run the league and make new players.
   
   	//League Rules
    uint256 public maxTeamSalary;
    uint256 public maxTeamRosterSize;

    /*
    uint256 private teamCount;
    mapping(uint256 => Team) private teams;
    */

    /** Function Modifiers */
    modifier onlyCommisioner() {
        require(msg.sender == commisioner);
        _;
    }

	constructor() public {
	    
	    commisioner = msg.sender;
	    //leagueOrganizationAddress = msg.sender;
	    //assetCount = 0; //Start at 0 so ids will start counting from 1
	    //teamCount = 0;
	    //emergencyStop = false;
	}



}
