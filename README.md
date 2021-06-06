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
├── operations - medium
│   ├── live - short
│   ├── salary - short	   
│   └── resources - medium
└── reserve - long
```

Eg periods:

- long = 5 years
- medium = 1 year
- short = 1 month

At the topmost level we find two multi scripts between board members of the organization:

## reserve

> A script between the board members.

When an investor represented by `btccapital` funds a business, it does so by funding the long term `reserve` first.

This is also where company revenue is collected.

From `reserve` funds, the board members decide how much will be required for operating over a medium term and according fund `operations`.

## operations

> A script between the board members.


From operations fund, the board members  must then decide how much of their funds will be required for operating in the next short term.

They must first set a very short term cycle to get an idea of their spending propensity and accordingly set the time period and funds required.



This leads us to the final branches of the tree that holds the various different business specific payment logic.

We have simplified it into three main types. 

This is where the framework extends. Add your own folders here. Replace the existing ones. This section is meant to be the most customizable.

All the following scripts must be backed up to allow the board to release after a medium term timelock in case the team misplaces keys.

### live

> A script primarily for the company node server as a single sig.

Funded every short term period.

This is the company hot wallet used to make bitcoin payments to third party service providers.

This could include:
- domain registrars
- cloud server providers
- as part of your application logic (user rewards for example)

### salary

> A script primarily between the team members with a timelocked release.

Funded every short term period.

The idea here is that team members can only unlock funds in this wallet after a certain date.

A new script is created for every salary cycle.

The team must get together arrive at consensus to enforce the salary scheme, resulting in a moment of strengthening trust.

It is best not to require all members, rather delegate members of your team to enforce it on your behalf and use a chat platform to discuss the terms.

<b>Each folder contains a more detailed explaination of their functions @ README.md.</b>

### resources

> A script primarily between the team members without a timelocked release.

Funded every medium term period.

These are funds that the team would need to aquire shared resources or as an emergency fund.

It belongs to the entire team and is created for every medium term as their reserve.

It is funded to exactly support early salary for all team members for n short periods.

This gives everyone a chance to take an early salary n times over a medium period.

Those two take an advance are not included in the next short period's salary script, and their salary is divided among other team members. 

This is again a script that requires consensus from the team.

If these funds are not used over a medium term, they are free to claim it as a bonus.


