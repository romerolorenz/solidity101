pragma solidity ^0.4.22;


contract HelloWorld {
    // declaring a dynamic variable array
    address[] private senders;
    
    // getter functions are created for state variables with public visibility
    // mappings initialize all possibile values to a default value of 0
    // indexOf mapping is used to maintain arrays and check if msg.sender has a saved message i.e. if(indexOfSenders[msg.sender] > 0)
    mapping(address => uint) public indexOfSenders;
    // stores Message struct to a specific address
    mapping(address => Message) public SavedMessages;
    
    struct Message {
        string message;
        uint timeStamp;
    }
    
    // events are a cheap way to store data which doesn't have to be accessed by the chain or a contract
    // apps can watch/retrieve an event
    event SaveMessage(address _from, string _message, uint _timeStamp);
    
    // modifiers for reusable code and checks
    
    constructor() public {
        // pushes address(0) as senders[0]
        senders.push(address(0));
    }
    
    // visibility (public, private, external, internal)
    // returning a bool is useful when another contract calls your contract
    function saveMessage(string _message) public returns(bool _success) {
        // throws a revert if condition is not met, refunds unused gas
        require(indexOfSenders[msg.sender] == 0, "Already registered a message");
        // should be explicit when stating memory and storage
        Message memory m;
        m.message = _message;
        m.timeStamp = now;
        SavedMessages[msg.sender] = m;
        indexOfSenders[msg.sender] = senders.length;
        senders.push(msg.sender);
        emit SaveMessage(msg.sender, _message, now);
        return true;
    }
    
    // view functions do not edit state
    function getMessage() public view returns(string _message) {
        Message storage m = SavedMessages[msg.sender];
        return m.message;
    }
    
    function getSenders() public view returns(address[] _senders) {
        return senders;
    }
}