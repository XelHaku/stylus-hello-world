#![cfg_attr(not(feature = "export-abi"), no_main)]
extern crate alloc;
mod ownable;
mod control;
mod constants;
mod structs;
mod tools;

use crate::tools::{string_to_bytes32, bytes32_to_string};
use crate::ownable::Ownable;

use crate::control::AccessControl;

use alloy_sol_types::sol;

// --- Use standard String ---
use std::string::String;

use alloy_primitives::{ Address, U256, B256 };
use stylus_sdk::{
    abi::Bytes,
    call::{call, transfer_eth, Call},    contract,
    evm,
    msg,
    stylus_proc::{ public, sol_storage, SolidityError },
};
use stylus_sdk::prelude::*;
use alloy_primitives::FixedBytes;


sol_interface! {
    interface IATON {
    function mintAtonFromEth() external payable returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);    
}
}

/// Additional events and errors
sol! {
    event DonateATON(address indexed sender, uint256 amount);
    event Accumulate(uint256 new_commission, uint256 accumulated, uint256 total);
    error ZeroEther(address sender);
    error ZeroAton(address sender);
    error AlreadyInitialized();

    event AddEvent(        bytes8 event_id,
        uint64 start_date,
        uint8 sport,
    );
}

/// Represents the ways methods may fail.
#[derive(SolidityError)]
pub enum ATONError {
    ZeroEther(ZeroEther),
    ZeroAton(ZeroAton),
    AlreadyInitialized(AlreadyInitialized),
}
const ATON: &str = "0xa6e41ffd769491a42a6e5ce453259b93983a22ef";
// `ArenatonEngine` will be the entrypoint.
sol_storage! {
    #[entrypoint]
    pub struct ArenatonEngine {
        #[borrow]
        Ownable ownable;
        #[borrow]
        AccessControl control;
//   uint256 private premium = 200000;
//   uint256 constant pct_denom = 10000000;

  // Mapping for storing event and player data
  mapping(bytes8 => Event)  events;
  mapping(address => Player)  players;

  // Array for tracking active events
  bytes8[]  activeEvents;
  bytes8[]  closedEvents;
    }

  

 /**
   * @dev Structure representing a player's data within the platform.
   * This structure includes details about the player's activity, level, and commission earnings.
   */
  struct Player {
    bytes8[] activeEvents; // Array of event IDs in which the player is currently participating.
    bytes8[] closedEvents; // Array of event IDs for events that the player participated in and that are now closed.
    uint32 level; // The player's current level, representing their experience or skill within the platform.
    uint256 claimedCommissionsByPlayer; // Total amount of commissions claimed by the player.
    uint256 lastCommissionPerTokenForPlayer; // The last recorded commission per token for the player, used to calculate unclaimed commissions.
  }

      /**
   * @dev Structure representing a player's stake in an event.
   * This structure holds the amount staked and the team the player has bet on.
   */
  pub struct Stake {
    uint256 amount; // The total amount of tokens staked by the player.
    uint8 team; // The team the player is betting on: 1 for Team A, 2 for Team B.
uint64 timestamp;  
}

  /**
   * @dev Structure representing an event for betting.
   * This structure includes all necessary details for managing the event, including stakes, players, and the event's status.
   */
  pub struct Event {
    bytes8 eventIdBytes; // Unique identifier for the event in bytes8 format.
    uint256 startDate; // The start date and time of the event.
    address[] players; // List of players who have placed stakes in the event.
    mapping(address => Stake) stakes; // Mapping of player addresses to their respective stakes.
    mapping(address => bool) stakeFinalized; // Mapping to track whether a player's stake has been finalized and paid out.
    uint256[2] total; // Total stakes for each team: index 0 for Team A, index 1 for Team B.
    int8 winner; // The winner of the event: 1 for Team A, 2 for Team B, -2 for a tie, -1 for no result yet, -3 for event canceled.
    uint8 sport; // Identifier representing the sport associated with the event.
    uint256 playersPaid; // Number of players who have been paid out.
    bool active; // Indicates whether the event is currently open for participation.
    bool closed; // Indicates whether the event has ended.
    bool paid; // Indicates whether all payouts for the event have been processed.
  }


}

// Remove or provide Erc20 trait below if needed
#[public]
#[inherit(Ownable, AccessControl)]
impl ArenatonEngine {
    /// Add a new event
      pub fn add_event(
        &mut self,
        event_id: String,
        start_date: u64,
        sport: u8
    ) -> Result<bool, ATONError> {
        // Convert event_id to bytes8
        let event_id_key = string_to_bytes32(&event_id);

        // Insert into the events mapping
        let event = self.events.get(event_id_key);


        // event.startDate = start_date;
        // event.sport = sport;    


        // Log the event
        evm::log(AddEvent {
            event_id: event_id_key, // Use the FixedBytes<8> type here
            start_date,
            sport,
        });

        Ok(true)
    }

    
    /// Stake with ETH
    #[payable]
    pub fn stake_eth(&mut self, _event_id: String, _team: u8) -> Result<bool, ATONError> {
        let _amount = msg::value(); // Ether sent with the transaction
        let _player = msg::sender();


        // Parse the const &str as a local Address variable
        let aton_address = Address::parse_checksummed(ATON, None).expect("Invalid address");
        let aton_contract = IATON::new(aton_address);
       
       
        let config = Call::new_in(self).value(_amount);

        let _ = match aton_contract.mint_aton_from_eth(config) {
            Ok(_) => Ok(true),
            Err(e) => Err(false),
        };

    

let _ = self.stake(_event_id,_amount, _team);
        Ok(true)
    }
    /// Stake with ATON
    pub fn stake(
        &mut self,
        _event_id: String,
        _amount: U256,
        _team: u8
    ) -> Result<bool, ATONError> {
        // convert _event_id to bytes8
        let mut event_id_bytes = [0u8; 8];
        let bytes = _event_id.as_bytes();
        let copy_len = bytes.len().min(event_id_bytes.len());
        event_id_bytes[..copy_len].copy_from_slice(&bytes[..copy_len]);

        // Convert [u8; 8] to FixedBytes<8>
        let event_id_key = FixedBytes::<8>::from(event_id_bytes);

        // Insert into the events mapping
        let event = self.events.get(event_id_key);
        // if event.is_none() {
        //     return Err(false);
        // }   

        // Your logic
        Ok(true)
    }


       pub fn stake_aton(
        &mut self,
        _event_id: String,
        _amount: U256,
        _team: u8
    ) -> Result<bool, ATONError> {
        let _player = msg::sender();


        // Parse the const &str as a local Address variable
        let aton_address = Address::parse_checksummed(ATON, None).expect("Invalid address");
        let aton_contract = IATON::new(aton_address);
       
       
        let config = Call::new_in(self);

        let _ =match aton_contract.transfer_from(config, _player, contract::address(),_amount) {
            Ok(_) => Ok(true),
            Err(e) => Err(false),
        };

    

let _ = self.stake(_event_id,_amount, _team);
        // Your logic
        Ok(true)
    }


    pub fn close_event(&mut self, _event_id: String, _winner: u8) -> Result<bool, ATONError> {
        // Your logic
        Ok(true)
    }

    pub fn pay_event(&mut self, _event_id: String, _batch_size: u128) -> Result<bool, ATONError> {
        // Your logic
        Ok(true)
    }

    pub fn get_event(&self, _event_id: String) -> Result<bool, ATONError> {
        // Your logic
        Ok(true)
    }

    pub fn get_event_list(&self) -> Result<bool, ATONError> {
        // Your logic
        Ok(true)
    }

    pub fn get_player_event_list(&self, _player: Address) -> Result<bool, ATONError> {
        // Your logic
        Ok(true)
    }
}

impl ArenatonEngine {
    // Additional private or internal functions
}
