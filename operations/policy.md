# operations

The operational policy need not require all board members. 

It must require the CFO & CTO at the bare minimum. 

Similar to the `reserve` policy, `operations` can either use a `multi` or an `and_or`

The CTO can optionally chose to maintain their key as a hot wallet, to make the signing process faster.

## multi
```
multi(2,CEO,CFO,CTO)
```

## and_or
```
and(or(CFO,CFO1),or(CTO,CTO1))
```
 
