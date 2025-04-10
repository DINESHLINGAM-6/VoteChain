const hre = require("hardhat");

async function main() {
    console.log("🚀 Starting deployment...");

    const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");
    console.log("✅ Contract factory fetched");

    const votingSystemInstance = await VotingSystem.deploy();
    console.log("📦 Deployment transaction sent. Tx hash:", votingSystemInstance.deployTransaction.hash);

    await votingSystemInstance.deployed();
    console.log("🎉 Contract deployed at address:", votingSystemInstance.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Error during deployment:", error);
    process.exit(1);
  });
