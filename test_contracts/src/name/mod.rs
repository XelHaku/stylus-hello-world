use ethers::prelude::*;
use ethers::providers::{Http, Provider};
use ethers::types::Address;
use ethers::contract::Contract;
use dotenv::dotenv;
use std::sync::Arc;
use ethers::abi::Abi;

// Add this line to import the necessary eyre types
use eyre::{Result, WrapErr};

pub async fn name() -> Result<()> {
    // Load environment variables
    dotenv().ok();

    // RPC URL (Replace with your Ethereum node URL)
    let rpc_url = std::env::var("RPC_URL").unwrap_or_else(|_| "http://127.0.0.1:8545".into());
    let provider = Provider::<Http>::try_from(rpc_url)?;
    // Contract address (Replace with your contract address)
    let contract_address: Address = std::env::var("CONTRACT_ADDRESS")
        .unwrap_or_else(|_| "0x525c2aba45f66987217323e8a05ea400c65d06dc".into())
        .parse()
        .wrap_err("Invalid contract address")?;

    // Contract ABI (Replace with the actual ABI)
    let abi: Abi = serde_json::from_str(
        r#"[
   {
    "inputs": [],
    "name": "name",
    "outputs": [{ "internalType": "string", "name": "", "type": "string" }],
    "stateMutability": "pure",
    "type": "function"
  },

]"#
    );
    // Initialize the contract instance
    let contract = Contract::new(contract_address, abi, Arc::new(provider));

    // Replace with the address you want to query
    let owner_address: Address = "0x525c2aba45f66987217323e8a05ea400c65d06dc".parse()?;

    // Call the "balanceOf" function on the smart contract
    let balance: U256 = contract
        .method::<_, U256>("balanceOf", owner_address)?
        .call()
        .await?;

    println!("Balance of {:?}: {}", owner_address, balance);

    Ok(())
}

#[tokio::main]
async fn main() {
    // This will only run when the module is called by itself
    if let Err(err) = name().await {
        eprintln!("Error: {:?}", err);
    }
}
