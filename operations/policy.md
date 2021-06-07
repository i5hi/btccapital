# operations

The operational policy need not require all board members. 

It must require the CFO & CTO at the bare minimum. 

Unlike the `reserve` policy which is `m/m` multi, `operations` uses a `n/m` multi, making it a bit safer and less vulnerable to lost keys.

`m - n` parties can afford to lose their keys without compromising funds.

The CTO can optionally chose to maintain their key as a hot wallet, to make the signing process faster.

## multi (preffered)
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
- 2 parties can addord to lose keys

Disadvantage:
- 1 member is being completed exluded
- Addition of another member raises complexity 

