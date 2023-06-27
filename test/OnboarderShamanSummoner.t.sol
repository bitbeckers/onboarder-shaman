// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { OnboarderShamanSummoner, OnboarderShaman } from "../src/OnboarderShaman.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract OnboarderShamanSummonerTest is PRBTest, StdCheats {
    OnboarderShaman internal shaman;
    OnboarderShamanSummoner internal summoner;
    address internal molochDAO = vm.addr(666);

    event SummonOnbShamanoarderComplete(
        address indexed baal, address onboarder, address wrapper, uint256 pricePerUnit, string details, bool _onlyERC20
    );

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        // Instantiate the contract-under-test.
        shaman = new OnboarderShaman();
        shaman.initTemplate();
        summoner = new OnboarderShamanSummoner(payable(shaman));
    }

    function testSummon() external {
        //     // Otherwise, run the test against the mainnet fork.
        //     // address _baal,
        //     // address payable _token, // use wraper for native yeets
        //     // uint256 _pricePerUnit,
        //     // bool _onlyERC20,
        //     // uint256 _platformFee,
        //     // uint256 _lootPerUnit
        address _baal = 0x23e399FDa8Fddc1846fF20d46007E189282D2e4c;
        address _token = 0xc5DBEdBcA01391fc60512f83185d5D536Ca08A28;
        uint256 _pricePerUnit = 1e18;
        bool _onlyERC20 = true;
        uint256 _platformFee = 0;
        uint256 _lootPerUnit = 0;

        OnboarderShaman _shaman = OnboarderShaman(
            payable(
                summoner.summonOnboarder(
                    _baal, payable(_token), _pricePerUnit, "test", _onlyERC20, _platformFee, _lootPerUnit
                )
            )
        );

        assertEq(address(_shaman.baal()), _baal);
        assertEq(address(_shaman.token()), _token);
        assertEq(_shaman.pricePerUnit(), _pricePerUnit);
        assertEq(_shaman.onlyERC20(), _onlyERC20);
        assertEq(_shaman.platformFee(), _platformFee);
    }
}
