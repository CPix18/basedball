# basedball

## directions to play using remix:
- visit remix.ethereum.org
- pick the option to "load from" with github and insert this link in the popup box - https://github.com/CPix18/basedball/blob/main/basedball.abi
- save the basedball.abi file by using "command" + "s" in the "File Explorer" tab
- add degen chain to your metamask (https://syndicate.io/blog/degen-chain)
- fund your degen wallet using https://bridge.degen.tips/ (best way is to convert some coin on base and send it to degen as DEGEN)
- on the left side under "file explorer" make file with this code and name it ball.abi
- on the left side under "deploy and run transactions" input this address "0x9FD0D41b184F663D198b38f91c5d16279c758008" and click "at address" (dont use quotes in address box)
- above this you'll see value, change it from "wei" to "ether" and input value "1" instead of "0"
- above that you'll see "gas limit" change that from "3000000" to "6000000"
- above that you'll see "environment" and you'll change it to "injected provider" which will be your metamask
- under "deployed/unpinned contracts" click the dropdown arrow click the "swing" button, you can only call this if the value box above is set to 1 "ether" - this will use 1 degen
- keep playing until you get 3 strikes, you can keep track by inserting your address into the blue boxes under "swing" button which will track your rewards and your strikes
- claimReward you can call after you've played a few times if you haven't gotten all strikes

## tips
- you might need to change compiler to 8.0 instead of whatever it is set on
- if you receive an error about gas estimation, you probably didn't insert a value in the value box
- if your transaction failed, then edit gas and use "aggressive" option
