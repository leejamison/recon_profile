hgrip(){ 
history | grep $1
}

#----- AWS -------

s3ls(){
aws s3 ls s3://$1
}

s3cp(){
aws s3 cp $2 s3://$1 
}

#----- misc -----
certspotter(){
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1
} #h/t Michiel Prins

crtsh(){
curl -s https://crt.sh/?q=%.$1  | sed 's/<\/\?[^>]\+>//g' | grep $1
}

certnmap(){
curl https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1  | nmap -T5 -Pn -sS -i - -$
} #h/t Jobert Abma

certbrute(){
cat $1.txt | while read line; do python3 dirsearch.py -e . -u "https://$line"; done
}

ipinfo(){
curl http://ipinfo.io/$1
}

#------ Tools ------
dirsearch(){
cd /tools/dirsearch*
python3 dirsearch.py -e . -u $1
}

sqlmap(){
cd /tools/sqlmap*
python sqlmap.py -u $1 
}

knock(){
cd /home/tools/knock/knockpy
python knockpy.py -w list.txt $1
}

ncx(){
nc -l -n -vv -p $1 -k
}

# EyeWitness installed in domained dir at /opt/domained -- update as necessary
# $1 -- example.com
# $2 -- i.e. domains-list.txt
# creates output directory in current location
witness(){
#1 = domain.com
#2 = URL list
now="$(date +'%m-%d-%y-%H-%M')"
mkdir ./output
/opt/domained/bin/EyeWitness/EyeWitness.py -f $2 --no-prompt --web -d output/$1-$now-EW
}
