#!/bin/bash
echo "ctagsgen started"

ctagsgen ()
{
    if [ "$1" == "" ]
    then
        echo "empty arg!!"
        exit 1
    fi

    FILES_LIST_FILE=$1/.tags/cscope.files
    CTAGS_FILE=$1/.tags/tags.ctags
    TAG_DIRS="servers/cserver/src2 common dserver clients servers"
    #servers/cserver/src2/ servers/cserver/src servers/pmserver/ servers/ubrserver/ servers/cmservices/ servers/tools/dbupdate/ common/libaid/ common/libdatabase_api/ common/libds* common/libparameter_factory/ common/libraima_api/ common/libxml/ common/libparameter_factory/ 

    echo "Generating ctags for $1 in $CTAGS_FILE, file list - $FILES_LIST_FILE..."

    if [ ! -d $1/.tags ]
    then
        mkdir -p $1/.tags
    fi
    rm -f $FILES_LIST_FILE $CTAGS_FILE
    cd $1
    for path in $TAG_DIRS
    do
        find $path \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hh' -o -name '*.ext' \) -print >> $FILES_LIST_FILE
    done
    ctags -L $FILES_LIST_FILE -a --c-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes -f $CTAGS_FILE

    echo "done"
}

dirs=`ls --color=no -d /sandbox/michalp/*/.tags`
for directory in $dirs
do
    ctagsgen $directory/..
done

echo "ctagsgen finished"
