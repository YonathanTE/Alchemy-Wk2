// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Deployed to Goerli @ 0x9FCf712D689b0e7b0A7b1E2eA73163411e09B99d

contract BuyMeACoffee {
    // Event to emit a Memo when it is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memos received from donations given by ppl
    Memo[] memos;

    // Address for the contract deployer
    address payable owner;

    // To deploy logic (Occurs only when the contract is deployed)
    constructor () {
        owner = payable(msg.sender); // Not implicity convertible until the 'payable' keyword is cast for the 'msg.sender'
    }

    /**
     * @dev to purchase a coffee for the contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message from the person who bought the coffee
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Not enough ETH, plz send more. Please...");

        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
            ));

        // Emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev to send the whole balance stored in the contract to the owner
     */
    function withdrawTips() public  {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev Gets all memos received & stored on-chan
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
