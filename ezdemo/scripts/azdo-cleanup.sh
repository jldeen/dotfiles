#!/bin/bash
set -eou pipefail
source ./scripts/variables.sh

curl -u $(presenter):$(PAT) --request DELETE "https://vsrm.dev.azure.com/$(organization)/$(project)/_apis/release/definitions/$(releaseDef)?forceDelete=true&api-version=5.0" && echo "$(organization) $(project) Release Definition $(releaseDef) has been successfully deleted."
sleep 10
curl -u $(presenter):$(PAT) --request DELETE "https://dev.azure.com/$(organization)/$(project)/_apis/build/definitions/$(buildDef)?api-version=5.0" && echo "$(organization) $(project) Build Definition $(buildDef) has been successfully deleted."
