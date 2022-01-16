// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract lottery
{
    address public manager;
    address payable[] public participants;
    constructor ()
    {
      manager = msg.sender;
    }
    receive() external payable
    {require (msg.value == 2 ether);
        participants.push(payable(msg.sender));
    }
    function getBalanece() public view returns(uint)
    {require(msg.sender == manager);
        return address(this).balance;
    }
    function random() public view returns(uint)
    {
        return uint (keccak256 (abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

    }
    function Winner() public
    {
        require(msg.sender == manager );
        require(participants.length >=3);
        address payable winner;
        uint r =random();
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(getBalanece());
        participants = new address payable [] (0);

    }

}