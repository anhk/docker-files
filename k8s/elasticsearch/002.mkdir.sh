#!/bin/bash


ssh node01 "rm -fr /export/elasticsearch && mkdir -p /export/elasticsearch/ && chmod 0777 /export/elasticsearch/ "
ssh node02 "rm -fr /export/elasticsearch && mkdir -p /export/elasticsearch/ && chmod 0777 /export/elasticsearch/ "


