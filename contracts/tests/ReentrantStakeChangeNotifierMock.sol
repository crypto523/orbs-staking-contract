pragma solidity 0.4.26;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

import "../IStakingContract.sol";
import "./StakeChangeNotifierMock.sol";

/// @title A reentrancy test mockup for IStakeChangeNotifier.
contract ReentrantStakeChangeNotifierMock is StakeChangeNotifierMock {
    IStakingContract public staking;
    IERC20 public token;
    address public stakeOwner;
    uint256 public amount;
    bool public attacking;

    constructor(IStakingContract _staking, IERC20 _token) public {
        staking = _staking;
        token = _token;
    }

    function setStakeData(address _stakeOwner, uint256 _amount) external {
        stakeOwner = _stakeOwner;
        amount = _amount;
    }

    function approve(address _spender, uint256 _amount) external {
        token.approve(_spender, _amount);
    }

    function stakeChange(address _stakerOwner) public {
        if (attacking) {
            attacking = false;
            super.stakeChange(_stakerOwner);

            return;
        }

        attacking = true;
        super.stakeChange(_stakerOwner);

        staking.acceptMigration(stakeOwner, amount);
    }
}
