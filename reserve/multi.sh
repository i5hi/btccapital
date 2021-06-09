#!/bin/bash

MPUBWALL=mpub51
AWALL=ma51
BWALL=mb51
CWALL=mc51


PUBDESC="wsh(multi(3,[b4e9f331/84'/1'/1']tpubDC69ZpQmVXAcSbYBXSi1dGPU9jqw1K6qfTQKAQAVggVLL5xCgz6J2oTVMa2JCXRz8rNTfMS14JzEa5oDguTWudfxKJCn1s8Pqim5LBGxZ7d,[1d13b52b/84'/1'/1']tpubDDG4omDmgjUMhxpF878xeudtFCuEwyyrnBmTXD9TrkDzPwXR6njXGSBPBs7Ri5hbyELTe4M8ZRsXs2VAUcV5wp9yXAJnsnJnRzchWvr3xyL,[9b10a92b/84'/1'/1']tpubDCWJhQCUK3qvp3bxvgHY4RiTJ7YZqQWXApfbBc55ypzS9CmuJWNFWjeTq5sYhnt13se7h4TL41PYc1Jt5DgmmUtFqU7CEZwtM31dADTD5JL))"
ADESC="wsh(multi(3,[b4e9f331/84'/1'/1']tprv8fQ7RQNXM9UwZ8WPdo3RDrjMaiKzqyuw69oXst8CGQgwVbhS4bGhrJqdBQgn61ipq5WFjxT5SqqsQUeGNqD7XvZxQ6rm4BL3Yzz5QySnfWm,[1d13b52b/84'/1'/1']tpubDDG4omDmgjUMhxpF878xeudtFCuEwyyrnBmTXD9TrkDzPwXR6njXGSBPBs7Ri5hbyELTe4M8ZRsXs2VAUcV5wp9yXAJnsnJnRzchWvr3xyL,[9b10a92b/84'/1'/1']tpubDCWJhQCUK3qvp3bxvgHY4RiTJ7YZqQWXApfbBc55ypzS9CmuJWNFWjeTq5sYhnt13se7h4TL41PYc1Jt5DgmmUtFqU7CEZwtM31dADTD5JL))"
BDESC="wsh(multi(3,[b4e9f331/84'/1'/1']tpubDC69ZpQmVXAcSbYBXSi1dGPU9jqw1K6qfTQKAQAVggVLL5xCgz6J2oTVMa2JCXRz8rNTfMS14JzEa5oDguTWudfxKJCn1s8Pqim5LBGxZ7d,[1d13b52b/84'/1'/1']tprv8ga2fMBXYMngpVnTETUNFVymgBPJnenxCtAgEh7ASURbZTGeUPuw5wZX1kHczUacUqnvcHxeyn82MRhhwEQn5xGH2biyxYJzq5M6EP4X5Ne,[9b10a92b/84'/1'/1']tpubDCWJhQCUK3qvp3bxvgHY4RiTJ7YZqQWXApfbBc55ypzS9CmuJWNFWjeTq5sYhnt13se7h4TL41PYc1Jt5DgmmUtFqU7CEZwtM31dADTD5JL))"
CDESC="wsh(multi(3,[b4e9f331/84'/1'/1']tpubDC69ZpQmVXAcSbYBXSi1dGPU9jqw1K6qfTQKAQAVggVLL5xCgz6J2oTVMa2JCXRz8rNTfMS14JzEa5oDguTWudfxKJCn1s8Pqim5LBGxZ7d,[1d13b52b/84'/1'/1']tpubDDG4omDmgjUMhxpF878xeudtFCuEwyyrnBmTXD9TrkDzPwXR6njXGSBPBs7Ri5hbyELTe4M8ZRsXs2VAUcV5wp9yXAJnsnJnRzchWvr3xyL,[9b10a92b/84'/1'/1']tprv8fpGYzAEAgAFvaaB32cwf24Lj62dg5KcbX4ou62nZZC3JiX8g7YfLF2beySXThHkvesgzjVrvS3F3x3ahsXGyuPUKCudCxdFCCATi3n68jR))"

RETURNADD=mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt

bdk-cli wallet -w $MPUBWALL -d $PUBDESC sync
bdk-cli wallet -w $MPUBWALL -d $PUBDESC get_new_address
bdk-cli wallet -w $MPUBWALL -d $PUBDESC get_balance

PSBT0=$(bdk-cli wallet -w $MPUBWALL -d $PUBDESC create_tx -a --to $RETURNADD:0 | jq -r ".psbt")
# printf "$PSBT0"

# A Signs and forwards to B

PSBTA=$(bdk-cli wallet -w $AWALL -d $ADESC sign --psbt $PSBT0 | jq -r ".psbt")  
# bdk-cli wallet -w $AWALL -d $ADESC sign --psbt $PSBT0
# printf "$PSBTA"

# B Signs and forwards to C

PSBTB=$(bdk-cli wallet -w $BWALL -d $BDESC sign --psbt $PSBTA | jq -r ".psbt")
# printf "$PSBTB"

# C Signs and forwards to server

PSBTC=$(bdk-cli wallet -w $CWALL -d $CDESC sign --psbt $PSBTB | jq -r ".psbt")

# printf "$PSBTC"


# Broadcast 
bdk-cli wallet -w $CWALL -d $CDESC broadcast --psbt $PSBTC

