# reserve

For a reserve policy we encourage requiring ALL board members. This ensures that an organization sets out with the intent to maintain consensus at the board level. This also reflects the strength of an organization's board.

Let us consider an example of 3 board members represented by their keys (CEO,CFO & CTO) creating an organization. 

They begin by creating a reserve policy for receiving funds from `btccapital`.

Two scripting options are viable here:

## thresh
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(3,CEO,CFO,CTO)
```

Benefits:
- well supported 
- smaller size

Disadvantages
- a single lost key can compromise funds

## thresh_or (preferred)
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(3,or(CEO,CEO1),or(CFO,CFO1),or(CTO,CTO1))
```

Benefits:
- 1 key backup per individual

Disadvantages
- not well supported yet (try [bdk](https://bitcoindevkit.org))
- larger size (will not be an issue with schnorr/taproot)


