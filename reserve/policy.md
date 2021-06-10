# reserve

For a reserve policy we encourage requiring ALL board members. This ensures that an organization sets out with the intent to maintain consensus at the board level. This also reflects the strength of an organization's board.

Let us consider an example of 3 board members represented by their keys (CEO,CFO & CTO) creating an organization. 

They begin by creating a reserve policy for receiving funds from `btccapital`.

Two scripting options are viable here:

## multi
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(3,CEO,CFO,CTO)
```
3 conditions must satisfy. Each condition is a single signature from each board member.

Benefits:
- well supported 
- smaller size

Disadvantages
- a single lost key can compromise funds


## raft (preferred)
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(3,or(CEO,CEO'),or(CFO,CFO'),or(CTO,CTO'))
```

3 conditions must satisfy. Each condition is a single sig from one of each of the board members set of keys.

The `'` references the backup key. 

Benefits:
- 1 key backup per individual

Disadvantages
- not well supported yet (try [bdk](https://bitcoindevkit.org))
- larger size (will not be an issue with schnorr/taproot)




### genesis.sh 
initializes the setup. It creates a `descriptors.md` and a `keys.md` for both `raft` and `multi` policies. 

`descriptors.md` contains the script address that requires funding before moving to the next step.

### multi.sh 

Use the descriptors under `multi` in `descriptors.md` as variables in `multi.sh`.

#### flow

> All signatories must have the complete descriptor 

- any signatory can start the process by craeting a tx (we use the pubdesc)
- they then sign and pass a signed psbt to the next signatory
- the final signatory can directly broadcast

### raft.sh 

Use the `PUBLIC DESCRIPTOR` under `raft` in `descriptors.md` as the `PUBDESC` variable in `raft.sh`.

#### flow

> Signatories need not hold the entire descriptor, a server is used to combine and finalize the psbt

- the server creates a `psbt0` that empties the wallet with a payment to mempool.co
- all three signatories individually sign `psbt0` and return new psbts to the server
- the server approriately combines the each of the psbts, finalizes and broadcasts.


### Updates

Currently `raft` has the ability to allow signatories to use `wpkh` single key wallet (hardware) to sign without awareness of the policy it is signing for.

`multi` currently requires signatories to hold the entire `wsh(multi())` descriptor. Although this makes for an easier flow, it is not conveneient for signatories to sign using hardware.