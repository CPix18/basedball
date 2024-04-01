// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasedballGame {
    address public owner;
    uint256 public constant SWING_COST = 1000000000000000000; // Cost in DEGEN to swing (1 DEGEN)

    enum Result { Strike, Single, Double, Triple, Homerun }

    mapping(address => uint256) public userScores;
    mapping(address => uint256) public strikes;

    event SwingResult(address indexed player, Result result);
    event ClaimReward(address indexed player, uint256 reward);
    event ContractSeeded(uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function seedContract() external payable onlyOwner {
        emit ContractSeeded(msg.value);
    }

    function swing() external payable {
        // Ensure user sent enough DEGEN
        require(msg.value >= SWING_COST, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult();

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result);

        // Update user score
        updateScore(msg.sender, result);

        // Refund excess DEGEN
        if (msg.value > SWING_COST) {
            payable(msg.sender).transfer(msg.value - SWING_COST);
        }
    }

    function claimReward() external {
        uint256 reward = userScores[msg.sender];
        require(reward > 0, "No reward to claim");

        // Reset user score
        userScores[msg.sender] = 0;

        // Transfer reward in DEGEN
        payable(msg.sender).transfer(reward);

        // Emit claim reward event
        emit ClaimReward(msg.sender, reward);
    }

    function updateScore(address user, Result result) internal {
        if (result == Result.Strike) {
            // Check if user has reached 3 strikes
            if (strikes[user] == 3) {
                // Do somDEGENing when the user reaches 3 strikes, like ending the game or resetting their strikes
                // For now, let's reset the strikes for simplicity
                strikes[user] = 0;
            }
            return; // Strikes are worth 0
        }

        uint256 reward;
        if (result == Result.Single) {
            reward = 1000000000000000000; // Assume 1 point is equivalent to 1 DEGEN
        } else if (result == Result.Double) {
            reward = 2000000000000000000; // Assume 2 points is equivalent to 2 DEGEN
        } else if (result == Result.Triple) {
            reward = 5000000000000000000; // Assume 5 points is equivalent to 5 DEGEN
        } else if (result == Result.Homerun) {
            reward = 100000000000000000000; // Assume 10 points is equivalent to 10 DEGEN
        }

        // Update user score
        userScores[user] += reward;
    }

    function getRandomResult() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.timestamp, msg.sender))) % 100;
        if (randomNumber < 40) {
            return Result.Strike;
        } else if (randomNumber < 80) {
            return Result.Single;
        } else if (randomNumber < 90) {
            return Result.Double;
        } else if (randomNumber < 96) {
            return Result.Triple;
        } else {
            return Result.Homerun;
        }
    }

    // Owner function to withdraw DEGEN from the contract
    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(owner).transfer(amount);
    }
}
