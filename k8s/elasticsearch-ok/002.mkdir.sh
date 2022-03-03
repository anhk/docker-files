#!/bin/bash


ssh node01 "mkdir -p /opt/es/es-node-data && mkdir -p /opt/es/es-master-data && chmod 0777 /opt/es/es-*-data "
ssh node02 "mkdir -p /opt/es/es-node-data && mkdir -p /opt/es/es-master-data && chmod 0777 /opt/es/es-*-data "


