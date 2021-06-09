#!/bin/bash

MPUBWALL=mpub55
AWALL=ma55
BWALL=mb55
CWALL=mc55


PUBDESC="wsh(multi(3,[5c2d0df1/84'/1'/1']tpubDDeH77RCJ2k7buYymiqs77Fs7VFmXuxYUWYiTL4Lm4BqeRNrkfYEugi4vExQHjH4uFFzmyfb7KUAkmbSRwaaVdU7nL6BdQsjp6STaE99GGv,[ecf17a88/84'/1'/1']tpubDCcZfSBxYVMu3LWKhkaoFiwyP7iGGyMXEu72wjM1KGr7cBTxQS13zB6UCVvUNwkwx2K4Xv4YkezafnVLzCH5pashQwigTW4brV1SgDKhtLQ,[9e4ffa64/84'/1'/1']tpubDDkx8RgEFx41eFRzRUpWf4pSjf58px5Gb2CbUgkojcc9AWs5BHrCvG1mxCsErqF3q73D1CuCeVo73uQTQNFm46QdH7ueXn3VAujJAiiadc5))#y7r8jnz9"
ADESC="wsh(multi(3,[5c2d0df1/84'/1'/1']tprv8gxExhNx9f4SiSXBt5BGhhbkYTjqNamduCwwAp23LnPSow868GiejC6Ck8BGxGpXFfMcPZoP5QqsF2XsSy8tmowJ7a8LYw3NcQn1wszCuEA,[ecf17a88/84'/1'/1']tpubDCcZfSBxYVMu3LWKhkaoFiwyP7iGGyMXEu72wjM1KGr7cBTxQS13zB6UCVvUNwkwx2K4Xv4YkezafnVLzCH5pashQwigTW4brV1SgDKhtLQ,[9e4ffa64/84'/1'/1']tpubDDkx8RgEFx41eFRzRUpWf4pSjf58px5Gb2CbUgkojcc9AWs5BHrCvG1mxCsErqF3q73D1CuCeVo73uQTQNFm46QdH7ueXn3VAujJAiiadc5))#t7un3l9x"
BDESC="wsh(multi(3,[5c2d0df1/84'/1'/1']tpubDDeH77RCJ2k7buYymiqs77Fs7VFmXuxYUWYiTL4Lm4BqeRNrkfYEugi4vExQHjH4uFFzmyfb7KUAkmbSRwaaVdU7nL6BdQsjp6STaE99GGv,[ecf17a88/84'/1'/1']tprv8fvXX29iQ7gE9sUXp6vCrKHrp6CL7eAcfbWFfDJhu13imhDBn3BTogUc2LWKXDTw6GHhwcYWZR5Qa3G7jkGuHmMd9PXeXoRbpdqX2MZrM5Q,[9e4ffa64/84'/1'/1']tpubDDkx8RgEFx41eFRzRUpWf4pSjf58px5Gb2CbUgkojcc9AWs5BHrCvG1mxCsErqF3q73D1CuCeVo73uQTQNFm46QdH7ueXn3VAujJAiiadc5))#55krtcwf"
CDESC="wsh(multi(3,[5c2d0df1/84'/1'/1']tpubDDeH77RCJ2k7buYymiqs77Fs7VFmXuxYUWYiTL4Lm4BqeRNrkfYEugi4vExQHjH4uFFzmyfb7KUAkmbSRwaaVdU7nL6BdQsjp6STaE99GGv,[ecf17a88/84'/1'/1']tpubDCcZfSBxYVMu3LWKhkaoFiwyP7iGGyMXEu72wjM1KGr7cBTxQS13zB6UCVvUNwkwx2K4Xv4YkezafnVLzCH5pashQwigTW4brV1SgDKhtLQ,[9e4ffa64/84'/1'/1']tprv8h4uz1dz7aNLknQCXq9vFfALAdZCfctN1ibpCAiWKLokL2cJYu2cjmPun65jBHfPKHP2Hwqn3N46eQaPeKYcRsqbbHGEWDwwcSnpHgpfkxT))#wt4gkv8s"

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

# Combine all & Finalize 

# PSBTCOM=$(bdk-cli wallet -w $MPUBWALL -d $PUBDESC combine_psbt --psbt $PSBTA --psbt $PSBTB --psbt $PSBTC | jq -r ".psbt")
# PSBTFIN=$(bdk-cli wallet -w $MPUBWALL -d $PUBDESC finalize_psbt --psbt $PSBTC | jq -r ".psbt")

# Broadcast 
# bdk-cli wallet -w $CWALL -d $CDESC broadcast --psbt $PSBTC

bdk-cli wallet -w $MPUBWALL -d $PUBDESC broadcast --psbt $PSBTC
