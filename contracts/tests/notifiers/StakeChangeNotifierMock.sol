pragma solidity 0.5.16;

import "../../IStakeChangeNotifier.sol";

/// @title A test mockup for IStakeChangeNotifier.
contract StakeChangeNotifierMock is IStakeChangeNotifier {
    address[] public stakeOwnersNotifications;
    uint256[] public amountsNotifications;
    bool[] public amountsSignsNotifications;

    bool public shouldRevert;

    modifier notReverting() {
        require(!shouldRevert, "StakeChangeNotifierMock: revert");

        _;
    }

    function setRevert(bool _shouldRevert) external {
        shouldRevert = _shouldRevert;
    }

    function reset() external {
        delete stakeOwnersNotifications;
        delete amountsNotifications;
        delete amountsSignsNotifications;
    }

    function getNotificationsLength() external view returns (uint256) {
        uint256 stakeOwnersNotificationsLength = stakeOwnersNotifications.length;
        assert(stakeOwnersNotificationsLength == amountsNotifications.length);
        assert(stakeOwnersNotificationsLength == amountsSignsNotifications.length);

        return stakeOwnersNotificationsLength;
    }

    function stakeChange(address _stakeOwner, uint256 _amount, bool _sign) public notReverting {
        stakeOwnersNotifications.push(_stakeOwner);
        amountsNotifications.push(_amount);
        amountsSignsNotifications.push(_sign);
    }

    function stakeChangeBatch(address[] memory _stakeOwners, uint256[] memory _amounts,
        bool[] memory _signs) public notReverting {
        for (uint i = 0; i < _stakeOwners.length; ++i) {
            stakeOwnersNotifications.push(_stakeOwners[i]);
        }

        for (uint i = 0; i < _amounts.length; ++i) {
            amountsNotifications.push(_amounts[i]);
        }

        for (uint i = 0; i < _signs.length; ++i) {
            amountsSignsNotifications.push(_signs[i]);
        }
    }

    function stakeMigration(address _stakeOwner, uint256 _amount) public notReverting {
        stakeOwnersNotifications.push(_stakeOwner);
        amountsNotifications.push(_amount);
        amountsSignsNotifications.push(true);
    }
}
