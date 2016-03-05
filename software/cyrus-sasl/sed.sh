#!/bin/bash
find . -name Makefile -exec sed -i.pass1 's#= -L/opt/zivios/heimdal-1.3.1/lib#= -L/opt/zivios/heimdal-1.3.1/lib -Wl,-rpath,/opt/zivios/heimdal-1.3.1/lib#' {} \;
find . -name Makefile -exec sed -i.pass2 's#= -L/opt/zivios/openssl-0.9.8l/lib64 -Wl,-rpath,/opt/zivios/openssl-0.9.8l/lib64#= #' {} \;
sed -i "s/^#define WITH_DES/& 1/" {saslauthd/,}configure

