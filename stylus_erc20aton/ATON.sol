/**
 * This file was automatically generated by Stylus and represents a Rust program.
 * For more information, please see [The Stylus SDK](https://github.com/OffchainLabs/stylus-sdk-rs).
 */

// SPDX-License-Identifier: MIT-OR-APACHE-2.0
pragma solidity ^0.8.23;

interface IErc20  {
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

interface IOwnable  {
    function owner() external view returns (address);

    function transferOwnership(address new_owner) external;

    error OwnableUnauthorizedAccount(address);

    error OwnableInvalidOwner(address);
}

interface IAccessControl  {
    function hasRole(bytes32 role, address account) external view returns (bool);

    function onlyRole(bytes32 role) external view;

    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    function grantArenatonRole(address account) external;

    function revokeArenatonRole(address account) external;

    error AccessControlUnauthorizedAccount(address, bytes32);

    error AccessControlBadConfirmation();
}

interface IATON is IErc20, IOwnable, IAccessControl  {
    function initializeContract() external returns (bool);//one time, instead of constructor

    function donateEth() external payable returns (bool);

    function accumulateAton(uint256 amount) external returns (bool);

    function mintAtonFromEth() external payable returns (bool);// Only arenaton_engine

    function swap(uint256 amount) external returns (bool);

    function summary() external returns (uint256, uint256, uint256);

    error ZeroEther(address);

    error ZeroAton(address);

    error AlreadyInitialized();
}


     Running `target/x86_64-unknown-linux-gnu/debug/stylus-arenaton`
/**
 * This file was automatically generated by Stylus and represents a Rust program.
 * For more information, please see [The Stylus SDK](https://github.com/OffchainLabs/stylus-sdk-rs).
 */

// SPDX-License-Identifier: MIT-OR-APACHE-2.0
pragma solidity ^0.8.23;



interface IAccessControl  {
    function hasRole(bytes32 role, address account) external view returns (bool);

    function onlyRole(bytes32 role) external view;

    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    function grantArenatonRole(address account) external;

    function revokeArenatonRole(address account) external;

    error AccessControlUnauthorizedAccount(address, bytes32);

    error AccessControlBadConfirmation();
}

interface IArenatonEngine is IOwnable, IAccessControl  {
    function addEvent(string calldata event_id, uint256 start_date, uint8 sport) external returns (bool);// only Oracle

    function stakeAton(string calldata _event_id, uint256 _amount_aton, uint8 _team) external returns (bool);

    function stakeEth(string calldata _event_id, uint8 _team) external returns (bool);

    function closeEvent(string calldata _event_id, uint8 _winner) external returns (bool);// only Oracle

    function payEvent(string calldata _event_id, uint128 _batch_size) external returns (bool);// only Oracle

    function getEvent(string calldata _event_id) external view returns (bool);

    function getEventList() external view returns (bool);

    function getPlayerEventList(address _player) external view returns (bool);

    error ZeroEther(address);

    error ZeroAton(address);

    error AlreadyInitialized();
}

# Arenaton: Revolutionizing Sports Betting with Blockchain Technology

## Table of Contents

1. Executive Summary
2. Introduction to Arenaton
3. The Problem with Traditional Sports Betting
4. Arenaton's Solution
   1. Parimutuel Betting System
   2. ATON Tokens
   3. Commission Distribution
   4. Gasless Staking // Taking advantage of Stylus, Syndycate.io and Permit Estandard on ATON
5. How Arenaton Works
   1. Staking on Events
   2. Dynamic Odds and Payouts
   3. Commission Accumulation and Distribution
6. Game Mechanics and User Experience

8. Tokenomics
   1. ATON Token Overview
   2. Token Distribution
   3. Token Utility
   4. Token Flow and Economic Model
   5. Staking and Rewards
   6. Governance (if applicable)
9. Technical Architecture
   1. Smart Contract Overview
   2. Key Functions and Features
   3. Security Measures
10. Advantages of Arenaton's System
11. Roadmap and Future Developments
12. Team and Advisors
13. Conclusion
14. Legal Disclaimer

## 1. Executive Summary

Arenaton is a revolutionary parimutuel sports betting platform built on the Arbitrum blockchain and powerred btyt the RUST powerde Stylus EVM technology of Offchains lab, designed to transform the sports betting landscape. Our platform offers a more transparent, fair, and engaging experience for all participants by leveraging cutting-edge blockchain technology.

Key features of Arenaton include:

- A parimutuel betting system with dynamic odds
- ATON tokens pegged 1:1 with ETH for seamless transactions
- Innovative commission distribution mechanism rewarding all token holders
- Transparent and verifiable betting processes
- Gasless staking options for enhanced user experience

By eliminating centralized bookmakers, ensuring fair odds, and creating a community-driven ecosystem, Arenaton addresses longstanding issues in traditional sports betting. Our platform allows all participants to benefit from its success, fostering a more equitable and exciting betting environment.

## 2. Introduction to Arenaton

In the rapidly evolving world of blockchain technology and decentralized finance, Arenaton emerges as a groundbreaking solution to revolutionize the sports betting industry. Built on the high-performance Arbitrum chain, our platform combines the transparency and security of blockchain with the excitement of sports betting.

Arenaton's core mission is to democratize sports betting by:

1. Eliminating the need for centralized bookmakers
2. Providing a fair and transparent betting environment
3. Rewarding active participation and token holding
4. Leveraging Blockchain technology to ensure trust and security

Our parimutuel betting system, powered by smart contracts, creates a dynamic and engaging platform where odds are determined by collective user activity rather than arbitrary decisions. This approach not only ensures fairness but also fosters a sense of community among users, as every bet contributes to the overall ecosystem.

By addressing the challenges faced by traditional sports betting platforms – such as lack of transparency, unfair odds, high fees, limited user benefits, trust issues, and geographical restrictions – Arenaton aims to create a more equitable, transparent, and engaging betting experience for users worldwide.

Through innovative features like our ATON tokens, commission distribution mechanism,  Arenaton is poised to redefine the future of sports betting, making it more accessible, fair, and rewarding for all participants.

## 3. The Problem with Traditional Sports Betting

Traditional sports betting faces several challenges that have long plagued the industry:

1. Lack of Transparency: Centralized bookmakers often operate with opaque systems, making it difficult for bettors to understand how odds are calculated and winnings are distributed.

2. Unfair Odds: Bookmakers typically set odds to ensure their own profit, often at the expense of bettors. This can lead to situations where the house always has an edge, regardless of the event's outcome.

3. High Fees and Commissions: Traditional betting platforms often charge high fees, eating into users' potential winnings and discouraging participation.

4. Limited User Benefits: Most betting platforms do not offer additional benefits to users beyond potential winnings from individual bets.

5. Trust Issues: Centralized platforms are susceptible to manipulation, hacks, and mismanagement, eroding user trust over time.

6. Geographical Restrictions: Many betting platforms are limited by geographical boundaries and regulations, restricting access for potential users worldwide.

Arenaton addresses these issues head-on, leveraging Blockchain technology and innovative tokenomics to create a more equitable, transparent, and engaging betting experience.

## 4. Arenaton's Solution

### 4.1 Parimutuel Betting System

Arenaton employs a parimutuel betting system, where all bets are pooled together, and the final odds are determined by the collective betting activity of all participants. This system ensures:

- Fair Odds: Odds are not set by bookmakers but are a direct reflection of betting patterns.
- Transparency: All bets and odds are recorded on the Blockchain, visible to all participants.
- Community-Driven: The betting community itself shapes the odds and potential payouts.

### 4.2 ATON Tokens

ATON tokens are the lifeblood of the Arenaton ecosystem:

- 1:1 Peg with ETH: ATON tokens maintain a 1:1 peg with ETH, ensuring stability and ease of use.
- Seamless Transactions: Users can stake, bet, and claim winnings using ATON tokens.
- Incentive Mechanism: Holding ATON tokens allows users to participate in the platform's success through commission distribution.

### 4.3 Commission Distribution

Arenaton introduces an innovative commission distribution model:

- 2% Commission: A 2% commission is collected from all stakes.
- 100% Distribution: The entire commission is distributed among ATON token holders.
- Automatic and Transparent: Commission distribution is handled by smart contracts, ensuring fairness and transparency.

## 5. How Arenaton Works

### 5.1 Staking on Events

1. Event Creation: Authorized addresses can create new events, specifying the event ID, start date, and sport.
2. Staking: Users can stake ETH or ATON tokens on specific events by providing the event ID, amount, and chosen team.
3. Token Conversion: Staked ETH is automatically converted to ATON tokens at a 1:1 ratio.
4. Gasless Options: Users can stake ATON tokens gaslessly.

### 5.2 Dynamic Odds and Payouts

1. Real-Time Odds: The odds for each outcome are calculated dynamically based on the total amount staked on each team.
2. Event Closure: After an event concludes, the platform determines the winning team.
3. Payout Calculation: Winnings are calculated based on the user's stake and the final odds.
4. Distribution: Winners receive their share of the total stakes in ATON tokens.
5. Single Staker Rule: If only one player has staked on an event, they receive the entire pool regardless of the outcome.

### 5.3 Commission Accumulation and Distribution

1. Commission Collection: A 2% commission is deducted from the total stakes of each event.
2. Accumulation: Commissions are accumulated in ATON tokens within the platform's contract.
3. Per-Token Calculation: The system calculates the commission per token by dividing the total accumulated commission by the total ATON supply.
4. Distribution: During transactions involving ATON tokens, the platform calculates and distributes unclaimed commissions to users based on their token holdings.

## 6. Game Mechanics and User Experience

1. Event Selection: Users can browse available events, filtered by sport and status (open, closed, paid).
2. Staking Interface: An intuitive interface allows users to easily stake on their chosen outcomes.
3. Dynamic Odds Display: Real-time odds are displayed, updating as stakes are placed.
4. Event Tracking: Users can track their active bets and view the status of events they've participated in.
5. Claim Process: After event conclusion, winners can easily claim their winnings through the platform.
6. Commission Dashboard: Users can view their accumulated commissions and claim them during transactions.


## 8. Tokenomics

### 8.1 ATON Token Overview

ATON tokens are the lifeblood of the Arenaton ecosystem, meticulously designed to facilitate seamless transactions, incentivize platform participation, and ensure a fair and transparent betting environment.
Key characteristics include:

ERC20 compliant token built on the high-performance Arbitrum blockchain
1:1 peg with ETH, ensuring stability, liquidity, and ease of use
Dynamic total supply that adapts to platform activity and user engagement
Smart contract-driven issuance and distribution, guaranteeing transparency and fairness

### 8.2 Token Distribution and Acquisition

Arenaton employs a unique, user-centric token distribution model:

Primary Acquisition: The primary method to acquire ATON tokens is through staking ETH on the platform. This creates a direct link between platform participation and token acquisition.
Secondary Acquisition: Users can earn additional ATON tokens by winning or drawing in any sports event on the platform.
No Pre-mine or Initial Coin Offering (ICO): Unlike many crypto projects, ATON tokens are not pre-mined or sold in an ICO, ensuring a fair start for all participants.
Organic Growth: While ATON maintains a 1:1 peg with ETH, the total value locked in the Arenaton ecosystem is designed to grow over time due to the innovative commission sharing model.

### 8.3 Token Utility

ATON tokens serve as the backbone of the Arenaton ecosystem, offering multiple utilities:

Staking: Users stake ATON tokens on sports events, contributing to the parimutuel pool and shaping odds.
Betting: All bets are placed and settled exclusively in ATON tokens, streamlining the betting process.
Claiming Winnings: Event winners receive their payouts in ATON tokens, which can be reinvested or swapped for ETH.
Earning Commissions: ATON token holders receive a proportional share of the platform's commission, creating a passive income stream.
Platform Fees: Any platform fees or charges are paid in ATON, further driving token utility.
Future Governance: As the platform evolves, ATON tokens may be used for governance decisions, allowing token holders to shape the future of Arenaton.

### 8.4 Token Flow and Economic Model

The ATON token ecosystem is designed to create a self-sustaining, circular economy:

#### **Minting**

ATON tokens are minted on-demand when users stake ETH, maintaining a strict 1:1 ratio.
This dynamic minting process ensures that token supply always matches platform activity.

#### Circulation

Tokens actively circulate within the platform for betting, staking, and commission distribution.
The parimutuel betting system ensures constant token movement and liquidity.

#### Burning

ATON tokens are effectively burned when users choose to swap them back to ETH.
This burning mechanism helps maintain the token's value and peg to ETH.

#### Commission Distribution

A 2% commission is collected from all stakes on the platform.
100% of this commission is distributed to ATON token holders proportionally.
This creates a sustainable economic model that rewards both active participation and long-term holding.

### 8.5 Staking and Rewards

Arenaton's staking and reward system is designed to incentivize user participation and long-term engagement:

#### Staking Mechanism

Users can stake ATON tokens on any available sports event.
Staked tokens contribute to the parimutuel pool, directly influencing odds.
The minimum stake is set low to encourage broad participation.

#### Commission Rewards

ATON holders receive a proportional share of the 2% commission collected from all stakes.
Reward distribution is based on the amount of ATON held and the duration of holding.
This system encourages users to maintain their ATON holdings for maximum benefits.

#### Real-time Accumulation and Distribution

Commissions are accumulated in real-time as bets are placed.
Smart contracts automatically calculate and distribute rewards during token transfers or specific claim actions.
This continuous distribution model provides immediate benefits to token holders.

#### Compound Growth Potential

Users can reinvest their commission rewards into new bets or increase their ATON holdings.
This creates a potential compound growth effect for engaged users.

### 8.6 Economic Sustainability and Growth

The Arenaton tokenomics model is designed for long-term sustainability and growth:

Self-Regulating Supply: The 1:1 peg with ETH and on-demand minting/burning ensure that token supply always matches genuine platform demand.
Value Accrual: As the platform grows in popularity, the total commission pool increases, potentially driving up the value of ATON tokens.
Network Effects: The unique commission sharing model incentivizes users to promote the platform, creating organic growth.
Liquidity Assurance: The constant 1:1 peg with ETH ensures that ATON tokens remain liquid and easily exchangeable.
Deflation Mechanism: The ETH stored in the smart contract from staking accrues value due to trading fees in Layer 1, potentially making each ATON token more valuable over time.

By combining these tokenomic elements, Arenaton creates a robust, user-centric ecosystem that aligns the interests of all participants, from casual bettors to long-term token holders, fostering a thriving and sustainable platform.

### 8.7 Community-Driven Growth: The donateATON Feature

Arenaton introduces an innovative feature called donateATON, designed to foster community engagement and contribute to the ecosystem's overall growth. This unique mechanism allows for the distribution of ATON tokens to the entire ecosystem during special events, further enhancing the platform's collaborative and rewarding nature.

Key aspects of the donateATON feature include:

- Special Event Distributions:
    During predetermined special events, ATON tokens can be donated to the entire ecosystem.
    These events could be tied to significant milestones, holidays, or major sporting events.
- Ecosystem-Wide Benefits:
    Unlike traditional reward systems that benefit only a select few, donateATON ensures that all participants in the Arenaton ecosystem can potentially benefit.
    This approach reinforces the community-centric ethos of the platform.
- Increased Liquidity and Engagement:
    The distribution of ATON tokens across the ecosystem can lead to increased liquidity and user engagement.
    Recipients may be more likely to participate in betting activities or hold their tokens, contributing to the platform's overall health.
- Community Building:
    The donateATON feature creates a sense of shared success and community spirit among Arenaton users.
    It can serve as a powerful tool for user retention and attraction of new participants.
- Transparent and Fair Distribution:
    The distribution mechanism is governed by smart contracts, ensuring a fair and transparent process.
    Criteria for distribution can be clearly defined and publicly viewable, maintaining the platform's commitment to transparency.
- Potential for Gamification:
    Special events featuring donateATON could be gamified, adding an extra layer of excitement and engagement to the platform.
    This could include challenges, achievements, or other interactive elements that culminate in a donateATON event.
- Ecosystem Sustainability:
    By periodically injecting ATON tokens back into the broader user base, the donateATON feature helps in maintaining a healthy circulation of tokens.
    This can potentially lead to more balanced token distribution over time.

The donateATON feature exemplifies Arenaton's commitment to creating a truly community-driven betting platform. By allowing for ecosystem-wide token distributions during special events, Arenaton not only rewards its users but also  strengthens the bonds within its community. This innovative approach to token distribution aligns perfectly with the platform's goals of fairness, engagement, and shared success, setting Arenaton apart in the competitive landscape of blockchain-based betting platforms.

## 9. Technical Architecture

### 9.1 Smart Contract Overview

Arenaton's core functionality is implemented in a Solidity smart contract deployed on the Arbitrum chain. The contract inherits from OpenZeppelin's ERC20 and ReentrancyGuard contracts, ensuring standard token functionality and protection against reentrancy attacks. The smart contract is designed to handle events, stakes, commission sharing, and donations efficiently and securely.

### 9.2 Key Components and Features

#### 9.2.1 Events Management
We have a main ERC20 token called ATON, with enhanced cappabilities for role maging Arenaton Engines and comission distributions

and a second Contract called `ArenatonEngine` that allows for events magnagein and staking

All ETH is hold always on ATON contract

The contract provides robust functionality for managing sports betting events:

- `addEvent`

Allows authorized addresses to create new events.
Parameters include event ID, start date, and sport type.
Ensures events are created with valid parameters and timing.

- `closeEvent`

Closes an event and determines the winner.
Triggers commission accumulation for events with multiple participants.

- `payEvent`

Processes payouts for closed events in batches.
Handles different scenarios including single-player events and events with multiple participants.
Calculates and distributes winnings based on the parimutuel system.

- Event Tracking

Maintains lists of active and closed events for efficient querying.
Provides functions to retrieve event details and list events based on various criteria.

#### 9.2.2 Staking Mechanism

The staking system is central to Arenaton's betting platform:

#### stake function

Allows users to stake ETH or ATON tokens on specific events.
Supports both regular and gasless staking options.
Automatically converts ETH to ATON at a 1:1 ratio when staking with ETH.

#### Internal staking logic

Validates event status and parameters before accepting stakes.
Updates event totals and player stakes.
Handles cases where a player is staking on an event for the first time or adding to an existing stake.

#### Dynamic Odds

Odds are calculated in real-time based on the total amounts staked on each outcome.
Ensures fair and transparent odds for all participants.

### 9.2.3 Commission Sharing Model

Arenaton's innovative commission sharing model is implemented through several key functions:

#### _accumulateCommission

Accumulates commission from events with multiple participants.
Calculates the commission per token and updates the total commission in ATON.

#### _distributeCommission

Distributes accumulated commission to token holders based on their ATON holdings.
Ensures fair and proportional distribution of commissions.

#### _playerCommission

Calculates the unclaimed commission for a specific player.
Takes into account the player's token balance and the accumulated commission since their last claim.

#### Commission Distribution in Transfers

The transfer function is overridden to include commission distribution.

_distributeTransfer handles the transfer of tokens while ensuring commission is distributed to both sender and recipient.

### 9.2.4 donateATON Feature

The donateATON feature allows users to contribute to the ecosystem:

#### donateATON function

Enables players to donate ATON tokens to the contract.
The donated amount is added to the total commission, benefiting all token holders.

#### Integration with Commission System

Donated ATON tokens are immediately accumulated into the commission pool.
This increases the overall rewards available to all ATON token holders.

#### Community Building

Encourages community participation and investment in the platform's success.
Provides a mechanism for users to contribute to the ecosystem beyond regular betting activities.

### 9.3 Additional Features

Swap Functionality:

swap function allows users to exchange ATON tokens for ETH at a 1:1 ratio.
Ensures liquidity and easy exit for users when needed.

#### Querying Functions

playerSummary: Retrieves comprehensive data about players, including balances and commission information.
getEventDTO: Fetches detailed information about specific events.
getArenatonEvents: Provides filtered lists of events based on various criteria.

#### Security Measures

Utilizes OpenZeppelin's ReentrancyGuard to prevent reentrancy attacks.
Implements access control through onlyOwner and onlyAuthorized modifiers.
Employs safe math operations to prevent overflows and underflows.

### 9.4 Architectural Benefits

Scalability: Deployed on Arbitrum, allowing for high throughput and low transaction costs.
Transparency: All key operations are recorded on the blockchain, ensuring full transparency.
Fairness: The parimutuel system and commission sharing model create a fair environment for all participants.
Flexibility: The architecture allows for easy addition of new features and event types in the future.

This technical architecture forms the backbone of Arenaton, enabling a secure, transparent, and efficient sports betting platform that aligns the interests of all participants through its innovative tokenomics and commission sharing model.

## 10. Token Economics

ATON Token Characteristics:

- ERC20 compliant
- 1:1 peg with ETH
- Total supply: Dynamic, based on ETH staked and minted ATON
- Use cases: Staking, betting, claiming winnings, earning commissions

Token Flow:

1. Minting: ATON tokens are minted when users stake ETH.
2. Circulation: Tokens circulate within the platform for betting and commission distribution.
3. Burning: ATON tokens are effectively burned when swapped back to ETH.

## 11. Advantages of Arenaton's System

1. Fairness and Transparency: Ensures equal chances for all players based on their stakes, with dynamic odds providing real-time transparency.
2. Incentive to Stake Early: Early staking can benefit from more favorable odds, creating excitement and engagement.
3. Community Engagement: Pools stakes and distributes rewards based on the final outcome, encouraging participation and community growth.
4. No Fixed Odds: Dynamic odds based on total stakes prevent manipulation, ensuring a fair and competitive environment.
5. Shared Success: Commission distribution ensures all ATON holders benefit from the platform's success, creating a positive feedback loop.
6. Reduced Risk of Loss: Spreading risk across all participants reduces the likelihood of significant losses due to unfavorable fixed odds.

## 12. Roadmap and Future Developments

Potential future developments could include:

- Integration with more sports and events
- Enhanced user interface and mobile app development
- Cross-chain compatibility
- Implementation of governance features for community-driven decision making
- Partnerships with sports organizations and media outlets

## 13. Conclusion

Arenaton stands at the forefront of a revolution in sports betting, harnessing the power of blockchain technology to create an ecosystem that is unparalleled in its transparency, fairness, and user engagement. By directly addressing the entrenched issues plaguing traditional betting systems, Arenaton is not just improving the industry—it's redefining it.
Our platform's innovative features, including:

- Dynamic odds driven by collective user activity
- A unique commission distribution model that rewards all participants
- Integration with social platforms 
- The groundbreaking donateATON feature fostering ecosystem-wide growth

These elements combine to create a betting experience that is more than just a game of chance—it's a community-driven, economically rewarding ecosystem where every participant has a stake in the platform's success.
Arenaton's commitment to fairness and transparency isn't just a selling point—it's the foundation of our entire system. By leveraging blockchain technology, we ensure that every transaction, every bet, and every payout is verifiable and immutable. This level of transparency builds trust and fosters a sense of true ownership among our users.
As we look to the future, Arenaton is poised to expand beyond sports betting, potentially revolutionizing how people interact with prediction markets and decentralized finance as a whole. Our roadmap includes integrations with more sports and events, enhanced mobile experiences, and the implementation of governance features that will further empower our community.
We invite you to join us in this journey to reshape the landscape of sports betting and beyond. With Arenaton, we're not just predicting the future of betting—we're creating it. In this new paradigm, every stake strengthens the ecosystem, every participant shares in the success, and every interaction contributes to a more equitable and exciting digital economy.
Welcome to Arenaton—where your engagement shapes the odds, your participation drives innovation, and your stake truly counts. Together, let's bet on a fairer future.

## 14. Legal Disclaimer

This white paper is for informational purposes only and does not constitute an offer or solicitation to sell shares or securities in Arenaton or any related or associated company. Any such offer or solicitation would only be made by a confidential offering memorandum and in accordance with applicable securities and other laws.
The information presented in this white paper is subject to change, and while we strive to ensure the accuracy of the information presented, Arenaton makes no representations or warranties, express or implied, regarding the accuracy, completeness, or reliability of the information contained herein.
Arenaton tokens (ATON) are utility tokens and are not intended to constitute securities in any jurisdiction. This white paper does not constitute a prospectus or offer document of any sort and is not intended to constitute an offer of securities or a solicitation for investment in securities in any jurisdiction.
Participation in sports betting and cryptocurrency trading involves risk, and participants should conduct their own due diligence and consult with financial and legal advisors before making any investment decisions. Arenaton is not responsible for any loss of funds or other damages resulting from the use of our platform or the information contained in this white paper.
Regulatory status is unclear or unsettled in many jurisdictions. Changes in regulatory requirements or approaches may adversely affect the utility or value of ATON tokens and the Arenaton platform.
By accessing or accepting possession of any information in this white paper, you agree to be bound by the above limitations and disclaimers.
