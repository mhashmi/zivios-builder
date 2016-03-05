#!/bin/sh

sed "s!/usr/local/ssl!$BLIB/ssl!g" <src/osdep/unix/Makefile >tmp1
cp tmp1 src/osdep/unix/Makefile

sed -e "s,/usr/include/openssl,/opt/zivios/openssl/include,g" \
	-e "s,/usr/share/ssl,/opt/zivios/openssl,g" \
	-e "s,SSLLIB=/usr/lib,SSLLIB=/opt/zivios/openssl/lib,g" <Makefile >tmp1
cp tmp1 Makefile
