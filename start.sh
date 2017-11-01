#!/bin/bash

# if first container, start the main daemon, others will connect on it
if [ "x$MC_FIRST" = "x" ]
then
  httpd
  multichaind chain1
fi

rm -rf ~/.multichain

multichaind $MC_FIRST

sleep 30

multichaind chain1
