
for id in $(cat /usr/local/bin/id_check/unix_members_id.txt); do a_expire=`ldapsearch -x -H ldap://corp.standard.com -D ldap_rhss -w efveVNTUDbx7W -b "dc=corp,dc=standard,dc=com" "(sAMAccountName=$id)" accountExpires | grep -i ^accountExpires | cut -d ':' -f2`

## convert a_expire to seconds by divinding by 10 million
a_expire_seconds=$((a_expire / 10000000))

## calculate the expiration date in seconds since 1970-01-01 (unix Epoch)
a_expire_date=$((a_expire_seconds - 11644473600))

## convert a_expire_date to human readable format
a_actual_date=`date -d "@$a_expire_date" +"%Y-%m-%d"`

#echo "$id is getting expired on $a_actual_date" >> actual_date.txt;

current_date=`date +"%Y-%m-%d"`

## convert the dates to seconds
current_date_s=$(date -d "$current_date" +%s)
a_actual_date_s=$(date -d "$a_actual_date" +%s)

## Calculate the difference in days
diff_days=$(( (a_actual_date_s - current_date_s) / (60*60*24) ))

## Checking the difference 
if [ "$diff_days" -lt 14 ]; then
	echo "$id is getting expired on $a_actual_date which is in $diff_days days from today. Please coordinate with AD team to extend the expiration date. Thanks." | mail -s "Alert!!! Your SIC AD Account expired soon" -r id_check HCL-OperationsUNIX@standard.com
else
	echo "Do Nothing"
fi


done


