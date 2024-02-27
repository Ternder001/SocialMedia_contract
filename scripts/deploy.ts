import { ethers } from "hardhat";

async function main() {
  // Hardhat setup and deployment logic
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const DecentralizedSocialMedia = await ethers.getContractFactory("Socialmedia");
  const decentralizedSocialMedia = await DecentralizedSocialMedia.deploy();

  await decentralizedSocialMedia.waitForDeployment();

  console.log("DecentralizedSocialMedia deployed to:", decentralizedSocialMedia.target);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
