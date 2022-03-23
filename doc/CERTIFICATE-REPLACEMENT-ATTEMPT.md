### CA

**kubeconfig**
```bash
$ cat kubeconfig.yaml | yq '.clusters[].cluster.certificate-authority-data' | base64 -d
-----BEGIN CERTIFICATE-----
MIIBeDCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3Mtc2Vy
dmVyLWNhQDE2NDY4MjcxNjEwHhcNMjIwMzA5MTE1OTIxWhcNMzIwMzA2MTE1OTIx
WjAjMSEwHwYDVQQDDBhrM3Mtc2VydmVyLWNhQDE2NDY4MjcxNjEwWTATBgcqhkjO
PQIBBggqhkjOPQMBBwNCAAT6ACeu468COSPnfyLYDT2TnJV7sb16xfKMiKnWIe0H
EDkFR7QmPkrpXuDBA8HYyu73U8OJ4eca5P7jjBMKL6CFo0IwQDAOBgNVHQ8BAf8E
BAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU5sLbaeWvkiIBH0p7actQ
FcUfv+YwCgYIKoZIzj0EAwIDSQAwRgIhANXE/SYmyCGlclLTKy0evTWn2I1Ioofb
lXnlwC+zDs1dAiEAh3Ui1CwXzD5NvD6bP4RvyS3uPDwCT1ajemGXDwa7sjo=
-----END CERTIFICATE-----
```

**secret extraction**
```bash
$ kubectl get secrets -n team-d vc-vcluster-d -o jsonpath='{.data.certificate-authority}' | base64 -d
-----BEGIN CERTIFICATE-----
MIIBeDCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3Mtc2Vy
dmVyLWNhQDE2NDY4MjcxNjEwHhcNMjIwMzA5MTE1OTIxWhcNMzIwMzA2MTE1OTIx
WjAjMSEwHwYDVQQDDBhrM3Mtc2VydmVyLWNhQDE2NDY4MjcxNjEwWTATBgcqhkjO
PQIBBggqhkjOPQMBBwNCAAT6ACeu468COSPnfyLYDT2TnJV7sb16xfKMiKnWIe0H
EDkFR7QmPkrpXuDBA8HYyu73U8OJ4eca5P7jjBMKL6CFo0IwQDAOBgNVHQ8BAf8E
BAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU5sLbaeWvkiIBH0p7actQ
FcUfv+YwCgYIKoZIzj0EAwIDSQAwRgIhANXE/SYmyCGlclLTKy0evTWn2I1Ioofb
lXnlwC+zDs1dAiEAh3Ui1CwXzD5NvD6bP4RvyS3uPDwCT1ajemGXDwa7sjo=
-----END CERTIFICATE-----
```
---

### Client certificate

**kubeconfig**
```bash
$ cat kubeconfig.yaml | yq '.users[].user.client-certificate-data' | base64 -d
-----BEGIN CERTIFICATE-----
MIIBkjCCATegAwIBAgIIN2jXfw+xZbkwCgYIKoZIzj0EAwIwIzEhMB8GA1UEAwwY
azNzLWNsaWVudC1jYUAxNjQ2ODI3MTYxMB4XDTIyMDMwOTExNTkyMVoXDTIzMDMw
OTExNTkyMVowMDEXMBUGA1UEChMOc3lzdGVtOm1hc3RlcnMxFTATBgNVBAMTDHN5
c3RlbTphZG1pbjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABHkCvn4XKX74XwUi
7KMxMMdPVqsCIN2a+oGsbOmMlY7933utASNgMCKVmBCdlU6u77R9NynVBjETO3AO
mT8i7dKjSDBGMA4GA1UdDwEB/wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDAjAf
BgNVHSMEGDAWgBTtpdqGaMIK4OeJaRIwp4iLUPqL0TAKBggqhkjOPQQDAgNJADBG
AiEA9yt6ixBZSc7pW3ci8hf7yVVypbjuJVozGXuk33CDN4kCIQCGsrJ1pQewrs1D
HAyB8GyyvtKHqegaOpoMb4xTQ4myGg==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIBdzCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3MtY2xp
ZW50LWNhQDE2NDY4MjcxNjEwHhcNMjIwMzA5MTE1OTIxWhcNMzIwMzA2MTE1OTIx
WjAjMSEwHwYDVQQDDBhrM3MtY2xpZW50LWNhQDE2NDY4MjcxNjEwWTATBgcqhkjO
PQIBBggqhkjOPQMBBwNCAASGg1+mPsmzEHcSNIS3THu9HliMRsqhbu1dXR4TFlKO
P3el816ZmLkkHlZ79F2Ra03Vg39ipecPAUBbe1wkgo4eo0IwQDAOBgNVHQ8BAf8E
BAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU7aXahmjCCuDniWkSMKeI
i1D6i9EwCgYIKoZIzj0EAwIDSAAwRQIgM1hUApNqczPXdBHirc0UlsSY2XUjUwwE
KssofgjzvacCIQC7JkAqhfN4EZSdk39tS0wYvVHNCc/DUUz/s96NdM6uHQ==
-----END CERTIFICATE-----
```

**secret extraction**
```bash
$ kubectl get secrets -n team-d vc-vcluster-d -o jsonpath='{.data.client-certificate}' | base64 -d
-----BEGIN CERTIFICATE-----
MIIBkjCCATegAwIBAgIIN2jXfw+xZbkwCgYIKoZIzj0EAwIwIzEhMB8GA1UEAwwY
azNzLWNsaWVudC1jYUAxNjQ2ODI3MTYxMB4XDTIyMDMwOTExNTkyMVoXDTIzMDMw
OTExNTkyMVowMDEXMBUGA1UEChMOc3lzdGVtOm1hc3RlcnMxFTATBgNVBAMTDHN5
c3RlbTphZG1pbjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABHkCvn4XKX74XwUi
7KMxMMdPVqsCIN2a+oGsbOmMlY7933utASNgMCKVmBCdlU6u77R9NynVBjETO3AO
mT8i7dKjSDBGMA4GA1UdDwEB/wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDAjAf
BgNVHSMEGDAWgBTtpdqGaMIK4OeJaRIwp4iLUPqL0TAKBggqhkjOPQQDAgNJADBG
AiEA9yt6ixBZSc7pW3ci8hf7yVVypbjuJVozGXuk33CDN4kCIQCGsrJ1pQewrs1D
HAyB8GyyvtKHqegaOpoMb4xTQ4myGg==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIBdzCCAR2gAwIBAgIBADAKBggqhkjOPQQDAjAjMSEwHwYDVQQDDBhrM3MtY2xp
ZW50LWNhQDE2NDY4MjcxNjEwHhcNMjIwMzA5MTE1OTIxWhcNMzIwMzA2MTE1OTIx
WjAjMSEwHwYDVQQDDBhrM3MtY2xpZW50LWNhQDE2NDY4MjcxNjEwWTATBgcqhkjO
PQIBBggqhkjOPQMBBwNCAASGg1+mPsmzEHcSNIS3THu9HliMRsqhbu1dXR4TFlKO
P3el816ZmLkkHlZ79F2Ra03Vg39ipecPAUBbe1wkgo4eo0IwQDAOBgNVHQ8BAf8E
BAMCAqQwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU7aXahmjCCuDniWkSMKeI
i1D6i9EwCgYIKoZIzj0EAwIDSAAwRQIgM1hUApNqczPXdBHirc0UlsSY2XUjUwwE
KssofgjzvacCIQC7JkAqhfN4EZSdk39tS0wYvVHNCc/DUUz/s96NdM6uHQ==
-----END CERTIFICATE-----
```


### Client key


**kubeconfig:**
```bash
$ cat kubeconfig.yaml | yq '.users[].user.client-key-data' | base64 -d
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEINbf3SGkYfxnp+OeJ19wpv/4VW3ntwSpuz7Zc3VGzZDJoAoGCCqGSM49
AwEHoUQDQgAEeQK+fhcpfvhfBSLsozEwx09WqwIg3Zr6gaxs6YyVjv3fe60BI2Aw
IpWYEJ2VTq7vtH03KdUGMRM7cA6ZPyLt0g==
-----END EC PRIVATE KEY-----
```

**secret extraction:**
```bash
$ kubectl get secrets -n team-d vc-vcluster-d -o jsonpath='{.data.client-key}' | base64 -d
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEINbf3SGkYfxnp+OeJ19wpv/4VW3ntwSpuz7Zc3VGzZDJoAoGCCqGSM49
AwEHoUQDQgAEeQK+fhcpfvhfBSLsozEwx09WqwIg3Zr6gaxs6YyVjv3fe60BI2Aw
IpWYEJ2VTq7vtH03KdUGMRM7cA6ZPyLt0g==
-----END EC PRIVATE KEY-----
```

---

### Conclusion
As you can see secret fields are base for kubeconfig and must remain same otherwise connection will be demage!
Kubeconfig for vcluster is stored in .data.config wchich is a part of vc-vcluster secrete!

To extract kubeconfig is just simple step and can be find in [HINTS](./HINTS.md###Extract)
