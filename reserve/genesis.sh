#!/bin/bash -e

# multi
MPUBWALL=mpub1
# raft
RPUBWALL=rpub1
# The above must be consistant across all shell scripts.

# SIMULATE HARDWARE WALLET SEEDS AND ACCOUNTS FOR 3 SIGNATORIES
CEOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CFOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CTOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")

HDPATH="m/84h/1h/1h"

CEOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CTOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

# CREATE REGULAR 3/3 MULTI POLICIES 
PUBPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPUB),pk($CTOCHILDPUB))"

CEOPOLICY="thresh(3,pk($CEOCHILDPRV),pk($CFOCHILDPUB),pk($CTOCHILDPUB))"
CFOPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPRV),pk($CTOCHILDPUB))"
CTOPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPUB),pk($CTOCHILDPRV))"

PUBDESC=$(bdk-cli compile "$PUBPOLICY" -t wsh  | jq -r ".descriptor")
CEODESC=$(bdk-cli compile "$CEOPOLICY" -t wsh)
CFODESC=$(bdk-cli compile "$CFOPOLICY" -t wsh)
CTODESC=$(bdk-cli compile "$CTOPOLICY" -t wsh)

# GET AN ADDRESS TO FUND
bdk-cli wallet -w $MPUBWALL -d $PUBDESC sync
FUNDADDR=$( bdk-cli wallet -w $MPUBWALL -d $PUBDESC get_new_address | jq -r ".address" )

# PRINT MULTI DESCRIPTORS AND ADDRESS TO DFILE
DFILE="descriptors.md"
touch $DFILE
printf "# MULTI\n\n" > $DFILE

printf "## PUBLIC DESCRIPTOR\n" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "$PUBDESC" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE

printf "## A PRIVATE DESCRIPTOR\n" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "$CEODESC" | jq -r ".descriptor" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE

printf "## B PRIVATE DESCRIPTOR\n" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "$CFODESC" | jq -r ".descriptor" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE

printf "## C PRIVATE DESCRIPTOR\n" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "$CTODESC" | jq -r ".descriptor" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE

printf "\n\n# MULTI FUND ADDRESS \n\n" >> $DFILE
printf "$FUNDADDR" >> $DFILE

# CREATE RAFT

# SIMULATE HARDWARE WALLET SEEDS AND ACCOUNTS FOR 3 SIGNATORIES
CEOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CFOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CTOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")

HDPATH="m/84h/1h/3h"

CEOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CTOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)


# CREATE PUBLIC POLICY / DESCRIPTOR MAINTAINED BY THE SERVER
PUBPOLICY="thresh(3,or(pk($CEOCHILDPUB),pk($CEOCHILDPUB1)),or(pk($CFOCHILDPUB),pk($CFOCHILDPUB1)),or(pk($CTOCHILDPUB),pk($CTOCHILDPUB1)))"
PUBDESC=$(bdk-cli compile "$PUBPOLICY" -t wsh | jq -r ".descriptor")
# GET A RAFT ADDRESS TO FUND
bdk-cli wallet -w $RPUBWALL -d $PUBDESC sync
FUNDADDR=$( bdk-cli wallet -w $RPUBWALL -d $PUBDESC get_new_address | jq -r ".address" )

# PRINT RAFT DESCRIPTORS AND ADDRESS TO DFILE
printf "\n\n# RAFT \n\n" >> $DFILE
printf "## PUBLIC DESCRIPTOR\n" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "$PUBDESC" >> $DFILE
printf "\n\`\`\`\n" >> $DFILE
printf "\n\n# RAFT FUND ADDRESS \n\n" >> $DFILE
printf "$FUNDADDR\n" >> $DFILE

# WRITE KEYS TO FILE
KFILE="keys.md"

touch $KFILE
printf "# KEYS \n\n" > $KFILE

printf "## CEO \n" >> $KFILE
printf "$CEOCHILDPRV\n"  >> $KFILE
printf "$CEOCHILDPRV1\n"  >> $KFILE

printf "## CFO\n" >> $KFILE
printf "$CFOCHILDPRV\n"  >> $KFILE
printf "$CFOCHILDPRV1\n"  >> $KFILE


printf "## CTO\n" >> $KFILE
printf "$CTOCHILDPRV\n"  >> $KFILE
printf "$CTOCHILDPRV1\n"  >> $KFILE


exit 0
