pragma solidity ^0.4.0;

// Understanding structs
// Using events and modifiers as well

contract BasicCrowdFunding {
    address public owner;

    struct Funder {
        address user;
        uint amount;
    }

    struct Campaign {
        address campaignReceiver;
        uint fundingGoal;
        uint numberOfFunders;
        uint totalAmount;
        mapping(uint => Funder) funders;
    }

    function BasicCrowdFunding() {
        owner = msg.sender;
    }

    uint numberOfCampaigns;
    mapping(uint => Campaign) campaigns;

    function createNewCampaign(address, uint goal) ifCampaignOwner returns (uint campaignID) {
        campaignID = numberOfCampaigns++;
        campaigns[campaignID] = Campaign(owner, goal, 0, 0);
    }

    function contribute(uint campaignID) payable {
        Campaign storage c = campaigns[campaignID];

        c.funders[c.numberOfFunders++] = Funder({user: msg.sender, amount: msg.value});
        c.totalAmount += msg.value;
    }

    function checkIfGoalReached(uint campaignID) returns (bool) {
        Campaign storage c = campaigns[campaignID];

        if(c.fundingGoal >= c.totalAmount) {
            LogSuccess("It was a success!");
            return true;
        } else {
            LogFailure("It was a failure");
            return false;
        }
    }

    event LogSuccess(string _message);
    event LogFailure(string _message);

    modifier ifCampaignOwner() {
        if(owner != msg.sender) {
            throw;
        } else {
            _;
        }
    }
}
