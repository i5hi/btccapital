#!/bin/bash

DESC="wsh(and_v(or_c(pk([d8aae923/84'/1'/1']tpubDDUXg7Fp9HCUrDtBm8HbejsBjMeun2Zgzm2zgULzHWTwLy4286jr7SedMwbc1P2Yep6oUKoqqc7Lk3zCbiXyViECNstnjPBUjmDUmgfzuUy),v:pk([a6404c30/84'/1'/3']tpubDDFHfHwJ1h82pYRjzSUdUZzjpTb8CqunVr8pkp5EfZGUTqdHgLFgJEL56VfXYbJfDEUQjqPPGgy7n5Z6eck918yW1WDAAQgtdtEgMWEZgsm)),and_v(or_c(pk([3d6b435e/84'/1'/1']tpubDCZVUAnqysBtWoNeYS2eAy2SYagy61fpENmmQTRJd1bCPCKua5DDboNeJgmi7H68hewN2exoRdUff9yqgVAMDd1nMBQ1ut8FG57KEr8tEPq),v:pk([77c87c6d/84'/1'/3']tpubDDHeuwFMZ95i2WaFfK1GCGY3PEB6VmnTiQwVetdN4omsuVzzY2vDZr2GCDSq3c9iXNxXPYN1Tjvf6gQpxwiC9wZRZyroA77Cr3VhRRN4dnp)),or_b(pk([89fa0709/84'/1'/1']tpubDDV66i76Y3MXYmnKPrqXHbHhr5uUWTPNjpREmdDdXkXMc8wpdfkuJzWpExW4icpawbKYxPP2a5mPA132xTAxrchXqRsaz96NG2g7vDvUjMf),s:pk([45b25bc5/84'/1'/3']tpubDDV4rGLwzrHqdoQNtyKiFEoqCyjXUUXUXEz634ePBELdzqCDBNcpXhZEJQZjRYAxpKff8jnw6Wrpo6zG8EhUkAJp2yjBFBFgEdFY5G8h1tQ)))))#m3a42exm"
WALL=test67
RETURNADD=mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt

bdk-cli wallet -w $WALL -d $DESC sync
bdk-cli wallet -w $WALL -d $DESC get_new_address
bdk-cli wallet -w $WALL -d $DESC get_balance

PSBT=$(bdk-cli wallet -w $WALL -d $DESC create_tx -a --to $RETURNADD:0 | jq -r ".psbt")

