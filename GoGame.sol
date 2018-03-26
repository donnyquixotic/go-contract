pragma solidity ^0.4.17;

contract GoGame {

    address public black;
    address public white;
    address public winner;
    uint public wager = 0;
    uint public komi = 6;
    bool start = false;
    bool finish = false;

    struct Board {
        uint blackStoneCount;
        uint whiteStoneCount;
        address turn;
        mapping(address => bool) forfeit;
    }

    Board public board;

    function GoGame() public {
        //assign playerOne to contract sender's address
        black = msg.sender;
    }

    function enter() public payable {
        //ether sent validation wei default
        require(msg.value > wager);
        white = msg.sender;
    }

    function startGame() public status {
        start = true;
    }

    function setKomi(uint amount) public payable status{
        //set Komi to different value for white stone player
        komi = amount;
    }

    function setWager(uint amount) public payable status {
        //set Komi to different value for white stone player
        wager = amount;
    }


    function switchStones() public status {
        address temp = black;
        black = white;
        white = temp;
    }

    function disperseWinnings() public payable restricted {
        winner.transfer(this.balance);
    }

    modifier restricted() {
        require((address(winner) != 0));
        _;
    }

    modifier status() {
        require(!start);
        _;
    }

}
