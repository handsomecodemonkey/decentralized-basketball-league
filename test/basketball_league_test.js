const BasketballLeague = artifacts.require("BasketballLeague");

contract('BasketballLeagueTest', function(accounts) {

	let bLeague;

	beforeEach(async() => {
		bLeague = await BasketballLeague.new({from: accounts[0]});
	});

});
