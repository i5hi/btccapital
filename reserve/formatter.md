# Format

A pretty printer for miniscript with the following format could be a really useful tool.

## Generic
```
wsh(
    and_v(
        or_c(
            pk(A),
            v:pk(A')
        ),
        and_v(
            or_c(
                pk(B),
                v:pk(B')
            ),
            or_b(
                pk(C),
                s:pk(C')
            )
        )
    )
)
```

## XKeys
```
wsh(
    and_v(
        or_c(
            pk(
                [af3b3fbb/84'/1'/0']tpubDCJ4zRGM6S575M7VZXRj34tDNXEE2GETwgB9WKXj7fY8oEJyPLUNRUgDBAwrf8mq6UyCPJVgHCquPRHyESXJfMS2u47fzTWsG3EPL2Nywy8
            ),
            v:pk(
                [af3b3fbb/84'/1'/1']tpubDCJ4zRGM6S579JVLjeLqTJX9k8WFQ1JyV7KGWe36ynqHGdsKYYfSLWhZqycayyLURvZPBz3dgsAQVBYZbsYBCcd82rqPTWLd4yCPkeco7Bq
            )
        ),
        and_v(
            or_c(
                pk(
                    [8e223f3e/84'/1'/0']tpubDCFHmQchsUZGEMm8wFNGGZYev4xMo7R55jwo1JdHkHdU98m3wQVXxdgUAiiNkFbCyNG9goZsNohovfSPN7Wy5Gmb3c2sJb9dtsht5G4vfQw
                ),
                v:pk(
                    [8e223f3e/84'/1'/1']tpubDCFHmQchsUZGHuPMn9QBkzrEomUqyfMpNA49fdAN194Uza3KMSSkkSREagUzH9q52ubDgJZQa4figM8miSJxpj2ifcuer6DQu6rvhAc9VNX
                )
            ),
            or_b(
                pk(
                    [f65f1544/84'/1'/0']tpubDDKAoYjKZrRFqg78AyxH3e4DJv4SDDvsqYytfcgH2ZSLSkesmtJExhDfVeqDbm3GPsxe9tBTordi6JAxEtdx7ryi4U1d5wWUqoD7tr9hhFK
                ),
                s:pk(
                    [f65f1544/84'/1'/1']tpubDDKAoYjKZrRFtoijmP9FHRNWexs13qcpeitLJx9Dgt7L7vF9Mb2j5RmeNCX3oJQHAFBAdh59ZuxVrPeTBeEffKDjPgfSGwHHigqmR7SEofC
                )
            )
        )
    )
)#j5krfnll
```
