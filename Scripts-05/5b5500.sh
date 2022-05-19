#!/bin/bash

if [ $# -ne 0 ] ; then
	echo "Must have 0 arguments!";
	exit 1;
fi

users=$(mktemp)
cat /etc/passwd > $users

echo "<table>"
echo -e "<tr>
	<th>Username</th>
	<th>group</th>
	<th>login shell</th>
   	<th>GECKO</th>
</tr>"

cat $users | while read line; do
	echo -e "<tr>"
	echo $line | awk -F':' '{printf "\t<td>"$1"</td>\n\t<td>"$4"</td>\n\t<td>"$7"</td>\n\t<td>"$5"</td>" }'

	echo -e "</tr>\n"
done

echo "</table>"
rm $users
