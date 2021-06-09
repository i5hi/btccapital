#!/bin/bash

RPUBWALL=rpub91
AWALL=ra91
BWALL=rb91
CWALL=rc91


PUBDESC="wsh(and_v(or_c(pk([d8aae923/84'/1'/1']tpubDDUXg7Fp9HCUrDtBm8HbejsBjMeun2Zgzm2zgULzHWTwLy4286jr7SedMwbc1P2Yep6oUKoqqc7Lk3zCbiXyViECNstnjPBUjmDUmgfzuUy),v:pk([a6404c30/84'/1'/3']tpubDDFHfHwJ1h82pYRjzSUdUZzjpTb8CqunVr8pkp5EfZGUTqdHgLFgJEL56VfXYbJfDEUQjqPPGgy7n5Z6eck918yW1WDAAQgtdtEgMWEZgsm)),and_v(or_c(pk([3d6b435e/84'/1'/1']tpubDCZVUAnqysBtWoNeYS2eAy2SYagy61fpENmmQTRJd1bCPCKua5DDboNeJgmi7H68hewN2exoRdUff9yqgVAMDd1nMBQ1ut8FG57KEr8tEPq),v:pk([77c87c6d/84'/1'/3']tpubDDHeuwFMZ95i2WaFfK1GCGY3PEB6VmnTiQwVetdN4omsuVzzY2vDZr2GCDSq3c9iXNxXPYN1Tjvf6gQpxwiC9wZRZyroA77Cr3VhRRN4dnp)),or_b(pk([89fa0709/84'/1'/1']tpubDDV66i76Y3MXYmnKPrqXHbHhr5uUWTPNjpREmdDdXkXMc8wpdfkuJzWpExW4icpawbKYxPP2a5mPA132xTAxrchXqRsaz96NG2g7vDvUjMf),s:pk([45b25bc5/84'/1'/3']tpubDDV4rGLwzrHqdoQNtyKiFEoqCyjXUUXUXEz634ePBELdzqCDBNcpXhZEJQZjRYAxpKff8jnw6Wrpo6zG8EhUkAJp2yjBFBFgEdFY5G8h1tQ)))))"
ADESC="wpkh([89fa0709/84'/1'/1']tprv8go3xJ4rPffrfJkXWDAvtBdbH4PYM8CUAWpTV7BL7Uixmeh41GwK8Vtx4q1X2W2ZaFJF3HfDvWpGMDK3czcZk4XJJBZ6TYCAmPCmnpWeY15)"
BDESC="wpkh([77c87c6d/84'/1'/3']tprv8gbcmXD7QmQ393YTmfLfnrsvpCfALSbZ97LiNNb4eXyV51kDue6dPMQQ24DnEdQfMrya5aa6kqFej5M1TWhWuSQAt8pibE7xucpR2YRFBj9)"
CDESC="wpkh([d8aae923/84'/1'/1']tprv8gnVXhDZzuWoxkrPsUd1FLD5AL8ychNnRTSDPxJgsEfYWUoFVhvFvx2mBnuvFKdUZ84YcEHcCDXw1Wgdf3uafqJmGY5i369aMhopJyV3LWS)"

RETURNADD=mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt

bdk-cli wallet -w $PUBWALL -d $PUBDESC sync
bdk-cli wallet -w $PUBWALL -d $PUBDESC get_new_address
bdk-cli wallet -w $PUBWALL -d $PUBDESC get_balance

PSBT0=$(bdk-cli wallet -w $PUBWALL -d $PUBDESC create_tx -a --to $RETURNADD:0 | jq -r ".psbt")
# printf "$PSBT0"

# Sign or(C,C')

PSBTC=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBT0 | jq -r ".psbt")
# printf "$PSBTC"

# Sign or(B,B')

PSBTB=$(bdk-cli wallet -w $BWALL -d $BDESC sign --psbt $PSBT0 | jq -r ".psbt")
# printf "$PSBTB"

# Sign or(A,A')

PSBTA=$(bdk-cli wallet -w $AWALL -d $ADESC sign --psbt $PSBT0 | jq -r ".psbt")
# printf "$PSBTA"

# Combine and(or(B,B'),or(A,A'))

PSBTBA=$(bdk-cli wallet -w $PUBWALL -d $PUBDESC combine_psbt --psbt $PSBTB --psbt $PSBTA | jq -r ".psbt")

# Combine and(or(C,C'),and(or(B,B'),or(A,A'))) 

PSBTCBA=$(bdk-cli wallet -w $PUBWALL -d $PUBDESC combine_psbt --psbt $PSBTC --psbt $PSBTBA | jq -r ".psbt")

# printf "$PSBTCBA"

# Finalize 

bdk-cli wallet -w $PUBWALL -d $PUBDESC finalize_psbt --psbt $PSBTCBA
