// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract BaseballGame {
    address public constant DEGEN_TOKEN_ADDRESS = 0x4ed4E862860beD51a9570b96d89aF5E1B0Efefed;
    uint256 public constant SWING_COST = 100; // Cost in DEGEN tokens to swing
    uint256 public constant NUM_SWINGS = 5; // Number of swings per game

    enum Result { Strike, Single, Double, Triple, Homerun }

    mapping(address => uint256) public userScores;
    mapping(address => uint256) public swingsRemaining;

    event SwingResult(address indexed player, Result result);
    event ClaimReward(address indexed player, uint256 reward);

    modifier hasEnoughSwings() {
        require(swingsRemaining[msg.sender] > 0, "Not enough swings remaining");
        _;
    }

    modifier hasEnoughTokens() {
        require(IERC20(DEGEN_TOKEN_ADDRESS).balanceOf(msg.sender) >= SWING_COST, "Insufficient DEGEN balance");
        _;
    }

    constructor() {
        // Initialize all users with 5 swings
        swingsRemaining[msg.sender] = NUM_SWINGS;
    }

    function swing() external hasEnoughTokens hasEnoughSwings {
        // Deduct swing cost
        IERC20(DEGEN_TOKEN_ADDRESS).transferFrom(msg.sender, address(this), SWING_COST);
        
        // Decrement swings remaining
        swingsRemaining[msg.sender]--;

        // Get random result
        Result result = getRandomResult();

        // Emit swing result event
        emit SwingResult(msg.sender, result);

        // Update user score
        updateScore(msg.sender, result);
    }

    function claimReward() external {
        uint256 reward = userScores[msg.sender];
        require(reward > 0, "No reward to claim");

        // Reset user score
        userScores[msg.sender] = 0;

        // Transfer reward
        IERC20(DEGEN_TOKEN_ADDRESS).transferFrom(msg.sender, msg.sender, reward);

        // Emit claim reward event
        emit ClaimReward(msg.sender, reward);
    }

    function updateScore(address user, Result result) internal {
        if (result == Result.Strike) {
            // Strikes are worth 0 DEGEN
            return;
        }

        uint256 reward;
        if (result == Result.Single) {
            reward = 10;
        } else if (result == Result.Double) {
            reward = 20;
        } else if (result == Result.Triple) {
            reward = 50;
        } else if (result == Result.Homerun) {
            reward = 100;
        }

        // Update user score
        userScores[user] += reward;
    }

    function getRandomResult() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.basefee, msg.sender))) % 100;
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
}
