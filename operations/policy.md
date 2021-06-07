# operations

The operational policy need not require all board members. 

It must require the CFO & CTO at the bare minimum. 

Unlike the `reserve` policy which is `m/m` multi, `operations` uses a `n/m` multi, making it a bit safer and less vulnerable to lost keys.

`m - n` parties can afford to lose their keys without compromising funds.

The CTO can optionally chose to maintain their key as a hot wallet, to make the signing process faster.

## multi (preferred)
```
multi(2,CEO,CFO,CTO)
```

Benefits:
- simple
- light-weight
- 1 party can afford to lose key

## and_or
```
and(or(CFO,CFO1),or(CTO,CTO1))
```

Benefits:
- 2 parties can afford to lose keys

Disadvantage:
- 1 member is being completely exluded
- Addition of another member raises complexity 

### backup

Wrap up either policy in an `or` + add an `and` condition with an `after/older` timelock.

For example:

```
or(multi(2,CEO,CFO,CTO),and(pk(CFO1),older(blockheight))
```

This will retain the original policy, but also allow the CFO to release the funds with a single sig after a certain blockheight.

Again, this is currently not supported by core, but you can roll out such policies with [bdk](https://bitcoindevkit.org).
