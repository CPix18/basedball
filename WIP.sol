// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasedballGame {
    address public owner;
    uint256 public constant BABY_SWING = 1000000000000000000; // Cost in DEGEN to swing (1 DEGEN)
    uint256 public constant TEE_BALL = 10000000000000000000; // Cost in DEGEN to swing (10 DEGEN)
    uint256 public constant THE_SHOW = 100000000000000000000; // Cost in DEGEN to swing (100 DEGEN)
    uint256 public constant SLUGGER = 1000000000000000000000; // Cost in DEGEN to swing (1000 DEGEN)
    uint256 public constant TOTAL_DEGEN = 10000000000000000000000; // Cost in DEGEN to swing (10000 DEGEN)
    uint256 public constant BONUS_THRESHOLD_1 = 5;
    uint256 public constant BONUS_THRESHOLD_2 = 10;
    uint256 public constant BONUS_THRESHOLD_3 = 15;

    enum Result { Strike, Single, Double, Triple, Homerun }

    mapping(address => uint256) public userScores;
    mapping(address => uint256) public strikes;
    mapping(address => uint256) public swingCounts;

    event SwingResult(address indexed player, Result result, uint256 bonusMultiplier);
    event ClaimReward(address indexed player, address indexed recipient, uint256 reward);
    event ContractSeeded(uint256 value);

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
        require(msg.value == BABY_SWING, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult_BS();

        // Check for bonus multiplier
        uint256 bonusMultiplier = 1;
        if (swingCounts[msg.sender] == BONUS_THRESHOLD_1) {
            bonusMultiplier = 2; // Double reward on the tenth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_2) {
            bonusMultiplier = 3; // Triple reward on the fiftieth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_3) {
            bonusMultiplier = 4; // Quadruple reward on the hundredth swing
        }

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result, bonusMultiplier);

        // Update user score
        updateScore(msg.sender, result, bonusMultiplier);

        // Refund excess DEGEN
        if (msg.value > BABY_SWING) {
            payable(msg.sender).transfer(msg.value - BABY_SWING);
        }

        // Increment swing count
        swingCounts[msg.sender]++;

    }

    function swing10() external payable {
        // Ensure user sent enough DEGEN
        require(msg.value == TEE_BALL, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult_TB();

       // Check for bonus multiplier
        uint256 bonusMultiplier = 1;
        if (swingCounts[msg.sender] == BONUS_THRESHOLD_1) {
            bonusMultiplier = 2; // Double reward on the tenth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_2) {
            bonusMultiplier = 3; // Triple reward on the fiftieth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_3) {
            bonusMultiplier = 4; // Quadruple reward on the hundredth swing
        }

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result, bonusMultiplier);

        // Update user score
        updateScore(msg.sender, result, bonusMultiplier);

        // Refund excess DEGEN
        if (msg.value > TEE_BALL) {
            payable(msg.sender).transfer(msg.value - TEE_BALL);
        }

        // Increment swing count
        swingCounts[msg.sender]++;
        
    }

    function swing100() external payable {
        // Ensure user sent enough DEGEN
        require(msg.value == THE_SHOW, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult_TS();

        uint256 bonusMultiplier = 1;
        if (swingCounts[msg.sender] == BONUS_THRESHOLD_1) {
            bonusMultiplier = 2; // Double reward on the tenth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_2) {
            bonusMultiplier = 3; // Triple reward on the fiftieth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_3) {
            bonusMultiplier = 4; // Quadruple reward on the hundredth swing
        }

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result, bonusMultiplier);

        // Update user score
        updateScore(msg.sender, result, bonusMultiplier);

        // Refund excess DEGEN
        if (msg.value > THE_SHOW) {
            payable(msg.sender).transfer(msg.value - THE_SHOW);
        }
    }

    function swing1000() external payable {
        // Ensure user sent enough DEGEN
        require(msg.value == SLUGGER, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult_SG();

        uint256 bonusMultiplier = 1;
        if (swingCounts[msg.sender] == BONUS_THRESHOLD_1) {
            bonusMultiplier = 2; // Double reward on the tenth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_2) {
            bonusMultiplier = 3; // Triple reward on the fiftieth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_3) {
            bonusMultiplier = 4; // Quadruple reward on the hundredth swing
        }

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result, bonusMultiplier);

        // Update user score
        updateScore(msg.sender, result, bonusMultiplier);

        // Refund excess DEGEN
        if (msg.value > SLUGGER) {
            payable(msg.sender).transfer(msg.value - SLUGGER);
        }
    }

    function swing10000() external payable {
        // Ensure user sent enough DEGEN
        require(msg.value == TOTAL_DEGEN, "Insufficient DEGEN sent");

        // Get random result
        Result result = getRandomResult_TD();

        uint256 bonusMultiplier = 1;
        if (swingCounts[msg.sender] == BONUS_THRESHOLD_1) {
            bonusMultiplier = 2; // Double reward on the tenth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_2) {
            bonusMultiplier = 3; // Triple reward on the fiftieth swing
        } else if (swingCounts[msg.sender] == BONUS_THRESHOLD_3) {
            bonusMultiplier = 4; // Quadruple reward on the hundredth swing
        }

        // Increment strikes if it's a strike
        if (result == Result.Strike) {
            strikes[msg.sender]++;
        }

        // Emit swing result event
        emit SwingResult(msg.sender, result, bonusMultiplier);

        // Update user score
        updateScore(msg.sender, result, bonusMultiplier);

        // Refund excess DEGEN
        if (msg.value > TOTAL_DEGEN) {
            payable(msg.sender).transfer(msg.value - TOTAL_DEGEN);
        }
    }

    function claimReward(address recipient) external {
        uint256 reward = userScores[msg.sender];
        require(reward > 0, "No reward to claim");

        // Reset user score
        userScores[msg.sender] = 0;

        // Transfer reward in DEGEN to specified recipient
        payable(recipient).transfer(reward);

        // Emit claim reward event
        emit ClaimReward(msg.sender, recipient, reward);

    }

    function updateScore(address user, Result result, uint256 bonusMultiplier) internal {
        if (result == Result.Strike) {
            // Check if user has reached 3 strikes
            if (strikes[user] == 3) {
                // Do something when the user reaches 3 strikes, like ending the game or resetting their strikes
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
            reward = 10000000000000000000; // Assume 10 points is equivalent to 10 DEGEN
        }

        // Apply bonus multiplier
        reward *= bonusMultiplier;

        // Update user score
        userScores[user] += reward;
    }

    function getRandomResult_BS() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.timestamp, msg.sender))) % 100;
        if (randomNumber < 20) {
            return Result.Strike;
        } else if (randomNumber < 60) {
            return Result.Single;
        } else if (randomNumber < 80) {
            return Result.Double;
        } else if (randomNumber < 90) {
            return Result.Triple;
        } else {
            return Result.Homerun;
        }
    }

    function getRandomResult_TB() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.timestamp, msg.sender))) % 100;
        if (randomNumber < 30) {
            return Result.Strike;
        } else if (randomNumber < 70) {
            return Result.Single;
        } else if (randomNumber < 85) {
            return Result.Double;
        } else if (randomNumber < 92) {
            return Result.Triple;
        } else {
            return Result.Homerun;
        }
    }

    function getRandomResult_TS() internal view returns (Result) {
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

    function getRandomResult_SG() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.timestamp, msg.sender))) % 100;
        if (randomNumber < 50) {
            return Result.Strike;
        } else if (randomNumber < 80) {
            return Result.Single;
        } else if (randomNumber < 95) {
            return Result.Double;
        } else if (randomNumber < 98) {
            return Result.Triple;
        } else {
            return Result.Homerun;
        }
    }

    function getRandomResult_TD() internal view returns (Result) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.timestamp, msg.sender))) % 100;
        if (randomNumber < 60) {
            return Result.Strike;
        } else if (randomNumber < 90) {
            return Result.Single;
        } else if (randomNumber < 95) {
            return Result.Double;
        } else if (randomNumber < 99) {
            return Result.Triple;
        } else {
            return Result.Homerun;
        }
    }

    // Owner function to withdraw all DEGEN from the contract and specify recipient address
    function withdraw(address payable recipient) external onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "Contract has no DEGEN balance");
        require(recipient != address(0), "Invalid recipient address");
        recipient.transfer(contractBalance);
    }
}
