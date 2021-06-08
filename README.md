# btccapital 

An model for structuring bitcoin native organizations as a set of [miniscript policies](http://bitcoin.sipa.be/miniscript/).

## overview

`btcapital` is the topmost level of an organization, representing the individual/group bringing capital into the organization.

This represents external funds entering the organization and we are therefore not in control of its spending policy. It could either come from an individual single-sig or an group of investors as a multi-sig or some other policy.


```bash
# Get rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Get bdk-cli to test policy implementations
cargo install --git https://github.com/bitcoindevkit/bdk-cli --features=compiler,compact_filters
# Get jq to parse JSON on the cli
# linux
sudo apt-get install jq
# mac
sudo brew install jq

# get repo
git clone https://github.com/vmenond/btccapital
cd btccapital
tree -d .

btccapital:
├── reserve - long
└── operations - medium
   ├── live - short-medium
   ├── payday - short	   
   └── resources - medium
```

Eg periods:

- long = 5 years
- medium = 1 year
- short = 1 month

<hr>

At the topmost branch we find two policies between board members of the organization:

## reserve

> A script requiring all board members.

When an investor represented by `btccapital` funds a business, it does so by funding the long term `reserve` first.

This is also where company revenue is collected.

From `reserve` funds, the board members decide how much will be required for operating over a medium term and according fund `operations`.

## operations

> A script requiring only a few board members.

Managing operations fund over a medium term need not require all board members.

From the operations fund, the elected board members must decide how much will be required for operating within a defined short term period.

<hr>

This leads us to the final branch of the tree that holds the various different business specific payment logic.

These are all scripts primarily maintained by the team as a whole or by elected members, based on their own internally conducted consensus over a chosen private social media channel. 

We have simplified it into three main cost streams. 

This is where the framework extends. Add your own folders here. Replace the existing ones. This section is meant to be the most customizable.

All the following scripts must be backed up to allow the board to release after a medium term timelock in case the team misplaces keys.

### live

> A single-sig script for the company's node server

Funded every short-medium term period.

This is the company's hot wallet used to make automated bitcoin payments.

This could include:
- domain registrar payment
- cloud server provider payments
- anything; as part of your application logic

### payday

> A script between the team members with a timelocked release.

Funded every short term period.

The idea here is that a script is funded up front BUT team members can only unlock funds in this wallet after a certain date aka payday.

A new script is created for every payday cycle.

The team must get together and arrive at consensus to enforce the payday scheme, resulting in a moment of strengthening trust.

The payday scheme is initially set with the team member and the board during onboarding. 

A team member is not obliged to agree to changes to the payday scheme proposed by other members during a specific cycle. 

However, if mutual consensus leads to a change for a given cycle, this is accepted by the board.

This gives the team a chance to be fair with each other and quickly pick out the weeds.

A team member can chose to sit out on consensus and just get paid on payday without the ceremonies.
 
### resources

> A script between delegated core team members.

Funded every medium term period.

These are funds that the team would need to aquire shared resources or as an emergency fund.

It is managed by a delegated core team selected by the board, in consensus with the rest of the team.

It is funded to exactly support a chosen `n` early renumerations for all team members for `n` short periods.

This gives everyone a chance to take an early payday `n` times over a medium period.

Those that take an advance are not included in the next payday cycle, and their payday amount is divided among other team members. 

The remainder of the funds at the end of the medium term cycle is distributed equally to all team members.


<b>Each sub-folder contains a more detailed explaination of their functions @ README.md.</b>
