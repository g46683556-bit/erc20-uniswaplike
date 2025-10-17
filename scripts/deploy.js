async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Desplegando con la cuenta:", deployer.address);

  const Token = await ethers.getContractFactory("UniswapLikeToken");
  const token = await Token.deploy("UniswapLike Token", "ULT", 1000000, 18);
  await token.deployed();

  console.log("Token desplegado en:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
