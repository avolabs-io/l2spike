const { expect } = require("chai");

describe("Greeter", function () {
  it("Should increment deposit", async function () {
    const TreasuryMainnet = await ethers.getContractFactory("TreasuryMainnet");
    const treasury = await TreasuryMainnet.deploy();

    const gameDepositAmount = 1000;
    const [owner, user1, user2] = await ethers.getSigners();
    await treasury.deployed();

    await treasury.connect(user1).addDeposit(gameDepositAmount);

    expect(await treasury.deposits(user1.getAddress())).to.equal(
      gameDepositAmount
    );
  });
});
