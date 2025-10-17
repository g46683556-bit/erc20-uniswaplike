# UniswapLike Token (ERC20)

Token ERC20 destinado a un proyecto tipo DEX / liquidity incentives.

## Idea del negocio
Nombre: Uniswap (a modo de ejemplo)
Rubro: Finanzas descentralizadas (DeFi)
Problema que soluciona:
Permite el intercambio automático de tokens ERC20 sin necesidad de un intermediario, utilizando contratos inteligentes que crean mercados de liquidez descentralizados.

## Características del contrato
- ERC20 estándar (transferencias)
- ERC20Permit (EIP-2612)
- Burnable
- Mintable (solo owner)
- Pausable (solo owner)

## Deploy
1. `npm install`
2. Configurar `hardhat.config.js` con RPC y private key.
3. `npx hardhat compile`
4. `npx hardhat run --network goerli scripts/deploy.js`

## Uso
- El owner puede `mint` para incentivos de liquidez.
- Los holders pueden `burn` tokens.
- `permit` permite approvals por firma para mejorar UX en dApps.

