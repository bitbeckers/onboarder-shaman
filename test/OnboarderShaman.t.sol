// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { IBaal } from "@daohaus/baal-contracts/contracts/interfaces/IBaal.sol";

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { OnboarderShaman } from "../src/OnboarderShaman.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract OnboarderShamanTest is PRBTest, StdCheats {
    OnboarderShaman internal onboarderShaman;
    address internal molochDAO = vm.addr(666);

    ERC20 internal sharesToken = new ERC20("Share", "SHR");
    ERC20 internal lootToken = new ERC20("Loot", "LOOT");

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        vm.mockCall(molochDAO, abi.encodeWithSelector(IBaal.sharesToken.selector), abi.encode(sharesToken));
        vm.mockCall(molochDAO, abi.encodeWithSelector(IBaal.lootToken.selector), abi.encode(lootToken));
        vm.mockCall(molochDAO, abi.encodeWithSelector(IBaal.target.selector), abi.encode(sharesToken));

        onboarderShaman = new OnboarderShaman();
    }

    function testInit() external {
        //     // Otherwise, run the test against the mainnet fork.
        //     // address _baal,
        //     // address payable _token, // use wraper for native yeets
        //     // uint256 _pricePerUnit,
        //     // bool _onlyERC20,
        //     // uint256 _platformFee,
        //     // uint256 _lootPerUnit
        address _baal = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        address _token = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        uint256 _pricePerUnit = 1e18;
        bool _onlyERC20 = true;
        uint256 _platformFee = 0;
        uint256 _lootPerUnit = 0;

        onboarderShaman.init(_baal, payable(_token), _pricePerUnit, _onlyERC20, _platformFee, _lootPerUnit);
    }

    /// @dev Fork test that runs against an Ethereum Mainnet fork. For this to work, you need to set `API_KEY_ALCHEMY`
    /// in your environment You can get an API key for free at https://alchemy.com.
    function testFork() external {
        // Silently pass this test if there is no API key.
        string memory alchemyApiKey = vm.envOr("API_KEY_ALCHEMY", string(""));
        if (bytes(alchemyApiKey).length == 0) {
            return;
        }

        // Otherwise, run the test against the mainnet fork.
        // address _baal,
        // address payable _token, // use wraper for native yeets
        // uint256 _pricePerUnit,
        // bool _onlyERC20,
        // uint256 _platformFee,
        // uint256 _lootPerUnit
        address _baal = 0x23e399FDa8Fddc1846fF20d46007E189282D2e4c;
        address _token = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        uint256 _pricePerUnit = 1e18;
        bool _onlyERC20 = true;
        uint256 _platformFee = 0;
        uint256 _lootPerUnit = 0;

        vm.createSelectFork({ urlOrAlias: "goerli", blockNumber: 9_249_414 });

        OnboarderShaman _shaman = new OnboarderShaman();

        _shaman.init(_baal, payable(_token), _pricePerUnit, _onlyERC20, _platformFee, _lootPerUnit);

        assertEq(address(_shaman.baal()), _baal);
        assertEq(address(_shaman.token()), _token);
        assertEq(_shaman.pricePerUnit(), _pricePerUnit);
        assertEq(_shaman.onlyERC20(), _onlyERC20);
        assertEq(_shaman.platformFee(), _platformFee);

        startHoax(0x23e399FDa8Fddc1846fF20d46007E189282D2e4c);
        IBaal _DAO = IBaal(_baal);
        address[] memory _shamans = new address[](1);
        _shamans[0] = address(_shaman);

        uint256[] memory _permissions = new uint256[](1);
        _permissions[0] = 7;

        _DAO.setShamans(_shamans, _permissions);
        _DAO.shamans(address(_shaman));
    }
}
