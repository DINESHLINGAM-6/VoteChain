const hre = require("hardhat");

async function main() {
  // Compile the contract before deployment
  await hre.run("compile");

  // Get the contract factory
  const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");

  console.log("Deploying VotingSystem contract...");

  // Deploy the contract
  const contract = await VotingSystem.deploy(); 
  await contract.waitForDeployment(); 

  // Fetch deployed contract address
  console.log("Contract deployed to:", await contract.getAddress());
}

// Execute the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying contract:", error);
    process.exit(1);
  });
