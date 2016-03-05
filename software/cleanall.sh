#!/bin/bash

for dir in $( ls )
do
    if [ -d $dir ]; then
        cd $dir
        make allclean
        cd ../
    fi
done

exit $?
