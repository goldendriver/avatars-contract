pragma solidity ^0.5.0;

contract ERC20Interface {
    function balanceOf(address from) public view returns (uint256);
    function transferFrom(address from, address to, uint tokens) public returns (bool);
    function allowance(address owner, address spender) public view returns (uint256);
    function burn(uint256 amount) public;
}

contract AvatarNameStorage {
    // Storage
    ERC20Interface public manaToken;
    uint256 public blocksUntilReveal;
    uint256 public blocksToExpire;
    uint256 public price;

    struct Data {
        string username;
        string metadata;
    }
    struct Commit {
        bytes32 commit;
        uint256 blockNumber;
        bool revealed;
    }

    // Stores commit messages by accounts
    mapping (address => Commit) public commit;
    // Stores usernames used
    mapping (string => address) usernames;
    // Stores account data
    mapping (address => Data) public user;
    // Stores account roles
    mapping (address => bool) public allowed;

    // Events
    event Register(
        address indexed _owner,
        string _username,
        string _metadata,
        address indexed _caller
    );
    event MetadataChanged(address indexed _owner, string _metadata);
    event Allow(address indexed _caller, address indexed _account, bool _allowed);
    event CommitUsername(address indexed _owner, bytes32 indexed _hash, uint256 _blockNumber);
    event RevealUsername(address indexed _owner, bytes32 indexed _hash, uint256 _blockNumber);
    event BlocksUntilRevealChanged(address indexed _caller, uint256 _oldValue, uint256 _newValue);
    event BlocksToExpireChanged(address indexed _caller, uint256 _oldValue, uint256 _newValue);
}
