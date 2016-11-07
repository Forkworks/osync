#!/bin/bash

serial=$(cat /etc/serial)
sed 's/XXX/'$serial'/g' /etc/osync/syncN.generic  > /etc/osync/syncN.conf
