// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/Counters.sol";

contract World3 {
    using Counters for Counters.Counter;
    Counters.Counter private researchersCount;
    Counters.Counter private donersCount;

    // mapping(uint256 => Researcher) private researches;

    struct Researcher {
        uint256 id;
        address payable owner;
        uint256 dateJoined;
        Doners doners;
        string name;
        string profile;
        string contact;
        string country;
        string sdg;
        string image;
    }

    struct Doners {
        uint256 id;
        address _address;
        uint256 amount;
    }

    event MarketItemCreated(
        uint256 indexed tokenId,
        address owner,
        uint256 dateJoined,
        string name,
        string profile,
        string contact,
        string country,
        string sdg,
        string image
    );

    mapping(uint256 => Researcher) reseacher;
    mapping(uint256 => mapping(uint256 => Doners)) public doners;

    function addResearcher(
        string memory name,
        string memory profile,
        string memory contact,
        string memory country,
        string memory sdg,
        string memory imamge
    ) external {
        researchersCount.increment();
        Researcher storage _researcher = researcher[researchersCount.current()];
        _researcher.id = researchersCount.current();
        _researcher.owner = payable(address(_researcher.owner));
        _researcher.dateJoined = block.timestamp;
        _researcher.doners = [];
        _researcher.name = name;
        _researcher.profile = profile;
        _researcher.contact = contact;
        _researcher.country = country;
        _researcher.sdg = sdg;
        _researcher.image = image;
        _researcher.profile = block.timestamp;
        _researcher[researchersCount] = _researcher;
        emit Researcher(
            researchersCount,
            msg.sender,
            _researcher.dateJoined,
            _researcher.doners,
            _researcher.name,
            _researcher.profile,
            _researcher.contact,
            _researcher.country,
            _researcher.sdg,
            _researcher.image
        );
    }

    function donate(uint256 id, uint256 _amount) public {
        donersCount.increment();
        Researcher storage _researcher = reseacher[id];
        Doners storage _doners = doners[id][donersCount.current()];

        _doners.id = donersCount.current();
        _doners._address = msg.sender;
        _doners.amount = _amount;
        _researcher.owner.transfer(msg.value);
    }

    // get functions

    //without validdation
    function createFolder(string memory _foldername, uint256 _platformId)
        public
    {
        folderCount[msg.sender] = folderCount[msg.sender] + 1;
        Folder storage _folder = folder[msg.sender][folderCount[msg.sender]];
        // require(
        //     _folder.platformId == _platformId &&
        //         keccak256(abi.encodePacked(_folder.folderCount)) ==
        //         keccak256(abi.encodePacked(_foldername)),
        //     "Folder name already exisits"
        // );

        _folder.id = folderCount[msg.sender];
        _folder.folderCount = folderCount[msg.sender];
        _folder.folderName = _foldername;
        _folder.platformId = _platformId;
        _folder.owner = msg.sender;
        folder[msg.sender][folderCount[msg.sender]] = _folder;
        emit FolderCreated(_folder.folderCount, _foldername);
    }

    function addFiles(
        uint256 _folderId,
        string memory _fileHash,
        uint256 _fileSize,
        string memory _fileType,
        string memory _fileName,
        string memory _fileDescription
    ) public {
        require(bytes(_fileHash).length > 0);

        require(bytes(_fileType).length > 0);

        // require(bytes(_fileDescription).length > 0);

        require(bytes(_fileName).length > 0);

        require(_fileSize > 0);
        fileCount[msg.sender][_folderId] = fileCount[msg.sender][_folderId] + 1;

        File storage _file = file[_folderId][fileCount[msg.sender][_folderId]];
        // require(
        //     _file.folderId == _folderId &&
        //         keccak256(abi.encodePacked(_file.fileName)) ==
        //         keccak256(abi.encodePacked(_fileName)),
        //     "Folder name already exisits"
        // );
        _file.fileId = fileCount[msg.sender][_folderId];
        _file.fileCount = fileCount[msg.sender][_folderId];
        _file.fileHash = _fileHash;
        _file.fileSize = _fileSize;
        _file.fileType = _fileType;
        _file.fileName = _fileName;
        _file.folderId = _folderId;
        _file.fileDescription = _fileDescription;
        _file.uploadTime = block.timestamp;
        _file.sender = msg.sender;
        file[_folderId][fileCount[msg.sender][_folderId]] = _file;
        emit FileCreated(
            _file.fileId,
            _file.fileCount,
            _file.fileHash,
            _file.fileSize,
            _file.fileType,
            _file.fileName,
            _folderId,
            _file.fileDescription,
            _file.uploadTime,
            msg.sender
        );
    }

    //  my platforms
    function getPlatforms() public view returns (Platform[] memory) {
        uint256 itemCount = platform[msg.sender][platformCount[msg.sender]]
            .platformCount;
        uint256 currentIndex = 0;
        Platform[] memory _platform = new Platform[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            Platform storage currentItem = platform[msg.sender][currentId];
            _platform[currentIndex] = currentItem;
            currentIndex += 1;
        }
        return _platform;
    }

    //get folders
    function getFolders(uint256 _platformId)
        public
        view
        returns (Folder[] memory)
    {
        uint256 itemCount = folder[msg.sender][folderCount[msg.sender]]
            .folderCount;
        uint256 currentIndex = 0;
        Folder[] memory _folder = new Folder[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (folder[msg.sender][i + 1].platformId == _platformId) {
                uint256 currentId = i + 1;
                Folder storage currentItem = folder[msg.sender][currentId];
                _folder[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return _folder;
    }

    //get files
    function getFiles(uint256 _folderId) public view returns (File[] memory) {
        uint256 itemCount = file[_folderId][fileCount[msg.sender][_folderId]]
            .fileCount;
        uint256 currentIndex = 0;
        File[] memory _file = new File[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            File storage currentItem = file[_folderId][currentId];
            _file[currentIndex] = currentItem;
            currentIndex += 1;
        }
        return _file;
    }

    //get users
    function fetchAllUsers() public view returns (User[] memory) {
        uint256 itemCount = userCount;
        uint256 currentIndex = 0;
        User[] memory items = new User[](itemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            uint256 currentId = i + 1;
            User storage currentItem = users[currentId];
            items[currentIndex] = currentItem;
            currentIndex += 1;
        }
        return items;
    }

    //get registered user
    function isRegistered() public view returns (bool) {
        if (registeredUsers[msg.sender] == true) {
            return true;
        } else {
            return false;
        }
    }

    //get user
    function getSingleUser() public view returns (User memory) {
        return userProfile[msg.sender];
    }

    //tipUser
    function tipUser(uint256 id) public payable {
        User storage _users = users[id];
        _users._address.transfer(msg.value);
        _users.balance = _users.balance + msg.value;
        users[id] = _users;
    }

    //NFT functions

    /* Updates the listing price of the contract */
    function updateListingPrice(uint256 _listingPrice) public payable {
        require(
            owner == msg.sender,
            "Only marketplace owner can update listing price."
        );
        listingPrice = _listingPrice;
    }

    /* Returns the listing price of the contract */
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    /* Mints a token and lists it in the marketplace */
    function createToken(
        string memory tokenURI,
        uint256 price,
        string memory _name,
        string memory _description,
        string memory _image
    ) public payable returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        createMarketItem(newTokenId, price, _name, _description, _image);
        return newTokenId;
    }

    function createMarketItem(
        uint256 tokenId,
        uint256 price,
        string memory _name,
        string memory _description,
        string memory _image
    ) private {
        require(price > 0, "Price must be at least 1 wei");
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );

        idToMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false,
            _name,
            _description,
            _image
        );

        _transfer(msg.sender, address(this), tokenId);
        emit MarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false,
            _name,
            _description,
            _image
        );
    }

    /* allows someone to resell a token they have purchased */
    function resellToken(uint256 tokenId, uint256 price) public payable {
        require(
            idToMarketItem[tokenId].owner == msg.sender,
            "Only item owner can perform this operation"
        );
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );
        idToMarketItem[tokenId].sold = false;
        idToMarketItem[tokenId].price = price;
        idToMarketItem[tokenId].seller = payable(msg.sender);
        idToMarketItem[tokenId].owner = payable(address(this));
        _itemsSold.decrement();

        _transfer(msg.sender, address(this), tokenId);
    }

    /* Creates the sale of a marketplace item */
    /* Transfers ownership of the item, as well as funds between parties */
    function createMarketSale(uint256 tokenId) public payable {
        uint256 price = idToMarketItem[tokenId].price;
        address seller = idToMarketItem[tokenId].seller;
        require(
            msg.value == price,
            "Please submit the asking price in order to complete the purchase"
        );
        idToMarketItem[tokenId].owner = payable(msg.sender);
        idToMarketItem[tokenId].sold = true;
        idToMarketItem[tokenId].seller = payable(address(0));
        _itemsSold.increment();
        _transfer(address(this), msg.sender, tokenId);
        payable(owner).transfer(listingPrice);
        payable(seller).transfer(msg.value);
    }

    /* Returns all unsold market items */
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _tokenIds.current();
        uint256 unsoldItemCount = _tokenIds.current() - _itemsSold.current();
        uint256 currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(this)) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    /* Returns only items that a user has purchased */
    function fetchMyNFTs() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    /* Returns only items a user has listed */
    function fetchItemsListed() public view returns (MarketItem[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
