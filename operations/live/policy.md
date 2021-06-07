# live

The live policy is a single sig hot wallet; ideally maintained by a full node. 

This is the most basic single sig policy with a key generated for the server by the CTO/admin.

## pk

```
pk(NODE)
```
For increased security, use two distributed servers in a multisig setup.

Benefits:
- simple
- fast

Disadvantages:
- single point of failure

## multi (preferred)
```
multi(2,NODE,SIGSERVER)
```

The second server need not run a node, it just needs to sign PSBT's.

This ensures that if one server is compromised, funds are not at risk.

Benefits:
- no single point of failure

Disadvantages:
- additional server cost
- marginally slower

### backup

All operations policies are backed up with a timelock by the CFO.

```
or(multi(2,NODE,SIGSERVER),and(pk(CFO),older(blockheight)))
```
