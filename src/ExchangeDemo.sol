// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ExchangeTypes, IExchangeModule } from "./exchange/Exchange.sol";

contract ExchangeDemo {
    address constant exchangeContract = 0x0000000000000000000000000000000000000065;
    IExchangeModule exchange = IExchangeModule(exchangeContract);

    /**
     * @notice Deposits funds from the contract's balance into one of its exchange subaccounts.
     * @param subaccountID The target subaccount ID (derived from the contract's address).
     * @param denom The denomination of the asset to deposit (e.g., "inj").
     * @param amount The quantity of the asset to deposit.
     * @return success Boolean indicating if the deposit was successful.
     */
    function deposit(string calldata subaccountID, string calldata denom, uint256 amount)
        external
        payable
        returns (bool)
    {
        try exchange.deposit(address(this), subaccountID, denom, amount) returns (bool success) {
            return success;
        } catch Error(string memory reason) {
            revert(string(abi.encodePacked("Deposit error: ", reason)));
        } catch {
            revert("Unknown error during deposit");
        }
    }

    /**
     * @notice Withdraws funds from one of the contract's exchange subaccounts to its main balance.
     * @param subaccountID The source subaccount ID.
     * @param denom The denomination of the asset to withdraw.
     * @param amount The quantity of the asset to withdraw.
     * @return success Boolean indicating if the withdrawal was successful.
     */
    function withdraw(string calldata subaccountID, string calldata denom, uint256 amount) external returns (bool) {
        try exchange.withdraw(address(this), subaccountID, denom, amount) returns (bool success) {
            return success;
        } catch Error(string memory reason) {
            revert(string(abi.encodePacked("Withdraw error: ", reason)));
        } catch {
            revert("Unknown error during withdraw");
        }
    }

    function subaccountPositions(string calldata subaccountID)
        external
        view
        returns (IExchangeModule.DerivativePosition[] memory positions)
    {
        return exchange.subaccountPositions(subaccountID);
    }

    function createDerivativeLimitOrder(IExchangeModule.DerivativeOrder calldata order)
        external
        returns (IExchangeModule.CreateDerivativeLimitOrderResponse memory response)
    {
        try exchange.createDerivativeLimitOrder(address(this), order) returns (
            IExchangeModule.CreateDerivativeLimitOrderResponse memory resp
        ) {
            return resp;
        } catch Error(string memory reason) {
            revert(string(abi.encodePacked("CreateDerivativeLimitOrder error: ", reason)));
        } catch {
            revert("Unknown error during createDerivativeLimitOrder");
        }
    }

    function spotOrdersByHashes(IExchangeModule.SpotOrdersRequest calldata request)
        external
        returns (IExchangeModule.TrimmedSpotLimitOrder[] memory)
    {
        return exchange.spotOrdersByHashes(request);
    }

    function createSpotLimitOrder(IExchangeModule.SpotOrder calldata order)
        external
        returns (IExchangeModule.CreateSpotLimitOrderResponse memory)
    {
        try exchange.createSpotLimitOrder(address(this), order) returns (
            IExchangeModule.CreateSpotLimitOrderResponse memory resp
        ) {
            return resp;
        } catch Error(string memory reason) {
            revert(string(abi.encodePacked("CreateSpotLimitOrder error: ", reason)));
        } catch {
            revert("Unknown error during createSpotLimitOrder");
        }
    }

    function cancelSpotOrder(
        string calldata marketID,
        string calldata subaccountID,
        string calldata orderHash,
        string calldata cid
    ) external returns (bool) {
        try exchange.cancelSpotOrder(address(this), marketID, subaccountID, orderHash, cid) returns (bool success) {
            return success;
        } catch Error(string memory reason) {
            revert(string(abi.encodePacked("CancelSpotOrder error: ", reason)));
        } catch {
            revert("Unknown error during cancelSpotOrder");
        }
    }
}
