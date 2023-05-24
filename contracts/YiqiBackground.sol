// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

// TODO: if backend doesn't implement any enumerable function, then change it to standard erc721
contract YiqiBackground is ERC2981, ERC721 {
    /// @notice Counter for the token ID
    uint256 internal s_nextTokenId;

    /// @notice Address of the Yiqi contract
    address internal immutable i_yiqi;

    /// @notice Address of the YiqiTreasury contract
    address internal s_yiqiTreasury;

    /// @notice The base URI for the NFT metadata
    string internal BASE_URI;

    /// @notice The price for minting a new NFT
    // TODO TEAM: check mint price
    uint256 public constant MINT_PRICE = 0.01 ether;

    bool internal initialized;

    event YiqiBackgroundMinted(address indexed owner, uint256 indexed tokenId);

    modifier onlyYiqi() {
        require(msg.sender == i_yiqi, "YiqiTreasury: Only Yiqi can call this function.");
        _;
    }

    error YiqiBackground__NotEnoughETHForMint(uint256 price, uint256 amount);
    error YiqiBackground__AlreadyInitialized();

    constructor(
        address _yiqi
    ) ERC721("QI Background", "QIB") {
        i_yiqi = _yiqi;
    }

    /**
     * @dev Initializes the contract
     */
    function initialize(
        address _yiqiTreasury,
        string memory _baseUri,
        uint96 _feeNumerator
    ) external {
        if (initialized) revert YiqiBackground__AlreadyInitialized();
        // TODO: require msg.sender == hardcoded address to prevent frontrunning
        initialized = true;
        BASE_URI = _baseUri;
        s_yiqiTreasury = _yiqiTreasury;
        _setDefaultRoyalty(s_yiqiTreasury, _feeNumerator);
    }

    /**
     * @notice Requests a new NFT mint
     * @dev The NFT will be minted after the VRF request is fulfilled
     */
    function mint() public payable {
        if (msg.value < MINT_PRICE) {
            revert YiqiBackground__NotEnoughETHForMint(MINT_PRICE, msg.value);
        }

        uint256 tokenId = s_nextTokenId;
        s_nextTokenId++;

        s_yiqiTreasury.call{value: msg.value}("");

        _safeMint(msg.sender, tokenId);
        emit YiqiBackgroundMinted(msg.sender, tokenId);
    }

    /**
     * @notice Mints a new NFT
     * @dev This function can only be called by the Yiqi contract
     */
    function mintBackgroundWithYiqi(address receiver) external onlyYiqi returns (uint256 tokenId) {
        tokenId = s_nextTokenId;
        s_nextTokenId++;

        _safeMint(receiver, tokenId);
        emit YiqiBackgroundMinted(receiver, tokenId);
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        return "Yiqi Background";
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return "QIB";
    }

    /**
     * @dev See {IERC165-supportsInterface} and {IERC721-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC721, ERC2981) returns (bool) {
        return ERC721.supportsInterface(interfaceId) || ERC2981.supportsInterface(interfaceId);
    }

    /**
     * @dev Base URI for computing {tokenURI}. The resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`.
     */
    function _baseURI() internal view override returns (string memory) {
        return BASE_URI;
    }
}
