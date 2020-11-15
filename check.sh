#/bin/bash
FILE="output.txt"
LIST="list-of-domains.txt"
if [ -f "$FILE" ]; then
    echo "$FILE exist"
else
    echo "output.txt does not exist - creating one"
    touch output.txt
fi

while read i; do
  printf %s $i  "  "
  echo | openssl s_client -servername $i -connect $i:443 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | tail -1 | cut -d "=" -f 2
  echo ""
done <$LIST >> output.txt
