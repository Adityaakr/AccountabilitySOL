// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import './AccountabilityNFTs.sol';

// lock up funds for a period of time
// users can only unlock funds if they own an NFT from another smart contract


contract Accountability {

    //Create a Struct that stores:
    // 1. the wallet address is the key
    // 2. the amount of funds locked up
    // 3. The time the funds were locked up for
    // 4. When the user locked the funds up

    struct LockedFunds{
        uint amount; //amount of funds locked uo
        uint time; // The amount of time funds locked up for
        uint lockedAt; // when the user locked the funds
    }

    //1. The wallet address is the key that maps to a lockedFunds struct
    mapping(address => LockedFunds) public lockedFunds; 

    function lockedFunds(uint256 _amount, uint256 _time) public payable {
        //first check to see if the user has already locked up funds
        require(lockedFunds[msg.sender].amount == 0, "You have already locked up funds");        
        //Update the lockedfunds mappig with the new amount of ETH 
        lockedFunds[msg.sender] = LockedFunds(msg.value, _time, block.timestamp);
    }

    function withdraw() public{
        require(lockedFunds[msg.sender].amount > 0, "You have no locked funds");
        require(block.timestamp >= lockedFunds[msg.sender].lockedAt + lockedFunds[msg.sender].time, "You cannot withdraw yet");
        require(accountabilityNFTs.balanceOf(msg.sender) > 0, "You do not own an NFT");
        payable(block.sender).transfer(lockedFunds[msg.sender].amount);
        lockedFunds[msg.sender].amount = 0;
    }                                   

    //store the NFT Collection smart contract in this variable.
    AccountabilityNFTs public accountabilityNFTs; 
   account
    

    constructor(){
        //Here we are going to check which nft collection to check
        //for ownership of. 
        AccountabilityNFTs _nftcollectionAddress
    } {
        //define the nft smart contract address
        accountabilityNFTs = _nftCollectionAddress;
    }
    //1.store the amoutn of eth each address has depositeed in this smart contract
    //- THis will go inside of a mapping that maps an address to a uint

    //2) Withdraw function that checks if the user owns an NFT from  the smart contract.
    // - If they do: send them ETH back
    // - If they don't; revert the txn

    //3) Functions that checks when the user can call the withdraw function again
    // - Baed on the amount of time they've deposited ETH for
}