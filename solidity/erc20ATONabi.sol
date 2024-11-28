/**
 * This file was automatically generated by Stylus and represents a Rust program.
 * For more information, please see [The Stylus SDK](https://github.com/OffchainLabs/stylus-sdk-rs).
 */

// SPDX-License-Identifier: MIT-OR-APACHE-2.0
pragma solidity ^0.8.23;

interface IErc20 {
    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    error InsufficientBalance(address, uint256, uint256);

    error InsufficientAllowance(address, address, uint256, uint256);
}

interface IOwnable {
    function owner() external view returns (address);

    function transferOwnership(address new_owner) external;

    function renounceOwnership() external;

    error OwnableUnauthorizedAccount(address);

    error OwnableInvalidOwner(address);
}

interface IAccessControl {
    function hasRole(bytes32 role, address account) external view returns (bool);

    function onlyRole(bytes32 role) external view;

    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    function grantRole(bytes32 role, address account) external;

    function revokeRole(bytes32 role, address account) external;

    function renounceRole(bytes32 role, address confirmation) external;

    error AccessControlUnauthorizedAccount(address, bytes32);

    error AccessControlBadConfirmation();
}

interface IATON is IErc20, IOwnable, IAccessControl {
    function donateAton() external;

    function stakeEth(address _player) external;

    function stakeAton(address _player, uint256 _amount) external;

    function swap(uint256 amount) external;

    error ZeroEther(address);
}
