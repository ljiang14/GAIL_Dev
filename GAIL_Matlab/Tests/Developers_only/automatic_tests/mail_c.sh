#!/bin/sh

TO_EMAIL_IDS="Sou-cheng<schoi32@iit.edu>, Jagadeeswaran<jrathin1@iit.edu>"
DATE_TODAY=$(date +\%Y-\%m-\%d)
SUBJECT="Daily test results were OK (report) ${DATE_TODAY}"

# attach the file, instead of putting inte body, as the file contains non printable chars
FILE_ATTACH="/home/gail/GAIL_tests/PBS_jobs/pbs_reports/gail_daily_tests-$(date +\%Y-\%m-\%d).out"
# uuencode $FILE_ATTACH $FILE_ATTACH
echo "Please find the attached report" | mail -s "$SUBJECT" -a $FILE_ATTACH ${TO_EMAIL_IDS}
