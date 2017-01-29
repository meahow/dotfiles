#!/usr/bin/env bash
# simple script to run doxygen
# author: Michal Pszona
#cd `readlink -f $0|sed -e 's/\/[^\/]*$//'`
cd /sandbox/michalp/mainline

DATE=`date +%y-%m-%d`
DOXYGEN_ROOT=/sandbox/michalp/doxygen
LOCKFILE=$DOXYGEN_ROOT/__lock
DOXYGEN_BIN=~/usr/bin/doxygen
DOXYGEN_CONF=$DOXYGEN_ROOT/conf/Doxyfile
LOGFILE_DIR=$DOXYGEN_ROOT/__log
LOGFILE_STDOUT=$LOGFILE_DIR/${DATE}.out
LOGFILE_STDERR=$LOGFILE_DIR/${DATE}.err
OUTDOCS_DIR=`grep -P 'OUTPUT_DIRECTORY\s*=' $DOXYGEN_CONF | sed -e 's/^.*=\s*//'`

[[ -d $LOGFILE_DIR ]]  || mkdir $LOGFILE_DIR

echo `date` "Obtaining lock..." >> $LOGFILE_STDOUT
if [[ -f $LOCKFILE ]]
then
   echo "Another instance of $0 is working (or unnecessary $LOCKFILE left). Dying..." 
   echo `date` " FAILED" >> $LOGFILE_STDOUT
   exit 1
else
   touch $LOCKFILE
fi
echo `date` " done" >> $LOGFILE_STDOUT

echo `date` "Removing old docs..." >> $LOGFILE_STDOUT
rm -rf $OUTDOCS_DIR.old || exit $?
echo `date` " done" >> $LOGFILE_STDOUT

echo `date` "Moving docs to old docs dir..." >> $LOGFILE_STDOUT
[[ -f $OUTDOCS_DIR ]] && ( mv -f $OUTDOCS_DIR __$OUTDOCS_DIR.old || exit $? )
echo `date` " done" >> $LOGFILE_STDOUT

echo `date` "Generating DOX..." >> $LOGFILE_STDOUT
$DOXYGEN_BIN $DOXYGEN_CONF 2>$LOGFILE_STDERR >>$LOGFILE_STDOUT
echo `date` " done" >> $LOGFILE_STDOUT

echo `date` "Reeleasing lock..." >> $LOGFILE_STDOUT
rm -f $LOCKFILE || exit $?
echo `date` " done" >> $LOGFILE_STDOUT

