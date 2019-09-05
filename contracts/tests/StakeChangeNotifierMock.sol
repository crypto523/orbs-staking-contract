pragma solidity 0.4.26;

import "../IStakeChangeNotifier.sol";


/// @title A test mockup for IStakeChangeNotifier.
contract StakeChangeNotifierMock is IStakeChangeNotifier {
    address public calledWith;
    bool public shouldRevert;

    function setRevert(bool _shouldRevert) public {
        shouldRevert = _shouldRevert;
    }

    function stakeChange(address _stakerOwner) public {
        require(!shouldRevert, "StakeChangeNotifierMock::stakeChange - revert");

        calledWith = _stakerOwner;
    }
}
