# btccapital 

An open-source model for building bitcoin native organizations.

## overview

`btcapital` is the topmost level of an organization, representing the individual/group bringing capital into the organization.

`btccapital` flows down into an organization where each level is defined by a type of bitcoin spending policy.

This usually originates from a single signature or many single signatures each representing an signle investor. 

There could be cases where a group of investors start at this level out of a multi-signature, for example a capital fund.


```bash

git clone https://github.com/vmenond/btccapital
cd btccapital
tree -d .

btccapital:
├── reserve - long
└── operations - medium
   ├── live - short
   ├── renumeration - short	   
   └── resources - medium
```

Eg periods:

- long = 5 years
- medium = 1 year
- short = 1 month

At the topmost branch we find two scripts between board members of the organization:

## reserve

> A script between the board members.

When an investor represented by `btccapital` funds a business, it does so by funding the long term `reserve` first.

This is also where company revenue is collected.

From `reserve` funds, the board members decide how much will be required for operating over a medium term and according fund `operations`.

## operations

> A script between the board members.

From operations fund, the board members must then decide how much of their funds will be required for operating within a defined short term period.

They must first set a very short term cycle to get an idea of their spending propensity and accordingly adjust the time period and funds required.

<hr>

This leads us to the final branch of the tree that holds the various different business specific payment logic.

These are all scripts primarily maintained by the team as a whole based on their own internally conducted consensus over a chosen private social media channel. 

We have simplified it into three main types. 

This is where the framework extends. Add your own folders here. Replace the existing ones. This section is meant to be the most customizable.

All the following scripts must be backed up to allow the board to release after a medium term timelock in case the team misplaces keys.

### live

> A script for the company node server as a single sig.

Funded every short term period.

This is the company hot wallet used to make bitcoin payments to third party service providers.

This could include:
- domain registrars
- cloud server providers
- as part of your application logic (user rewards for example)

### renumeration

> A script between the team members with a timelocked release.

Funded every short term period.

The idea here is that team members can only unlock funds in this wallet after a certain date.

A new script is created for every renumeration cycle.

The team must get together arrive at consensus to enforce the renumerations scheme, resulting in a moment of strengthening trust.

It is best not to require all members, rather delegate members of your team to enforce it on your behalf and use a chat platform to discuss the terms.

### resources

> A script between the team members without a timelocked release.

Funded every medium term period.

These are funds that the team would need to aquire shared resources or as an emergency fund.

It belongs to the entire team and is created for every medium term as their reserve.

It is funded to exactly support early renumeration for all team members for n short periods.

This gives everyone a chance to take an early renumeration n times over a medium period.

Those two take an advance are not included in the next short period's renumeration script, and their renumerations is divided among other team members. 

This is again a script that requires consensus from the team.

If these funds are not used over a medium term, they are free to claim it as a bonus.


<b>Each sub-folder contains a more detailed explaination of their functions @ README.md.</b>
