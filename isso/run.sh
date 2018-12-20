#!/bin/sh

# fill template with env variable
# export DOLLAR='$' ## fix for nginx env variable
# envsubst < /isso/config/isso.conf.template > /isso/config/isso.conf

# run isso
chown -R $UID:$GID /isso/
exec su-exec $UID:$GID /sbin/tini -- isso -c /isso/config/isso.conf run