#!/bin/bash

Root_Uid=0
Repl=1

if [ $UID -ne $Root_Uid ]; then
  echo "Must be root to run this..."
  exit
fi

echo "import requests" > req.py
echo "ImgUrl = input('Enter Url of Image -> ')" >> req.py
echo "headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0'}" >> req.py
echo "res = requests.get(ImgUrl , headers = headers)" >> req.py
echo "print(res.text)" >> req.py


python3 req.py | tee new
cat new | tr " " "\n" | grep src | cut -d'"' -f 2 | grep http > done
pwd | tee CurDir
mkdir photos
echo "moved into photos dire"
echo $Dfile
Ndir=$(echo $(cat CurDir)/photos)
echo $Ndir
echo "Printed"
for i in $(cat done);do wget -nc -P $Ndir $i; done
cd photos
for j in $(ls *.js*);do sudo rm -rf $j;done 
for k in $(ls *.html*);do sudo rm -rf $k;done
for k in $(ls m=_b*);do sudo rm -rf $k;done
cd ../
sudo rm -rf req.py new done CurDir
echo ""
echo "Do you want to Zip files?"
echo "Press '1' for yes and '2' for no -> "
read -p "" Ans
if [ $Ans -eq $Repl ]; then
  zip -r photos_zip  photos
  sudo rm -rf photos
fi


echo "Thankyou for using Image Downloader"