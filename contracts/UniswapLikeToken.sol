// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title UniswapLikeToken
 * @dev ERC20 token pensado para integrarse en un DEX / pools de liquidez.
 *      Funcionalidades incluidas:
 *       - ERC20 estándar (nombre y símbolo configurables)
 *       - ERC20Burnable (quemado por holders)
 *       - ERC20Permit (EIP-2612, approvals por signature)
 *       - Pausable (pausar transferencias en emergencia)
 *       - Ownable (gestión administrativa: mint, pause, etc.)
 *       - Mint controlado por owner
 *
 *  Ajusta permisos y features según el caso real de uso.
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UniswapLikeToken is ERC20, ERC20Burnable, ERC20Permit, Pausable, Ownable {
    uint8 private immutable _decimals;

    /// @notice Constructor
    /// @param name_ Nombre del token (ej. "UniswapLike Token")
    /// @param symbol_ Símbolo (ej. "ULT")
    /// @param initialSupply_ Suministro inicial (sin decimales, ej. 1_000_000)
    /// @param decimals_ Número de decimales (ej. 18)
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 initialSupply_,
        uint8 decimals_
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        _decimals = decimals_;
        // mint al deployer (owner)
        _mint(msg.sender, initialSupply_ * (10 ** uint256(_decimals)));
    }

    /// @notice Devuelve decimales configurados
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    /// @notice Minter solo para el owner (administrador)
    /// @param to dirección a la cual mintear
    /// @param amount cantidad (con decimales)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /// @notice Pausar transfers en emergencia
    function pause() external onlyOwner {
        _pause();
    }

    /// @notice Despausar
    function unpause() external onlyOwner {
        _unpause();
    }

    /// @dev Hooks: evitamos transfers si está pausado
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        require(!paused(), "ERC20Pausable: token transfer while paused");
    }
}
