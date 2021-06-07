# live

The live policy is a single sig hot wallet; ideally maintained by a full node. 

This is the most basic single sig policy with a key generated for the server by the CTO/admin.

## pk

```
pk(NODE)
```
For increased security, use two distributed servers in a multisig setup.

## multi
```
multi(2,NODE,NODE1)
```

This ensures that if one server is compromised, funds are not at risk.


### backup

All operations policies are backed up with a timelock by the CFO.

```
or(pk(NODE),and(pk(CFO,older(blockheight)))
or(multi(2,NODE,NODE1),and(pk(CFO),older(blockheight)))
```
