pragma solidity ^0.4.17;

contract GoGame {

    address public black;
    address public white;
    address public winner;
    uint public wager = 0;
    uint public komi = 6;
    bool start = false;
    bool finish = false;
    uint8[18][18] goban;

    struct Board {
        uint blackStoneCount;
        uint whiteStoneCount;
        address turn;
        mapping(address => bool) forfeit;
    }

    Board public board;

    function  getTerritoryValue(uint8 x, uint8 y) constant public returns (uint8) {
        return goban[x][y];
    }

    function placeStone( uint8 x, uint8 y){
        if (msg.sender == black){
            goban[x][y] = 1;
        }else{
            goban[x][y] = 2;
        }
    }

    function GoGame() public {
        //assign playerOne to contract sender's address
        black = msg.sender;
    }

    function enter() public{
        /*require(msg.value > wager);*/
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
