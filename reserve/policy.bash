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

POLICY="thresh(3,pk($CTOCHILDPUB),pk($CEOCHILDPUB),pk($CFOCHILDPUB))"

DESC=$(bdk-cli compile "$POLICY" -t sh)

echo $DESC
