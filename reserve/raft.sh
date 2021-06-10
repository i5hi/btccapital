#!/bin/bash

RPUBWALL=rpub7
AWALL=ra7
BWALL=rb7
CWALL=rc7

# fund tb1qm6ez5qgjuzf24vu5tt9cgt823xyjg98q7cvku0h60cruj3ay466qsrprwt
PUBDESC="wsh(and_v(or_c(pk([d7a564bd/84'/1'/1']tpubDDCerAGiUgsvLh3Ao2A8fyzQY8Rw9EKVc86Yvnxgc7HbYyPYdqSZWsK1d2wHr6oGSFLNdDCPa6prXZftvkp24eFLw2bcgZzkYgMY6WF8Ciy),v:pk([f4952635/84'/1'/3']tpubDDRtWtPvRFEGRPJbUbDL87EqxYdGKBq2hsiu9dJERnn8jt8J8Mqtxx8cnGvmB7hxknyLdzTJ8NKup7x2sBraRf1MEgE6kLrLLVHsYRNP7ug)),and_v(or_c(pk([bc389580/84'/1'/1']tpubDC8nuVod6JjRaTThYeSSTXEuHirD2kPhQjmNYXWn4Fb5ws7oMfk1VYhBK3iPN3BTjYPUSVGUgrsHd1murgHvUp59eZDYk8JcvNAoNN5BvUe),v:pk([f0027c9f/84'/1'/3']tpubDC6c9QqFtmULzdS6LiY2MfHDkU23LjwmqYt3UaEhdDD7L1RMDTPcGJtsAs1QqNbawQ4pvYM1yJL8ToCUHrXfKi7vsUx7Wjms8Qjj8TEWmzA)),or_b(pk([2509b026/84'/1'/1']tpubDD3RinqtPJKZ9erSAjYv9BnDdyZZpCS1eHmpBz2cXMtqpnjVz6nXEMpeC7YmPjYLrTggCHvAjuQyQwF7mTsyfwdG7DrT7zyWY3DmUWgXSSd),s:pk([ce8228b4/84'/1'/3']tpubDCirz5J8P8KfUrNWrGNxVXVr9PGeqo4i88wtagSW5JAZ7noMrZWvLUAKQfMFkHwqMZPa7ozTzakMijAPKDbfCP3XdtUUrwChcHSXGgmV3JU)))))"
ADESC="wpkh([d7a564bd/84'/1'/1']tprv8gWchkEULKCFTE1NuNVYGaLHy6uzyu8b2pVmeGvPBqVCiV8n1ScyLNh9St1NRaHJdVyxT6kEPDFpt98P2XABVmpgn3nDhrDi32WFe8Xkx3N)"
BDESC="wpkh([2509b026/84'/1'/1']tprv8gMPaNoeEvdtGBpeH5tKjn874x3desF74zB2uTzK766SzJUjMhxw3sCn1zNqHHDwVuxS8ibPvZYEU8ZEWXvaBMTfYHMsUqPuRU3spzzRycn)"
CDESC="wpkh([bc389580/84'/1'/1']tprv8fSkm5mNww3kgzRuezmr47anihLGsRCnqSAbG1UUdynh7Ns2jGvRK45K8tc1gNPqKnaXMmQucsHj4Mrc8gey9wsE3rcTJvtiWYSbYCti4xh)"

RETURNADD=mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt

bdk-cli wallet -w $RPUBWALL -d $PUBDESC sync
bdk-cli wallet -w $RPUBWALL -d $PUBDESC get_new_address
bdk-cli wallet -w $RPUBWALL -d $PUBDESC get_balance

PSBT0=$(bdk-cli wallet -w $RPUBWALL -d $PUBDESC create_tx -a --to $RETURNADD:0 | jq -r ".psbt")
# printf "$PSBT0"

# Sign or(C,C')

PSBTC=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBT0 | jq -r ".psbt")
STATE=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBT0 | jq -r ".is_finalized")

printf "$STATE\n"

# Sign or(B,B')

PSBTB=$(bdk-cli wallet -w $BWALL -d $BDESC sign --psbt $PSBT0 | jq -r ".psbt")
STATE=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBT0 | jq -r ".is_finalized")

printf "$STATE\n"

# Sign or(A,A')

PSBTA=$(bdk-cli wallet -w $AWALL -d $ADESC sign --psbt $PSBT0 | jq -r ".psbt")
STATE=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBT0 | jq -r ".is_finalized")

printf "$STATE\n"

# Combine and(or(B,B'),or(A,A'))

PSBTBA=$(bdk-cli wallet -w $RPUBWALL -d $PUBDESC combine_psbt --psbt $PSBTB --psbt $PSBTA | jq -r ".psbt")


# Combine and(or(C,C'),and(or(B,B'),or(A,A'))) 

PSBTCBA=$(bdk-cli wallet -w $RPUBWALL -d $PUBDESC combine_psbt --psbt $PSBTC --psbt $PSBTBA | jq -r ".psbt")


# printf "$PSBTCBA"

# Finalize 

bdk-cli wallet -w $RPUBWALL -d $PUBDESC finalize_psbt --psbt $PSBTCBA
