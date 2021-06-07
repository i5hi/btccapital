#!/bin/bash -e


# CREATE SEED AND MASTER ACCOUNT
CEOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CFOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")
CTOMASTERPRV=$(bdk-cli key generate | jq -r ".xprv")

# DERIVE CHILD KEYS
HDPATH="m/84h/1h/0h"

CEOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CTOCHILDPRV=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

# CREATE REGULAR 3/3 MULTI

PUBPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPUB),pk($CTOCHILDPUB))"
CEOPOLICY="thresh(3,pk($CEOCHILDPRV),pk($CFOCHILDPUB),pk($CTOCHILDPUB))"
CFOPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPRV),pk($CTOCHILDPUB))"
CTOPOLICY="thresh(3,pk($CEOCHILDPUB),pk($CFOCHILDPUB),pk($CTOCHILDPRV))"

# CREATE DESCRIPTORS

PUBDESC=$(bdk-cli compile "$PUBPOLICY" -t wsh)
CEODESC=$(bdk-cli compile "$CEOPOLICY" -t wsh)
CFODESC=$(bdk-cli compile "$CFOPOLICY" -t wsh)
CTODESC=$(bdk-cli compile "$CTOPOLICY" -t wsh)

# PRINT DESCRIPTORS TO FILE
FILE="descriptors.md"
touch $FILE
printf "# 3/3 MULTI\n\n" > $FILE

printf "## PUBLIC DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$PUBDESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CEO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CEODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CFO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CFODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CTO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CTODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE



# CREATE 3/3 MULTI w/BACKUPS

# DERIVE BACKUP KEYS 
HDPATH="m/84h/1h/1h"

CEOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CEOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CEOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CFOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CFOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CFOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)

CTOCHILDPRV1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xprv" | rev | cut -c3- | rev)
CTOCHILDPUB1=$(bdk-cli key derive --path $HDPATH --xprv $CTOMASTERPRV | jq -r ".xpub" | rev | cut -c3- | rev)


# CREATE POLICY w/ BACKUP KEYS

PUBPOLICY="thresh(3,or(pk($CEOCHILDPUB),pk($CEOCHILDPUB1)),or(pk($CFOCHILDPUB),pk($CFOCHILDPUB1)),or(pk($CTOCHILDPUB),pk($CTOCHILDPUB1)))"
CEOPOLICY="thresh(3,or(pk($CEOCHILDPRV),pk($CEOCHILDPRV1)),or(pk($CFOCHILDPUB),pk($CFOCHILDPUB1)),or(pk($CTOCHILDPUB),pk($CTOCHILDPUB1)))"
CFOPOLICY="thresh(3,or(pk($CEOCHILDPUB),pk($CEOCHILDPUB1)),or(pk($CFOCHILDPRV),pk($CFOCHILDPRV1)),or(pk($CTOCHILDPUB),pk($CTOCHILDPUB1)))"
CTOPOLICY="thresh(3,or(pk($CEOCHILDPUB),pk($CEOCHILDPUB1)),or(pk($CFOCHILDPUB),pk($CFOCHILDPUB1)),or(pk($CTOCHILDPRV),pk($CTOCHILDPRV1)))"

# CREATE DESCRIPTORS

PUBDESC=$(bdk-cli compile "$PUBPOLICY" -t wsh)
CEODESC=$(bdk-cli compile "$CEOPOLICY" -t wsh)
CFODESC=$(bdk-cli compile "$CFOPOLICY" -t wsh)
CTODESC=$(bdk-cli compile "$CTOPOLICY" -t wsh)

# PRINT DESCRIPTORS TO FILE
printf "\n\n# 3/3 MULTI w/BACKUP\n\n" >> $FILE

printf "## PUBLIC DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$PUBDESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CEO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CEODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CFO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CFODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

printf "## CTO PRIVATE DESCRIPTOR\n" >> $FILE
printf "\n\`\`\`\n" >> $FILE
printf "$CTODESC" | jq -r ".descriptor" >> $FILE
printf "\n\`\`\`\n" >> $FILE

