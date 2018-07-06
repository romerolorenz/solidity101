pragma solidity ^0.4.22;


contract HelloWorld {
    address[] private senders;
    
    mapping(address => uint) public indexOfSenders;
    mapping(address => Message) public SavedMessages;
    
    struct Message {
        string message;
        uint timeStamp;
    }
    
    event SaveMessage(address _from, string _message, uint _timeStamp);
    
    constructor() public {
        senders.push(address(0));
    }
    
    function saveMessage(string _message) public returns(bool _success) {
        require(indexOfSenders[msg.sender] == 0, "Already registered a message");
        Message memory m;
        m.message = _message;
        m.timeStamp = now;
        SavedMessages[msg.sender] = m;
        indexOfSenders[msg.sender] = senders.length;
        senders.push(msg.sender);
        emit SaveMessage(msg.sender, _message, now);
        return true;
    }
    
    function getMessage() public view returns(string _message) {
        Message storage m = SavedMessages[msg.sender];
        return m.message;
    }
    
    function getSenders() public view returns(address[] _senders) {
        return senders;
    }
}