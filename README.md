## Deployments

ExchangeDemo contract deployed to [0x5d8EE8a7a8697B8C8124FD9d5395546Cf01c0F6E](https://testnet.blockscout.injective.network/address/0x5d8EE8a7a8697B8C8124FD9d5395546Cf01c0F6E)

## Usages

### Query spot markets

```
injectived query exchange spot-markets \
  --chain-id injective-888 \
  --node https://testnet.sentry.tm.injective.network:443 \
  -o json > markets.json
```

### Create subaccount id

```
python3 -c 'print("$contract_evm_addr".lower() + 23*"0" + "1")'
```

### Deposit

```
injectived tx bank send \
    --chain-id injective-888 \
    --node https://testnet.sentry.tm.injective.network:443 \
    --fees 32000000000000inj \
    --broadcast-mode sync \
    $USER \
    $contract_inj_addr \
    1000000000000inj
injectived tx bank send \
    --chain-id injective-888 \
    --node https://testnet.sentry.tm.injective.network:443 \
    --fees 32000000000000inj \
    --broadcast-mode sync \
    $USER \
    $contract_inj_addr \
    2000000peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5

cast send $contract_evm_addr 'deposit(string,string,uint256)(bool)' \
  "$contract_evm_addr"000000000000000000000001 peggy0x87aB3B4C8661e07D6372361211B96ed4Dc36B1B5 2000000 \
 --account injective_dev

cast send $contract_evm_addr 'deposit(string,string,uint256)(bool)' \
  "$contract_evm_addr"000000000000000000000001 inj 100000000000000000 \
  --value 100000000000000000 --account injective_dev

injectived query exchange deposits --chain-id injective-888 --node https://testnet.sentry.tm.injective.network:443 $contract_inj_addr 1
```

### Create perp limit order
cast send $contract_evm_addr \
  "createDerivativeLimitOrder((string,string,string,uint256,uint256,string,string,uint256,uint256))" \
  '("0x17ef48032cb24375ba7c2e39f384e56433bcab20cbee9a7357e4cba2eb00abe6","'"$contract_evm_addr"'000000000000000000000001","",10000,1,"","buy",5000,0)' \
  --account injective_dev

### Create spot limit order

The create spot order tx: [0x1555ba323cf60a73675e30f25b0ed9df652ee2e08dc23731bd5f3904fb8aae51](https://testnet.blockscout.injective.network/tx/0x1555ba323cf60a73675e30f25b0ed9df652ee2e08dc23731bd5f3904fb8aae51)

```
cast send $contract_evm_addr \
  "createSpotLimitOrder((string,string,string,uint256,uint256,string,string,uint256))" \
  '("0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe","'"$contract_evm_addr"'000000000000000000000001","inj1tk8w3fagd9aceqfylkw48925dncpcrmwdvhr45",100,1,"DD5AD3B7-A0A4-4432-99C4-3DE20A1CECBB","sell",0)' \
  --account injective_dev
```

### Cancel spot limit order

The cancel order tx: [0x0895a034c5b80a5f8acf1de0db949bb68631bbe1fdbb481c77d00ed76151b688](https://testnet.blockscout.injective.network/tx/0x0895a034c5b80a5f8acf1de0db949bb68631bbe1fdbb481c77d00ed76151b688)

```
cast send $contract_evm_addr \
  "cancelSpotOrder(string,string,string,string)" \
  "0x0611780ba69656949525013d947713300f56c37b6175e02f26bffa495c3208fe" "$contract_evm_addr"000000000000000000000001 "0x4adbd8af13e89ce961ed6875a0a7c84052215dc71000069fbd3338a6bb66b469" "DD5AD3B7-A0A4-4432-99C4-3DE20A1CECBB" \
  --account injective_dev
```
