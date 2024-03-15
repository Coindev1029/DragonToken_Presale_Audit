/* $DRAGON Links:
Medium: https://medium.com/@DragonFireAvax
Twitter: @DragonFireAvax
Discord: https://discord.gg/uczFJdMaf4
Telegram: DragonFireAvax
Website: www.DragonFireAvax.com
Email: contact@DragonFireAvax.com
*/

//$DRAGON is an ERC20 token that collects fees on transfers, and creates LP with other top community tokens.
//Base contract imports created with https://wizard.openzeppelin.com/ using their ERC20 with Permit and Ownable.


interface IUniswapV2Factory { 

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);


    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

}



interface IUniswapV2Router01 {

    function factory() external pure returns (address);


    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );


    function addLiquidityAVAX(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountAVAXMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountAVAX,
            uint256 liquidity
        );
}



interface IUniswapV2Router02 is IUniswapV2Router01 {

    function swapExactAVAXForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;


    function swapExactTokensForAVAXSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}



interface IERC20Token { //Generic ability to transfer out funds accidentally sent into the contract
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}



interface IERC721Token { //Generic ability to transfer out NFTs accidentally sent into the contract
    function transferFrom(address from, address to, uint256 tokenId) external; 
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function safeTransfer(address from, address to, uint256 tokenId) external;
    function transfer(address from, address to, uint256 tokenId) external;
}


//ASCII art attributed to -Tua Xiong :

/*
                                        ,   ,
                                        $,  $,     ,
                                        "ss.$ss. .s'
                                ,     .ss$$$$$$$$$$s,
                                $. s$$$$$$$$$$$$$$`$$Ss
                                "$$$$$$$$$$$$$$$$$$o$$$       ,
                               s$$$$$$$$$$$$$$$$$$$$$$$$s,  ,s
                              s$$$$$$$$$"$$$$$$""""$$$$$$"$$$$$,
                              s$$$$$$$$$$s""$$$$ssssss"$$$$$$$$"
                             s$$$$$$$$$$'         `"""ss"$"$s""
                             s$$$$$$$$$$,              `"""""$  .s$$s
                             s$$$$$$$$$$$$s,...               `s$$'  `
                         `ssss$$$$$$$$$$$$$$$$$$$$####s.     .$$"$.   , s-
                           `""""$$$$$$$$$$$$$$$$$$$$#####$$$$$$"     $.$'
                                 "$$$$$$$$$$$$$$$$$$$$$####s""     .$$$|
                                  "$$$$$$$$$$$$$$$$$$$$$$$$##s    .$$" $
                                   $$""$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"   `
                                  $$"  "$"$$$$$$$$$$$$$$$$$$$$S""""'
                             ,   ,"     '  $$$$$$$$$$$$$$$$####s
                             $.          .s$$$$$$$$$$$$$$$$$####"
                 ,           "$s.   ..ssS$$$$$$$$$$$$$$$$$$$####"
                 $           .$$$S$$$$$$$$$$$$$$$$$$$$$$$$#####"
                 Ss     ..sS$$$$$$$$$$$$$$$$$$$$$$$$$$$######""
                  "$$sS$$$$$$$$$$$$$$$$$$$$$$$$$$$########"
           ,      s$$$$$$$$$$$$$$$$$$$$$$$$#########""'
           $    s$$$$$$$$$$$$$$$$$$$$$#######""'      s'         ,
           $$..$$$$$$$$$$$$$$$$$$######"'       ....,$$....    ,$
            "$$$$$$$$$$$$$$$######"' ,     .sS$$$$$$$$$$$$$$$$s$$
              $$$$$$$$$$$$#####"     $, .s$$$$$$$$$$$$$$$$$$$$$$$$s.
   )          $$$$$$$$$$$#####'      `$$$$$$$$$###########$$$$$$$$$$$.
  ((          $$$$$$$$$$$#####       $$$$$$$$###"       "####$$$$$$$$$$
  ) \         $$$$$$$$$$$$####.     $$$$$$###"             "###$$$$$$$$$   s'
 (   )        $$$$$$$$$$$$$####.   $$$$$###"                ####$$$$$$$$s$$'
 )  ( (       $$"$$$$$$$$$$$#####.$$$$$###'                .###$$$$$$$$$$"
 (  )  )   _,$"   $$$$$$$$$$$$######.$$##'                .###$$$$$$$$$$
 ) (  ( \.         "$$$$$$$$$$$$$#######,,,.          ..####$$$$$$$$$$$"
(   )$ )  )        ,$$$$$$$$$$$$$$$$$$####################$$$$$$$$$$$"
(   ($$  ( \     _sS"  `"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$S$$,
 )  )$$$s ) )  .      .   `$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"'  `$$
  (   $$$Ss/  .$,    .$,,s$$$$$$##S$$$$$$$$$$$$$$$$$$$$$$$$S""        '
    \)_$$$$$$$$$$$$$$$$$$$$$$$##"  $$        `$$.        `$$.
        `"S$$$$$$$$$$$$$$$$$#"      $          `$          `$
            `"""""""""""""'         '           '           '
*/


/*   888
     888                                        
     888                                        
     888                                        
     888                                        
 .d88888888d888 8888b.  .d88b.  .d88b. 88888b.  
d88" 888888P"      "88bd88P"88bd88""88b888 "88b 
888  888888    .d888888888  888888  888888  888 
Y88b 888888    888  888Y88b 888Y88..88P888  888 
 "Y88888888    "Y888888 "Y88888 "Y88P" 888  888 
                            888                 
                       Y8b d88P                 
                        "Y88P"  
*/

// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DragonFire is ERC20, ERC20Permit, Ownable {

    uint256 public constant SECONDS_PER_PHASE = 8 minutes; //Seconds per each phase, 8 minutes is 480 seconds
    uint256 public constant TOTAL_PHASES = 8; //Last phase is the public non whale limited phase
    uint256 public constant TOTAL_SUPPLY_WEI = 88888888000000000000000000; //88,888,888 DRAGON

    address public constant DEAD = 0x000000000000000000000000000000000000dEaD; //Burn LP by sending it to this address 
    address public constant WAVAX = 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7; 
    //WAVAX Mainnet: 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7 ; Fuji: 0xd00ae08403B9bbb9124bB305C09058E32C39A48c


    IUniswapV2Router02 public uniswapV2Router; //DEX router for swapping Dragon and making all LP pairs on our own new dex
    IUniswapV2Router02[] public uniswapV2Routers; //DEX routers for swapping AVAX for Community Tokens (aka CT) on other dexs

    address[] public communityTokens; //Array of CommunityTokens
    address[] public ctRouters; //Array of CommunityTokens routers, so we can buy each CT on the dex with highest liquidity for it

    address public uniswapV2Pair; //Swap with this pair DRAGON/WAVAX
    address public routerLP; //Main Dragon LP dex router
    address public treasuryAddress; //Team multisig
    address public farmAddress; //Farming rewards treasury

    bool private swapping; //Fees processing reentrancy guard
    bool public phasesInitialized; //Lock phases before IDO launch
    bool public feesLocked; //Option to lock all fees settings

    uint256 public processFeesMinimum; //Minimum DRAGON collected in contract before fees processing, to save gas
    uint256 public communityLPFee; //LP fee divided over all CommunityTokens LP DRAGON/CT, will swap half from DRAGON to make LP
    uint256 public liquidityFee; //LP fee for DRAGON/WAVAX LP, will swap half from DRAGON to make LP
    uint256 public treasuryFee; //Team treasury fee, keep all as DRAGON
    uint256 public farmFee; //Farm fee, keep all as DRAGON
    uint256 public totalFees; //Represented as basis points where 100 == 1%
    uint256 public startTime; //Phases start time
    uint256 public lastTimeCalled; //Last time processFees was called

    mapping (address => bool) public dragonCtPairs; //Track LP pairs for DRAGON/CT
    mapping (address => bool) public approvedRouters; //Approved routers for buying CT with AVAX and making LP
    mapping (address => bool) public isExcludedFromFees; //Swap fees exclusion list
    mapping (address => uint256) public allowlisted; //Allowlist for gated phases
    mapping (address => uint256) public totalPurchased; //Track total purchased by user during gated phases
    mapping (uint256 => uint256) public maxWeiPerPhase; //Maximum DRAGON tokens that can be purchased by a user during some phase


    event SwapAndLiquify( 
        uint256 dragonIntoLiquidity,
        uint256 tokenBIntoLiquidity,
        address indexed tokenB
    ); //Swap for LP event

    event ProcessFees( 
        address indexed user,
        uint256 dragonTokensProcessed
    );

    event SettingsChanged(
        address indexed user,
        string indexed setting
    ); //This is to alert the public that an owner setting has changed, rather than track all the particulars of the setting changed

    event IncludeInFees(
        address indexed userIncluded
    );

    event ExcludeFromFees(
        address indexed userExcluded
    );

    event AvaxWithdraw(
        address indexed to, 
        uint256 amount
    );

    event TokenWithdraw(
        address indexed to, 
        uint256 amount,
        address indexed token
    );

    event TokenApproved(
        address indexed spender, 
        uint256 amount,
        address indexed token
    );

    event NFTWithdraw(
        address indexed to, 
        uint256 ID,
        address indexed token
    );


    modifier feeSettingsLock() {
        require(tradingPhase() == TOTAL_PHASES, "Cannot change fees processing functions until IDO launch is completed");
        require(!feesLocked, "Fees settings are locked forever");
        _;
    }


    modifier phasesLock() {
        require(!phasesInitialized, "Phases initialization is locked");
        _;
    }


    //Change name and symbol to Dragon, DRAGON for actual deployment
    constructor()
    ERC20("Test", "TST")
    ERC20Permit("Test")
    Ownable(msg.sender)
    { //This ERC20 constructor creates our DRAGON token name and symbol. 
      //After allowlist and phases initialization the owner will be set to a multisig 2/3 or 3/5, then later to a community run DAO
        farmAddress = msg.sender; //Update to multisig smart contract wallet until farm is ready
        treasuryAddress = msg.sender;  //Update to multisig smart contract wallet
        communityLPFee = 500; //5%
        liquidityFee = 100; //1%
        treasuryFee = 100; //1%
        farmFee = 100; //1%
        totalFees = communityLPFee + liquidityFee + treasuryFee + farmFee;
        require(totalFees == 800, "Total fees must equal 8% at deployment");

        communityTokens = //[0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846]; //FUJI Testnet Chainlink: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846 
                       //Mainnet: 
        [0xab592d197ACc575D16C3346f4EB70C703F308D1E,
        0x420FcA0121DC28039145009570975747295f2329,
        0x184ff13B3EBCB25Be44e860163A5D8391Dd568c1,
        0xb5Cc2CE99B3f98a969DBe458b96a117680AE0fA1,
        0xc06E17bDC3F008F4Ce08D27d364416079289e729,
        0xc8E7fB72B53D08C4f95b93b390ed3f132d03f2D5,
        0x69260B9483F9871ca57f81A90D91E2F96c2Cd11d,
        0x96E1056a8814De39c8c3Cd0176042d6ceCD807d7];    
        //FEED//COQ//KIMBO//LUCKY//DWC//SQRCAT//GGP//OSAK//

        uint256 length_ = communityTokens.length; //Total number of Community Tokens
        require(length_ > 0, "Contract must have at least one community token in rewardsToken array");

        //Choose dex router with best CT/AVAX liquidity for each CT
        ctRouters = //[0xf8e81D47203A594245E36C48e151709F0C19fBe8]; //Fuji Testnet: 0xd7f655E3376cE2D7A2b08fF01Eb3B1023191A901
                       //Mainnet: 
        [0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4,
        0x60aE616a2155Ee3d9A68541Ba4544862310933d4];    //(TraderJoe has best liquidity for each CT LP currently)

        require(ctRouters.length == length_, "Each token in the communityTokens array must have a corresponding router in the ctRouters array");
        IUniswapV2Router02 uniswapV2Router_;
        address uniswapV2Pair_;

        //Set all possible routers to true here, so we can switch between these known contracts later if desired
        approvedRouters[0x60aE616a2155Ee3d9A68541Ba4544862310933d4] = true; //TraderJoe router https://support.traderjoexyz.com/en/articles/6807983-contracts-api
        approvedRouters[0xE54Ca86531e17Ef3616d22Ca28b0D458b6C89106] = true; //Pangolin router https://docs.pangolin.exchange/multichain/avalanche-network/contracts

        for (uint256 i = 0; i < length_; i++){
            uniswapV2Router_ = IUniswapV2Router02(ctRouters[i]);
            uniswapV2Routers.push(uniswapV2Router_);
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Routers[i].factory()).getPair(communityTokens[i], WAVAX);
            require(uniswapV2Pair_ != address(0), "All CT/WAVAX LP Pairs must be created first and have some LP already, to buy CT with AVAX");
        }

        routerLP = 0x60aE616a2155Ee3d9A68541Ba4544862310933d4; //Main Dragon/AVAX LP and DRAGON/CT LP dex router
        //TraderJoe router = C-Chain Mainnet: 0x60aE616a2155Ee3d9A68541Ba4544862310933d4 ; Fuji Testnet: 0xd7f655E3376cE2D7A2b08fF01Eb3B1023191A901
        
        uniswapV2Router_ = IUniswapV2Router02(routerLP);
        uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router_.factory())
            .createPair(address(this), WAVAX); //Initialize DRAGON/WAVAX LP pair, with 0 LP tokens in it to start with

        uniswapV2Router = uniswapV2Router_; //Uses the interface created above
        uniswapV2Pair = uniswapV2Pair_; //Uses the address created above

        //ExcludeFromFees
        isExcludedFromFees[msg.sender] = true; //Owner is excluded from fees
        isExcludedFromFees[address(this)] = true; //This contract is excluded from fees

        super._update(address(0), msg.sender, TOTAL_SUPPLY_WEI); //Mint total supply to LP creator. They will make LP with 100% of supply and burn LP to the DEAD address
        processFeesMinimum = TOTAL_SUPPLY_WEI / 10000; //Must collect 0.01% of supply in fees before can swap, to save user's gas
        emit SettingsChanged(msg.sender, "constructor");
    }



    // Swap And Burn onlyOwner functions:


    function setMainDex(address router_) external onlyOwner feeSettingsLock{ 
    //There is an inherent risk using a third party dex, so we have the ability to change dexs between approved routers
        require(approvedRouters[router_], "Router not approved"); //Only allow approved routers
        routerLP = router_;
        IUniswapV2Router02 uniswapV2Router_ = IUniswapV2Router02(routerLP);
        uniswapV2Router = uniswapV2Router_; //Uses the interface created above
        address uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), WAVAX); //This pair must already exist
        require(uniswapV2Pair_ != address(0), 
        "LP Pair must be created first, paired with WAVAX"); //An invalid LP pair will return 0 address.
        uniswapV2Pair = uniswapV2Pair_; //Set to pair grabbed from the factory call above
        checkCtPairs();
        emit SettingsChanged(msg.sender, "setMainDex");
    }


    function setCommunityTokens(address[] memory addresses_, address[] memory routers_) external onlyOwner feeSettingsLock{ 
    //Set array of community tokens to buy and burn LP for, in case we need to change any.
        uint256 length_ = addresses_.length;
        require(length_ > 0, "Must include at least one community token");
        require(length_ <= 8, "Cannot include more than 8 tokens in the communityTokens array"); //Prevent out of gas errors
        communityTokens = addresses_;
        checkCtPairs();        
        setCtRouters(routers_);
        emit SettingsChanged(msg.sender, "setCommunityTokens");
    }


    function setCtRouters(address[] memory routers_) public onlyOwner feeSettingsLock{ //Can change each dex we buy CT on, to use dex with most LP per CT
        ctRouters = routers_;
        uint256 length_ = communityTokens.length;
        require(ctRouters.length == length_, "Each token in the communityTokens array must have a corresponding router in the ctRouters array");
        address uniswapV2Pair_;
        IUniswapV2Router02 uniswapV2RouterCT_;
        uniswapV2Routers = new IUniswapV2Router02[](length_); //Reset the old array and make size of new length

        for (uint256 i = 0; i < length_; i++){
            require(approvedRouters[routers_[i]], "Router not approved"); //Only allow approved routers
            uniswapV2RouterCT_ = IUniswapV2Router02(routers_[i]);
            uniswapV2Routers[i] = uniswapV2RouterCT_;
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Routers[i].factory()).getPair(communityTokens[i], WAVAX);
            require(uniswapV2Pair_ != address(0), "All CT/WAVAX LP Pairs must be created first on new dex, to buy CT with AVAX");
        }

        emit SettingsChanged(msg.sender, "setCtRouters");
    }


    function setProcessFeesMinimum(uint256 amount_) external onlyOwner feeSettingsLock{ //Set minimum amount of Dragon tokens collected as fees to swap and burn with
        require(amount_ >= TOTAL_SUPPLY_WEI / 1000000000, "Amount too low, cannot be less than 0.0000001% of supply"); 
        require(amount_ <= TOTAL_SUPPLY_WEI / 1000, "Amount too high, cannot be more than 0.1% of supply");
        processFeesMinimum = amount_;
        emit SettingsChanged(msg.sender, "setProcessFeesMinimum");
    }


    function setTreasuryAddress(address treasury_) external onlyOwner feeSettingsLock{ //Set address of treasury multisig
        require(treasury_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[treasury_] = true;  //Add new treasury to fees exclusion list
        isExcludedFromFees[treasuryAddress] = false; //Remove old treasury from fees exclusion list
        treasuryAddress = treasury_;
        emit SettingsChanged(msg.sender, "setTreasuryAddress");
    }


    function setFarmAddress(address farm_) external onlyOwner feeSettingsLock{ //Set address for farm rewards collection
        require(farm_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[farm_] = true; //Add new farm to fees exclusion list
        isExcludedFromFees[farmAddress] = false; //Remove old farm from fees exclusion list
        farmAddress = farm_;
        emit SettingsChanged(msg.sender, "setFarmAddress");
    }


    function excludeFromFees(address account_) external onlyOwner feeSettingsLock{ //Exclude address from transfer fees
        require(!isExcludedFromFees[account_], "Account is already excluded");
        isExcludedFromFees[account_] = true; //Account is now excluded from fees
        emit ExcludeFromFees(account_);
    }


    function includeInFees(address account_) external onlyOwner feeSettingsLock{ //Remove address from excluded list
        require(isExcludedFromFees[account_], "Account is already included");
        require(account_ != address(this), "Cannot include DRAGON contract in fees");
        isExcludedFromFees[account_] = false; //Account is now no longer excluded from fees
        emit IncludeInFees(account_);
    }


    function transferOwnership(address newOwner_) public override onlyOwner {
        require(newOwner_ != address(0), "Cannot set to 0 address");
        isExcludedFromFees[newOwner_] = true; //Add new owner to fees exclusion list
        isExcludedFromFees[owner()] = false; //Remove old owner from fees exclusion list
        super.transferOwnership(newOwner_);
    }


    function setFeesInBasisPts( //Set transfer fees in basis points where 100 = 1%
        uint256 communityLPFee_, 
        uint256 liquidityFee_, 
        uint256 treasuryFee_, 
        uint256 farmFee_
    ) external onlyOwner feeSettingsLock{
        communityLPFee = communityLPFee_; //LP burn fee to be divided over all community tokens
        liquidityFee = liquidityFee_; //LP fee for DRAGON token LP
        treasuryFee = treasuryFee_; //Team treasury fee
        farmFee = farmFee_; //Farm fee 
        totalFees = communityLPFee + liquidityFee + treasuryFee + farmFee; 
        require(totalFees <= 800, "Total fees cannot add up to over 8%");
        emit SettingsChanged(msg.sender, "setFeesInBasisPts");
    }    


    function lockFeeSettings() external onlyOwner { //Lock fees settings
        require(!feesLocked, "Fees settings already locked");
        feesLocked = true;
        emit SettingsChanged(msg.sender, "lockFeeSettings");
    }


    function setPairs() external onlyOwner{
        uint256 length_ = communityTokens.length;
        address uniswapV2Pair_;

        for (uint256 i = 0; i < length_; i++){
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), communityTokens[i]);
            if (!dragonCtPairs[uniswapV2Pair_] && uniswapV2Pair_ != address(0)) {
                dragonCtPairs[uniswapV2Pair_] = true;
            }
        }
        emit SettingsChanged(msg.sender, "setPairs");
    }



    //Internal functions:


    function _update( //Fees added on to all transfers, and phases check
        address from_,
        address to_,
        uint256 amount_
    ) internal override(ERC20) {

        if (amount_ == 0) {
            super._update(from_, to_, 0);
            return;
        }

        if (from_ == address(this)
        || to_ == address(this)
        ) { //Don't limit fees processing or LP creation
            super._update(from_, to_, amount_);
            return;
        }
        
        if (swapping) { //Block users during processFees(), in case of reentrant user calls
            revert("User cannot trade in the middle of internal LP creation. You have created a reentrancy issue");
        }

        beforeTokenTransfer(to_, amount_); //Whale limited and timed phases check
        bool takeFee_ = true; 

        if (tradingPhase() == 0 || isExcludedFromFees[from_] || isExcludedFromFees[to_]) { //Don't charge fees when adding LP before launch
            takeFee_ = false;
        }

        if (takeFee_ && totalFees > 0) { //If any fees, then calculate wei amount of DRAGON fees. 
            uint256 fees_ = (amount_ * totalFees) / 10000; //Fees are represented as basis points where 100 is 1% aka 100/10000
            amount_ = amount_ - fees_;
            super._update(from_, address(this), fees_); //Send 8% transfer fee to this contract
        }

        if (to_ == uniswapV2Pair){ //Only force processFees() on a user's sells (and incidentally LP additions)
            uint256 phase_ = tradingPhase();
            if (phase_ != TOTAL_PHASES && phase_ != 0) { //Only force processFees() during whale limited phases, to keep fees from collecting too much at launch.
                processFees();
            }
        }

        super._update(from_, to_, amount_); //Send the original transfer requested by user, minus fees, after processFees() is checked
    }


    function beforeTokenTransfer(
        address to_,
        uint256 amount_
    ) private {
        uint256 tradingPhase_ = tradingPhase();

        if (tradingPhase_ == TOTAL_PHASES){ //No limits on the last phase
            return;
        }

        if (to_ != uniswapV2Pair && !dragonCtPairs[to_]) { //Do not limit LP creation or selling
            require(allowlisted[to_] <= tradingPhase_, "Not allowlisted for current phase");
            totalPurchased[to_] += amount_; //Total amount user received in whale limited phases
            require(totalPurchased[to_] <= maxWeiPerPhase[tradingPhase_], "Receiving too much for current whale limited phase");
        }
    }


    function swapAndBurnLP(uint256 swapToDRAGONLP_, uint256 swapPerCtLP_) private { //Swap half these DRAGON token and make into LPs
        uint256 ctLength_ = communityTokens.length; //Number of CT token addresses in our list
        uint256 totalDRAGONTokens_ = (swapToDRAGONLP_ + (swapPerCtLP_ * ctLength_)); //Total DRAGON tokens to process here

        if (totalDRAGONTokens_ == 0) {
            return;
        }

        uint256 initialAVAXBalance_ = address(this).balance; //Balance before swap for AVAX, for more accurate calculations later
        uint256 halfDRAGONTokens_ = totalDRAGONTokens_ / 2;
        _approve(address(this), address(uniswapV2Router), totalDRAGONTokens_); //Approve main router to swap our DRAGON tokens and make LP
        swapDRAGONForAVAX(halfDRAGONTokens_); //Swap half the DRAGON tokens to AVAX
        uint256 newAVAXBalance_ = address(this).balance - initialAVAXBalance_; //This is the amount of AVAX received from the swap, (or more if someone sent in extra).

        if (swapToDRAGONLP_ > 0) {
            uint256 dragonLpAVAX_ = (swapToDRAGONLP_  * newAVAXBalance_) / totalDRAGONTokens_; //Calculate ratio and amount of AVAX to be used for DRAGON/WAVAX LP.
            uint256 halfDRAGONForLP_ = swapToDRAGONLP_ / 2; //Calculate DRAGON tokens earmarked for DRAGON/WAVAX LP
            addLiquidityDRAGON(halfDRAGONForLP_, dragonLpAVAX_); //Make LP for DRAGON/WAVAX LP, and burn it
            newAVAXBalance_ -= dragonLpAVAX_; //Calculate remaining AVAX to use for all DRAGON/CT LPs we will make next
            emit SwapAndLiquify(halfDRAGONForLP_, dragonLpAVAX_, WAVAX);
        }

        if (swapPerCtLP_ > 0) {
            uint256 avaxPerCt_ = newAVAXBalance_ / ctLength_; //Calculate AVAX to swap for tokens for CT half of LP pair, divided for each DRAGON/CT LP.
            uint256 dragonPerCtLP_ = swapPerCtLP_ / 2; //Calculate tokens for DRAGON half of LP pair

            for (uint256 i = 0; i < ctLength_; i++){ //Loop for each CT
                uint256 initialCtBalance_ = IERC20(communityTokens[i]).balanceOf(address(this));
                swapAvaxForCT(avaxPerCt_, i);
                uint256 newCtBalance_ = IERC20(communityTokens[i]).balanceOf(address(this)) - initialCtBalance_;
                addLiquidityCT(dragonPerCtLP_, newCtBalance_, communityTokens[i]);
                emit SwapAndLiquify(dragonPerCtLP_, newCtBalance_, communityTokens[i]);
            }
        }
    }


    function swapDRAGONForAVAX(uint256 tokenAmount_) private {
        address[] memory path = new address[](2); //Our swap path DRAGON/WAVAX
        path[0] = address(this); //DRAGON
        path[1] = WAVAX; //WAVAX

        try
        uniswapV2Router.swapExactTokensForAVAXSupportingFeeOnTransferTokens( //DRAGON to AVAX swap on main dex
            tokenAmount_,
            100, //Infinite slippage basically since it's in wei
            path,
            address(this), //Send the AVAX we receive from the swap to this contract
            block.timestamp)
        {}
        catch {
            revert(string("swapDRAGONForAVAX failed"));
        }
    }


    function swapAvaxForCT(uint256 avaxAmount_, uint256 index_) private {
        address[] memory path = new address[](2); //Our swap path WAVAX/CT
        path[0] = WAVAX; //WAVAX
        path[1] = communityTokens[index_]; //CT

        try  
        uniswapV2Routers[index_].swapExactAVAXForTokensSupportingFeeOnTransferTokens //AVAX to CT, swap on dex router with most LP
        {value: avaxAmount_}(
            100, //Infinite slippage basically since it's in wei
            path,
            address(this), //Send CT tokens received to this contract
            block.timestamp)
        {}
        catch {
            revert(string("swapAvaxForCT failed"));
        }
    }


    function addLiquidityDRAGON(uint256 tokenAmount_, uint256 avaxAmount_)  private { //Make and burn LP tokens DRAGON/WAVAX
        try  
        uniswapV2Router.addLiquidityAVAX{value: avaxAmount_}( //Amount of AVAX to send for LP on main dex
            address(this),
            tokenAmount_,
            100, //Infinite slippage basically since it's in wei
            100, //Infinite slippage basically since it's in wei
            DEAD, //Burn LP
            block.timestamp)
        {}
        catch {
            revert(string("addLiquidityDRAGON failed"));
        }
    }


    function addLiquidityCT(uint256 dragonAmount_, uint256 ctAmount_, address ctAddress_)  private {  //Make and burn LP tokens DRAGON/CT or DRAGON/WAVAX on main dex
        IERC20(ctAddress_).approve(address(uniswapV2Router), ctAmount_); //Approve token transfer for router to make LP

        //Add the liquidity
        try  
        uniswapV2Router.addLiquidity(
            address(this), //DRAGON
            ctAddress_, //CT or WAVAX
            dragonAmount_,
            ctAmount_,
            100, //Infinite slippage basically since it's in wei
            100, //Infinite slippage basically since it's in wei
            DEAD, //Burn LP
            block.timestamp)
        {}
        catch {
            revert(string("addLiquidityCT failed"));
        }
    }


    function checkCtPairs() internal view {
        uint256 length_ = communityTokens.length;
        address uniswapV2Pair_;
        for (uint256 i = 0; i < length_; i++){
            uniswapV2Pair_ = IUniswapV2Factory(uniswapV2Router.factory()).getPair(address(this), communityTokens[i]);
            require(uniswapV2Pair_ != address(0), "All CT/DRAGON LP Pairs must be created first on main dex");
        }
    }


    //Public functions:


    function processFees() public {  //Swap DRAGON fees for community tokens, make into LP, and burn LP
        if(tradingPhase() == TOTAL_PHASES){ //If IDO phases are completed, then prevent back to back dumps
            require(block.timestamp >= (lastTimeCalled + SECONDS_PER_PHASE), "Cannot process fees more than once every 8 minutes"); //Prevent back to back fees dumping
            lastTimeCalled = block.timestamp;
        }

        //Multiply first, then divide, using () to order the operations, like (x * y) / z
        uint256 maxProcessFees_ = (balanceOf(uniswapV2Pair) * 8) / 100; //Cannot process fees totalling more than 8% of DRAGON in the LP at once, to reduce price dump
        uint256 contractDRAGONBalance_ = balanceOf(address(this));
        uint256 amountOfFees_; //Amount of fees to process now
        if (contractDRAGONBalance_ < maxProcessFees_){
            amountOfFees_ = contractDRAGONBalance_;
        } else {
            amountOfFees_ = maxProcessFees_;
        }

        bool canSwap_ = amountOfFees_ >= processFeesMinimum; //Must have the minimum amount of fees collected to process them

        if (canSwap_ && !swapping) {
            if (totalFees == 0) {
                super._update(address(this), DEAD, contractDRAGONBalance_); //Burn any remaining fees if not collecting them anymore
                return;
            }
            
            swapping = true; //Reentrancy guard

            //Multiply first, then divide, using () to order the operations, like (x * y) / z
            uint256 swapToCtLP_ = (amountOfFees_ * communityLPFee) / totalFees; //Calculate community tokens LP fee portion
            uint256 swapToDRAGONLP_ = (amountOfFees_ * liquidityFee) / totalFees; //Calculate DRAGON LP fee portion
            uint256 farmTokens_ = (amountOfFees_ * farmFee) / totalFees; //Calculate farm fee portion
            uint256 treasuryTokens_ = (amountOfFees_ * treasuryFee) / totalFees; //Calculate treasury fee portion

            uint256 swapPerCtLP_ =  swapToCtLP_ / communityTokens.length; //Make sure total amount of CT LP is divisible by CT tokens
            uint256 remainder_ = amountOfFees_ - (swapToDRAGONLP_ + farmTokens_ + treasuryTokens_ + (swapPerCtLP_ * communityTokens.length)); //Calculate dust leftover
            swapToDRAGONLP_ += remainder_; //Add dust to DRAGON LP portion

            if (treasuryTokens_ > 0){
                super._update(address(this), treasuryAddress, treasuryTokens_); //Send fees to treasuryAddress
            }

            if (farmTokens_ > 0){
                super._update(address(this), farmAddress, farmTokens_); //Send fees to farm
            }

            swapAndBurnLP(swapToDRAGONLP_, swapPerCtLP_);
            swapping = false; //Reentrancy guard
            uint256 newDRAGONBalance_ = balanceOf(address(this)); //Calculate any dust leftover from CT LP creation
            emit ProcessFees(msg.sender, (contractDRAGONBalance_ - newDRAGONBalance_)); //Amount of DRAGON fees processed minus any dust leftover
        } else {
            if (swapping){
               revert("Cannot process now, already in the middle of processing fees. You have created a reentrancy issue");
            }

            if (!canSwap_ && tradingPhase() == TOTAL_PHASES){ //Don't revert forced fees processing of whale limited phases
               revert("Cannot process yet, more fees need to be collected first");
            }
        }
    }


    function seedAndBurnCtLP(uint256 ctIndex_, address communityToken_, uint256 amountDragon_, uint256 amountCt_) external {
        require(tradingPhase() != TOTAL_PHASES, "Phases are completed already"); //This function is just to seed LP for IDO launch
        require(communityTokens[ctIndex_] == communityToken_, "Token not found in communityTokens array at that index"); //Verify valid CT address
        require(amountDragon_ > 100000000000000000, "Must send at least 0.1 Dragon tokens");
        require(amountCt_ > 100000000000000000, "Must send at least 0.1 Community tokens");
        require(!swapping, "Already making CT LP, you have created a reentrancy issue");
        swapping = true; //Reentrancy block
        transfer(address(this), amountDragon_);
        IERC20(communityToken_).transferFrom(msg.sender, address(this), amountCt_); //User must first approve this contract to spend their CT tokens
        _approve(address(this), address(uniswapV2Router), amountDragon_); //Approve main router to use our DRAGON tokens and make LP
        addLiquidityCT(amountDragon_, amountCt_, communityToken_);
        swapping = false;
        emit SwapAndLiquify(amountDragon_,amountCt_, communityToken_);
    }
    

    function seedAndBurnDragonLP(uint256 amountDragon_, uint256 amountAvax_) external payable {
        require(tradingPhase() != TOTAL_PHASES, "Phases are completed already"); //This function is just to seed LP for IDO launch
        require(msg.value == amountAvax_, "Different amount of Avax sent than indicated in call values"); //Verify intended amount sent
        require(amountDragon_ >= 100000000000000000, "Must send at least 0.1 Dragon tokens");
        require(amountAvax_ >= 100000000000000000, "Must send at least 0.1 AVAX");
        require(!swapping, "Already making Dragon LP, you have created a reentrancy issue");
        swapping = true; //Reentrancy block
        transfer(address(this), amountDragon_);
        _approve(address(this), address(uniswapV2Router), amountDragon_); //Approve main router to use our DRAGON tokens and make LP
        addLiquidityDRAGON(amountDragon_, amountAvax_);
        swapping = false;
        emit SwapAndLiquify(amountDragon_, amountAvax_, WAVAX);
    }


    function tradingActive() public view returns (bool) { //Check if startTime happened yet to open trading
        if (startTime > 0  && phasesInitialized) {
            return block.timestamp >= startTime; //Return true if phases is set and has started
        } else {
            return false;
        }
    }


    function tradingRestricted() public view returns (bool) { //Check if we are in allowlist phases
        return tradingActive() && block.timestamp <= (startTime + (SECONDS_PER_PHASE * (TOTAL_PHASES - 1))); //True if tradingActive, but whale limited phases is not over
    }


    function tradingPhase() public view returns (uint256 phase) { //Check the phase
        if (!tradingActive()) {
            return 0; //0 == No buying
        }

        uint256 secondsPastStart_ = block.timestamp - startTime;
        uint256 phase_ = (secondsPastStart_ / SECONDS_PER_PHASE) + 1; //Count phase periods elapsed to see what phase we are in

        if (phase_ > TOTAL_PHASES) {
            phase_ = TOTAL_PHASES;
        }

        return phase_;
    }



    //Set Phases onlyOwner:


    function setPhasesStartTime(uint256 startTime_) external onlyOwner phasesLock{
        require(startTime_ > 0, "Start time must be greater than 0");
        startTime = startTime_;
        emit SettingsChanged(msg.sender, "setPhasesStartTime");
    }


    function setWhaleLimitsPerPhase(uint256[] memory maxWei_) external onlyOwner phasesLock{
        uint256 length_ = maxWei_.length;
        require(length_ == (TOTAL_PHASES - 1), "You must set maximum wei for every whale limited phase");
        uint256 previousPhaseMaxWei_;
        require(maxWei_[0] > 0, "Whale limit must be greater than 0 wei");
        for (uint256 i = 0; i < length_; i++){
            require(maxWei_[i] >= previousPhaseMaxWei_, "Max amount users can hold must increase or stay the same through the phases.");
            maxWeiPerPhase[i+1] = maxWei_[i]; //Max phase 1 = maxWei_[0] 
            previousPhaseMaxWei_ = maxWei_[i];
        }
        emit SettingsChanged(msg.sender, "setWhaleLimitsPerPhase");
    }


    function lockPhasesSettings() external onlyOwner phasesLock{ //Phases initialization cannot be unlocked after it is locked
        require(startTime >= block.timestamp, "startTime must be set for the future");
        require(maxWeiPerPhase[1] > 0 , "Whale limited phases maxWeiPerPhase must be greater than 0");
        checkCtPairs();
        phasesInitialized = true; //Lock these phases settings
        emit SettingsChanged(msg.sender, "lockPhasesSettings");
    }


    function setAllowlistedForSomePhase(address[] memory users_, uint256 phase_) external onlyOwner {
        require(phase_ <= TOTAL_PHASES, "Phases are already completed");
        uint256 length_ = users_.length;
        require(length_ > 0, "Must include at least one user");
        require(length_ <= 200, "Cannot add more than 200 users in one transaction"); //Prevent out of gas errors  
        for (uint256 i = 0; i < length_; i++) {
            allowlisted[users_[i]] = phase_;
        }
        emit SettingsChanged(msg.sender, "setAllowlistedForSomePhase");
    }



    //Fallback function and generic transfer functions to handle any tokens that come into contract:


    fallback() external payable {}

    receive() external payable {}

    function withdrawAvaxTo(address payable to_, uint256 amount_) external onlyOwner {
        require(to_ != address(0), "Cannot withdraw to 0 address");
        to_.transfer(amount_); //Can only send Avax from our contract, any user's wallet is safe
        emit AvaxWithdraw(to_, amount_);
    }

    function iERC20TransferFrom(address contract_, address to_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        (bool success) = IERC20Token(contract_).transferFrom(address(this), to_, amount_); //Can only transfer from our own contract
        require(success, 'token transfer from sender failed');
        emit TokenWithdraw(to_, amount_, contract_);
    }

    function iERC20Transfer(address contract_, address to_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        (bool success) = IERC20Token(contract_).transfer(to_, amount_); 
        //Since interfaced contract looks at msg.sender then this can only send from our own contract
        require(success, 'token transfer from sender failed');
        emit TokenWithdraw(to_, amount_, contract_);
    }

    function iERC20Approve(address contract_, address spender_, uint256 amount_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC20Token(contract_).approve(spender_, amount_); //Since interfaced contract looks at msg.sender then this can only send from our own contract
        emit TokenApproved(spender_, amount_, contract_);
    }

    function iERC721TransferFrom(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).transferFrom(address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721SafeTransferFrom(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).safeTransferFrom(address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721Transfer(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).transfer( address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function iERC721SafeTransfer(address contract_, address to_, uint256 tokenId_) external onlyOwner {
        noDRAGONTokens(contract_);  //Cannot transfer DRAGON tokens
        IERC721Token(contract_).safeTransfer( address(this), to_, tokenId_); //Can only transfer from our own contract
        emit NFTWithdraw(to_, tokenId_, contract_);
    }

    function noDRAGONTokens(address contract_)  internal view {
        require(contract_ != address(this), "Owner cannot withdraw $DRAGON token fees collected"); //No $DRAGON tokens, as they are earmarked for fees processing
        require(!swapping, "Owner cannot withdraw while fees are processing"); //Reentrancy guard prevents CT tokens being removed during fees processing
    }

}

//"May the dragon's song bring harmony." -Harmony Scales




  //Legal Disclaimer: 
// DragonFire (DRAGON) is a meme coin (also known as a community token) created for entertainment purposes only. 
//It holds no intrinsic value and should not be viewed as an investment opportunity or a financial instrument.
//It is not a security, as it promises no financial returns to buyers, and does not rely solely on the efforts of the creators and developers.

// There is no formal development team behind DRAGON, and it lacks a structured roadmap. 
//Users should understand that the project is experimental and may undergo changes or discontinuation without prior notice.

// DRAGON serves as a platform for the community to engage in activities such as liquidity provision and token swapping on the Avalanche blockchain. 
//It aims to foster community engagement and collaboration, allowing users to participate in activities that may impact the value of their respective tokens.

// It's important to note that the value of DRAGON and associated community tokens may be subject to significant volatility and speculative trading. 
//Users should exercise caution and conduct their own research before engaging with DRAGON or related activities.

// Participation in DRAGON-related activities should not be solely reliant on the actions or guidance of developers. 
//Users are encouraged to take personal responsibility for their involvement and decisions within the DRAGON ecosystem.

// By interacting with DRAGON or participating in its associated activities, 
//users acknowledge and accept the inherent risks involved and agree to hold harmless the creators and developers of DRAGON from any liabilities or losses incurred.




/*
   Launch instructions:
Set values in the constructor, and constant values at the start of the contract.
Deploy contract with solidity version: 0.8.24, EVM version: Paris, and runs optimized: 200.
Verify contract.
Add all dragon tokens as LP using the functions in the contract during Phase 0, so all 8 tokens have starter LP DRAGON/CT, then run setPairs() to save the pairs.
All DRAGON tokens are now in LP, there are no initial team tokens or other initial distributions.
Initialize phases startTime for some future time, set whale limits per phase, and finally ***lock phases***.
Set allowlists that we have so far for each phase.
Set socials on block explorer and dexscreener.
Transfer contract ownership to multisig, requiring multiple signatures per transaction, where each signer is a unique person and wallet and device.
Release medium article showing tokenomics, audit report, DEXs, LP burnt, contract address, farm collection address, treasury address, and multisig signer addresses.
IDO launch after marketing and bonus allowlist gathered and input.
Later, transfer contract ownership to a community run and owned DAO, possibly with 48hr timelocks in effect, which might use the OpenZeppelin Defender voting system.
Bug bounty could be good to set up on https://www.sherlock.xyz/ or https://code4rena.com/ or similar.
Optional future upgrade of processFees() to external contract that might implement slippage protections, V4 LP, or other features.
*/
