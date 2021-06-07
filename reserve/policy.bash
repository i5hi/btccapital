#!/bin/bash -e

HDPATH="m/84h/1h/0h"

CTOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CEOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CFOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")

CTOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CEOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

TPOLICY="thresh(3,pk($CTOCHILDPUB),pk($CEOCHILDPUB),pk($CFOCHILDPUB))"
DESC=$(bdk-cli compile "$TPOLICY" -t wsh)

echo "\nTHRESHOLD POLICY DESCRIPTOR:\n"
echo $DESC

HDPATH="m/84h/1h/1h"

CTOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CEOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

AOPOLICY="thresh(3,or(pk($CTOCHILDPUB),pk($CTOCHILDPUB1)),or(pk($CEOCHILDPUB),pk($CEOCHILDPUB1)),or(pk($CFOCHILDPUB),pk($CFOCHILDPUB1)))"

DESC=$(bdk-cli compile "$AOPOLICY" -t wsh)

echo "\nAND_OR POLICY DESCRIPTOR:\n"
echo $DESC
