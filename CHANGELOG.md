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
