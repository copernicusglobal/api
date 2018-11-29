# Account Model

The account (or, probably, a wallet) - a basic unit for storing funds of a customer. Each account has
its own private key and all transactions which are conducted with use of this account are signed by the
key. The customer who owns the account is the only person who can get access to the key due to our robust
encryption system.

```
{
    "balance": 2.15516
    "currency": {...}
    "description": "Golden"
    "estimated": 2.15516
    "id": 7654321
    "state": "Active"
    "type": "Common"
}
```

### balance

The real balance of the account which shows the remainder of funds. This amount is strictly calculated based
on the credit outputs belonging to the account from the underlying blockchain.

### currency

The asset (currency) which describe the nature of the account (US Dollar, gold, bitcoins).
Please refer to [assets page](./asset.md) in order to get more details on it.

### description

The title of the accounts given by the customer. It can be 'My precious' or 'GOLD' or any other which the user
likes.

### estimated

The balance of the account which is calculated before receiving confirmations on all transactions from the
underlying blockchain. If all transactions with use of the account are confirmed by the network, the estimated field
and the balance field are equals.

### type

There are two types of the account: Common and Deposit. The 'Common' account is an account which has general
purpose. The 'Deposit' account has a restriction - you can withdraw funds from it just to other your accounts.
It means you can't send money from this account directly to another user. Mostly, such an account is a way
to restrict occasional withdrawals and a way to store large amounts in more safety.

All functions available for account you can find [here](../products/accounts.md).