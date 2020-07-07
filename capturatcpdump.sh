#!/bin/bash

sudo tcpdump -i enp0s3 -c 100 -C 60 -n tcp port 22 -w captura.pcap

echo "Captura finalizada com sucesso"
