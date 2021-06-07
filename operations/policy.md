# operations

The operational policy need not require all board members. 

It understands the tradeoff of security for speed and accordingly operates on a given amount for a given medium term.

It must require the CFO & CTO at the bare minimum. 

The CTO can optionally chose to maintain their key as a hot wallet, to make the signing process faster.

## thresh (preferred)
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(2,CEO,CFO,CTO)
```

Benefits:
- simple
- light-weight
- 1 party can afford to lose key

## thresh
Note: Keys must be wrapped in `pk()` - avoided here for reading clarity.

```
thresh(2,or(CFO,CFO1),or(CTO,CTO1))
```

Benefits:
- 1 backup key per individual
 
Disadvantage:
- 1 member is being completely exluded
- Addition of another member raises complexity 

### backup

Wrap up either policy in an `or` + add an `and` condition with an `after/older` timelock.

For example:

```
or(thresh(2,CEO,CFO,CTO),and(pk(CFO1),older(blockheight)))
```

This will retain the original policy, but also allow the CFO to release the funds with a single sig after a certain blockheight.

Again, this is currently not supported by core, but you can roll out such policies with [bdk](https://bitcoindevkit.org).
