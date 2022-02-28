// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract UAMinter is ERC721URIStorage, Ownable {
  using Counters for Counters.Counter;

  address payable public receiver = payable(0x17adc0894cBbc26eAaD8637A947F32612CcAf70F);
  
  Counters.Counter private _tokenIdTracker;

  constructor() ERC721("LazyNFT", "LAZ") {}

  function setReceiver(address payable _receiver) public onlyOwner {
      receiver = _receiver;
  }

  // TODO: add pausable
  function mint() public payable {
    _tokenIdTracker.increment();

    // TODO: add more options
    if (msg.value == 0.05 ether) {

        _mint(msg.sender, _tokenIdTracker.current());
        _setTokenURI(_tokenIdTracker.current(), "20");
        receiver.transfer(msg.value);
    } else {
        revert("Nope");
    }

  }
}