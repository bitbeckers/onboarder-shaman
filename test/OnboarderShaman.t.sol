// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { OnboarderShaman } from "../src/OnboarderShaman.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract OnboarderShamanTest is PRBTest, StdCheats {
    OnboarderShaman internal onboarderShaman;

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        // Instantiate the contract-under-test.
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
    function testFork_Example() external {
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
        address _baal = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        address payable _token = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        uint256 _pricePerUnit = 1e18;
        bool _onlyERC20 = true;
        uint256 _platformFee = 0;
        uint256 _lootPerUnit = 0;

        vm.createSelectFork({ urlOrAlias: "goerli", blockNumber: 16_428_000 });

        assertEq(actualBalance, expectedBalance);
    }
}
