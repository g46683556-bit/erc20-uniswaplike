async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  const name = "UniswapLike Token";
  const symbol = "ULT";
  const initialSupply = "1000000"; // 1,000,000
  const decimals = 18;

  const Token = await ethers.getContractFactory("UniswapLikeToken");
  const token = await Token.deploy(name, symbol, initialSupply, decimals);
  await token.deployed();

  console.log("Token deployed to:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
