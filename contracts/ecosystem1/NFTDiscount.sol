// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

///@title Smart Contract EcoSystem 1, Contract 1: NFT with a Merkle Tree Discount 
///@author Brian Mullin

contract NFTDiscount {

    /// Map from tokenId to address because we know the which tokenIds
    /// we are going to produce, but not which addresses will own the tokens.
    /// You cannot iterate over mappings inside of Solidity.
    mapping(uint256 => address) private _owners;

    /// first address is msg.sender, second address is the one being approved, and a bool to say if it is approved or not.
    mapping(address => mapping(address => bool)) private _operators;

    function mint(uint256 _tokenId) external {
        require(_owners[_tokenId] == address(0), "Already minted");
        require(_tokenId < 21, "_tokenId too large");
        _owners[_tokenId] = msg.sender;
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        //
        require(_owners[_tokenId] != address(0), "No such token");
        return _owners[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        //check if token id exists
        require(_owners[_tokenId] != address(0), "Token does not exist");
        require(_owners[_tokenId] == _from, "Cannot transfer from");
        require(msg.sender == _from, "Required to be owner");

        _owners[_tokenId] = _to;
    }

    function tokenURI(uint256 _tokenId) external view returns (string) {
        
    }
}