## 8.1.3 (2026-02-25)

### Code Refactoring

* **gitlab MR template:** ♻️ update default reviewers group with Azure Factory 🔧 6d106d2

### Miscellaneous Chores

* **deps:** 🔗 bump tflint rules and example 3f3a69b
* **deps:** update dependency tflint to v0.61.0 49d7b3f
* **deps:** update dependency trivy to v0.69.1 03131fa
* **deps:** update pre-commit hook crate-ci/committed to v1.1.11 edd3468

## 8.1.2 (2026-02-02)

### Documentation

* 📚️ fix examples 1c6b24a

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.10.7 9ad444b
* **deps:** update dependency opentofu to v1.11.2 6895e52
* **deps:** update dependency opentofu to v1.11.3 e7dc042
* **deps:** update dependency opentofu to v1.11.4 d11e8cb
* **deps:** update dependency pre-commit to v4.4.0 5e55583
* **deps:** update dependency pre-commit to v4.5.0 e181ad0
* **deps:** update dependency pre-commit to v4.5.1 cfd3de8
* **deps:** update dependency tflint to v0.60.0 77142c6
* **deps:** update dependency trivy to v0.67.2 c0add9b
* **deps:** update dependency trivy to v0.68.1 93658d2
* **deps:** update dependency trivy to v0.68.2 77a6b8c
* **deps:** update dependency trivy to v0.69.0 9eadb3b
* **deps:** update pre-commit hook crate-ci/committed to v1.1.10 ddf76b5
* **deps:** update pre-commit hook crate-ci/committed to v1.1.8 9085361
* **deps:** update pre-commit hook crate-ci/committed to v1.1.9 b37c645
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.2 8b3360b
* **deps:** update tools d9e11df

## 8.1.1 (2025-10-09)

### Code Refactoring

* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 b99511f
* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 e727829

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review 4d504a3
* 🗑️ remove old commitlint configuration files 21a035f
* **deps:** 🔗 bump AzureRM provider version to v4.31+ 0705138
* **deps:** update dependency claranet/diagnostic-settings/azurerm to ~> 8.1.0 4529cb8
* **deps:** update dependency opentofu to v1.10.0 85b549f
* **deps:** update dependency opentofu to v1.10.1 ff07990
* **deps:** update dependency opentofu to v1.10.3 308eff1
* **deps:** update dependency opentofu to v1.10.6 750cd61
* **deps:** update dependency tflint to v0.58.0 751cc33
* **deps:** update dependency tflint to v0.58.1 0f82ea0
* **deps:** update dependency tflint to v0.59.1 7c997ca
* **deps:** update dependency trivy to v0.62.1 d9c2cd0
* **deps:** update dependency trivy to v0.63.0 ad21db7
* **deps:** update dependency trivy to v0.66.0 3386ad6
* **deps:** update dependency trivy to v0.67.0 9a39480
* **deps:** update dependency trivy to v0.67.1 e55dddc
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 12a4212
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 7b74aa6
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 8.2.0 c3cdc32
* **deps:** update tools b3846ed
* **deps:** update tools d0cf78a
* **deps:** update tools 0daa2f1

## 8.1.0 (2025-05-05)

### Features

* change it to set of object to enable multiple operator in thew same eventhub subscription 67797f2

### Documentation

* 📚️ add example with advanced filters 55bcc25
* 📚️ update README b999899

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.6 c458e19
* **deps:** update dependency opentofu to v1.8.8 b67ace3
* **deps:** update dependency opentofu to v1.9.0 ded241b
* **deps:** update dependency opentofu to v1.9.1 ae40439
* **deps:** update dependency pre-commit to v4.1.0 4ea69da
* **deps:** update dependency pre-commit to v4.2.0 ba4e5ef
* **deps:** update dependency terraform-docs to v0.20.0 48a393c
* **deps:** update dependency tflint to v0.55.0 10ddaf8
* **deps:** update dependency tflint to v0.57.0 76d7a4a
* **deps:** update dependency trivy to v0.58.1 fb0a1f9
* **deps:** update dependency trivy to v0.58.2 a301907
* **deps:** update dependency trivy to v0.59.1 f4401e2
* **deps:** update dependency trivy to v0.60.0 62287f8
* **deps:** update dependency trivy to v0.61.1 7453f20
* **deps:** update dependency trivy to v0.62.0 01d6903
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 0754fbe
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 ca5807e
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 ed69b81
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 9a8c3d5
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 13d25de
* **deps:** update tools 65c48c3
* **deps:** update tools 2daf6ca
* **deps:** update tools ebae4d2
* update Github templates 43ec691
* update tflint config for v0.55.0 05164d5

## 8.0.0 (2024-11-22)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** module v8 structure and updates b8128d0

### Documentation

* **AZ-1088:** add location_short option in rg examples 3720bad
* **AZ-1088:** comment logs configuration in examples 4f03352
* **AZ-1088:** fix key vault module calls e9a505c
* **AZ-1088:** fix rg module calls 8d66b8b
* update examples 8493f94

### Miscellaneous Chores

* apply suggestion(s) to 3 file(s) e64a6bc
* **AZ-1088:** apply suggestions 949e7b8
* **deps:** update dependency claranet/diagnostic-settings/azurerm to v8 f9dc78d
* **deps:** update dependency opentofu to v1.8.4 ba893c3
* **deps:** update dependency pre-commit to v4.0.1 0ed62ce
* **deps:** update dependency tflint to v0.54.0 0d2ff82
* **deps:** update dependency trivy to v0.56.2 6dd74b7
* **deps:** update dependency trivy to v0.57.1 2144194
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 d3af08d
* **deps:** update tools 30ac45e
* update examples structure 421883b

## 7.4.1 (2024-10-08)

### Documentation

* update submodule READMEs with latest template 5e3cc7e

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 a2ec844
* **deps:** update dependency opentofu to v1.8.3 a9ccf31
* **deps:** update dependency pre-commit to v4 bc4d6c8
* **deps:** update dependency trivy to v0.56.0 f73cfb0
* **deps:** update dependency trivy to v0.56.1 d923d2d
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 7bdc16a
* prepare for new examples structure 589aa74

## 7.4.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 24ee053

### Documentation

* update README badge to use OpenTofu registry b374891
* update README with `terraform-docs` v0.19.0 76a8a13
* update submodule README with `terraform-docs` v0.19.0 d6f6fe5

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] d1ad2b7
* **AZ-1391:** update semantic-release config [skip ci] e541030

### Miscellaneous Chores

* **deps:** add renovate.json 9e872d7
* **deps:** enable automerge on renovate ddc96b3
* **deps:** update dependency opentofu to v1.7.0 4e31124
* **deps:** update dependency opentofu to v1.7.1 ba6ab5a
* **deps:** update dependency opentofu to v1.7.2 27b8b13
* **deps:** update dependency opentofu to v1.7.3 c5092b9
* **deps:** update dependency opentofu to v1.8.0 dd5f1fe
* **deps:** update dependency opentofu to v1.8.1 0a3aa83
* **deps:** update dependency pre-commit to v3.7.1 dc7b71a
* **deps:** update dependency pre-commit to v3.8.0 ef8ecf5
* **deps:** update dependency terraform-docs to v0.18.0 80e7f27
* **deps:** update dependency tflint to v0.51.0 f863e74
* **deps:** update dependency tflint to v0.51.1 b956810
* **deps:** update dependency tflint to v0.51.2 7c1d603
* **deps:** update dependency tflint to v0.52.0 3135372
* **deps:** update dependency tflint to v0.53.0 252bd66
* **deps:** update dependency trivy to v0.50.2 acfb42b
* **deps:** update dependency trivy to v0.50.4 f991fa3
* **deps:** update dependency trivy to v0.51.0 5aa6f1c
* **deps:** update dependency trivy to v0.51.1 622e646
* **deps:** update dependency trivy to v0.51.2 26c05ec
* **deps:** update dependency trivy to v0.51.4 4a15ecd
* **deps:** update dependency trivy to v0.52.0 586ad30
* **deps:** update dependency trivy to v0.52.1 fded472
* **deps:** update dependency trivy to v0.52.2 adf7055
* **deps:** update dependency trivy to v0.53.0 9dc762b
* **deps:** update dependency trivy to v0.54.1 f21d915
* **deps:** update dependency trivy to v0.55.0 dfb1c86
* **deps:** update dependency trivy to v0.55.1 c62f82c
* **deps:** update dependency trivy to v0.55.2 7767935
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 18c4a3d
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 f5c81ee
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 adcbc43
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 c96c5ee
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 9ccb6ea
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 63976c6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 ce78746
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 a4364d9
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 4609fa8
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 e8ecddc
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 3a8c064
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 4aba299
* **deps:** update renovate.json 5b7e491
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 6.5.0 ff0f882
* **deps:** update tools 41a77a8
* **deps:** update tools 8c594d8
* **pre-commit:** update commitlint hook 3d07c72
* **release:** remove legacy `VERSION` file b777261

# v7.3.1 - 2023-11-10

Fixed
  * AZ-1205: Fix naming

# v7.3.0 - 2023-10-13

Added
  * AZ-1205: Add `delivery_property` variable

Changed
  * AZ-1205: Update variables definition

Fixed
  * AZ-1205: Fix `webhook_endpoint` variable

# v7.2.0 - 2023-07-07

Added
  * AZ-1109: Add support for webhook endpoint

# v7.1.0 - 2022-11-23

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.0.0 - 2022-09-30

Breaking
  * AZ-840: Update to Terraform `v1.3`

# v6.0.1 - 2022-07-08

Fixed
  * AZ-772: Maximum terraform version `v1.2+` for optional attributes

# v6.0.0 - 2022-05-16

Breaking
  * AZ-717: Bump module for AzureRM provider `v3.0+`

# v5.0.0 - 2022-05-03

Added
  * AZ-679: Initialize Event Grid module
