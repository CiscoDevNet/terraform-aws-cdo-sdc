#!/bin/bash

su sdc -c bash << 'EOF'
bootstrap_file=/tmp/bootstrap_data
sdc_dir=/usr/local/cdo

echo "${cdo_bootstrap_data}" > $${bootstrap_file}
. <(base64 -d < $${bootstrap_file})
cd $${sdc_dir}
curl -H "Authorization: Bearer $${CDO_TOKEN}" "$${CDO_BOOTSTRAP_URL}" -o $${sdc_dir}/$${CDO_TENANT}.tar.gz
tar -zxvf $${CDO_TENANT}.tar.gz
/usr/local/cdo/bootstrap/bootstrap.sh
EOF