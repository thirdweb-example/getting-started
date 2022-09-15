// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract GettingStarted is ERC721Base, PermissionsEnumerable {
    // A mapping is a key-value store that lets us keep data in our contract.
    // Here, the key is the token ID, and the value is the power level for that NFT.
    mapping(uint256 => uint256) public powerLevel;

    function setPowerLevel(uint256 _tokenId, uint256 _powerLevel) external onlyRole(DEFAULT_ADMIN_ROLE) {
        powerLevel[_tokenId] = _powerLevel;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        // Give the contract deployer the "admin" role when the contract is deployed.
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintTo(address _to, string memory _tokenURI) public virtual override {
        // Grab the next token ID being minted.
        uint256 tokenId = nextTokenIdToMint();

        // Here, "super" refers to the base contract.
        // We are essentially saying "run the mintTo method from the base contract".
        super.mintTo(_to, _tokenURI);

        // *then* we can add our custom logic on top:
        powerLevel[tokenId] = tokenId;
    }
}   