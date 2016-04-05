# External transactions

All transactions connected with sending or receiving money to/from bank cards or bank accounts should use 
the transaction_type field value to be 'External'. The "direction" of a transaction (0 - "out", 1 - "in") 
means whether we send or receive money. 

An additional attribute "external_channel" is used to specify  a concrete kind of an external transaction: for sending
or receiving money to/from a bank card this  attribute should have the "Card" value, in the case of sending money to
a bank account should be used the "BankAccount" one. Currently, receiving money from bank accounts is not supported so
that the direction 1 cannot be used in conjunction with the "BankAccount" channel.

Each type of external transactions has its own set of additional attributes which is discussed below. 

Each transaction also has the "related_currency" field which mostly depends on a concrete way of receiving 
or sending money. For example, to receive money we use "USD" or "EUR" currencies and these currencies 
will be presented in a bank's card statement as the transaction currencies. 

See how to retrieve necessary currencies below.

1. [Receiving money from a bank card](./externaltransactionfromcard.md)
2. [Encrypting card data](./encryptcarddata.md)
3. [Sending money to a bank card](./externaltransactiontocard.md)
4. [Sending money to a bank account](./externaltransactiontoaccount.md)
5. [Retrieving a list of available currencies](./currenciesfortransaction.md)
