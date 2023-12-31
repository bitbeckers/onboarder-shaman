// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19;

import { OnboarderShaman, OnboarderShamanSummoner } from "../src/OnboarderShaman.sol";

import { BaseScript } from "./Base.s.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcaster returns (OnboarderShaman shaman, OnboarderShamanSummoner summoner) {
        shaman = new OnboarderShaman();
        summoner = new OnboarderShamanSummoner(payable(shaman));
    }
}
