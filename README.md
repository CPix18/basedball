# basedball
 - start with the abi code and go to remix to play - https://github.com/CPix18/basedball/blob/main/basedball.abi

## directions to play using remix:
- visit remix.ethereum.org
- add degen chain to your metamask (https://syndicate.io/blog/degen-chain)
- fund your degen wallet using https://bridge.degen.tips/ (best way is to convert some coin on base and send it to degen as DEGEN)
- on the left side under "file explorer" make file with this code and name it ball.abi
- on the left side under "deploy and run transactions" input this address "0x42377e514Ed9F0F44B1CBfC7c9eC8AD9d54bFB09" and click "at address" (dont use quotes in address box)
- above this you'll see value, change it from "wei" to "finney" and input value "1" instead of "0"
- above that you'll see "environment" and you'll change it to "injected provider" which will be your metamask
under "deployed/unpinned contracts" click the dropdown arrow 
- click the "swing" button, you can only call this if the value box above is set to 1 "finney" - this will use 0.001 degen
- keep playing until you get 3 strikes, you can keep track by inserting your address into the blue boxes under "swing" button which will track your rewards and your strikes
- claimReward you can call after you've played a few times if you haven't gotten all strikes
- if you receive an error about gas estimation, you probably didn't insert a value in the value box
- if your transaction failed, increase gas cost x10 so if base fee and tip are 1.5 each, change to 15
