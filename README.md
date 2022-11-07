Proof of Concept that adds an ec2 repo with ssm patching support

usage:
Before executing terraform plan/terraform apply

Create file dev/secret.tf and insert login crdentials

```
var secret_key {
  type = string,
  value = "***********"
}

var access_key {
  type = string,
  value =  "**********"
}
```


Testing a mermaid diagram
```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```

```mermaid
erDiagram
    CUSTOMER }|..|{ DELIVERY-ADDRESS : has
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER ||--o{ INVOICE : "liable for"
    DELIVERY-ADDRESS ||--o{ ORDER : receives
    INVOICE ||--|{ ORDER : covers
    ORDER ||--|{ ORDER-ITEM : includes
    PRODUCT-CATEGORY ||--|{ PRODUCT : contains
    PRODUCT ||--o{ ORDER-ITEM : "ordered in"
```

