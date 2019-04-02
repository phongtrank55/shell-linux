#!/bin/bash

pathphpexecute="readconfig.php"
pathmoodledefault="/var/www/moodle"
pathfiletxt="config.txt"
#pathbackuprootdefault="~/Desktop"
pathbackuprootdefault="backup"

#Hien thi
total=9 # tong cac giai doan
curstatus=1 #Giai doan hien tai
msgsuccess="[OK]"
msgfail="[Fail]"

#Dong 1: dbtype
#Dong 2: dbuser
#Dong 3: dbpass
#Dong 4: dbname
#Dong 5: folder data

#Kiem tra tham so
pathbackuproot=$2
pathmoodle=$1

if [ -z "$pathmoodle" ]
then
	pathmoodle=$pathmoodledefault
fi
if [ -z "$pathbackuproot" ]
then
	pathbackuproot=$pathbackuprootdefault
fi

if [ ! -e $pathmoodle ]
then
	echo "Khong tim thay $pathmoodle"
	exit
fi

if [ ! -e $pathphpexecute ]
then
	echo "Khong tim thay $pathphpexecute"
	exit
fi


#Ghi cau hinh ra tep
echo -n "[$curstatus/$total] Dang doc cau hinh..."

rm -f $pathfiletxt

php $pathphpexecute $pathmoodle $pathfiletxt
#Doc cau hinh tu tep
if [ ! -f $pathfiletxt ] 
then
	echo $msgfail
	echo "Tep cau hinh khong duoc tim thay hoac khong dung! Vui long kiem tra tep config.php trong $pathmoodle"
	exit
fi


while IFS='' read -r line || [[ -n "$line" ]]; do
	#echo $line
	configs=( "${configs[@]}" "$line" )
done < "$pathfiletxt"

echo "$msgsuccess";

#Kiem tra cau hinh
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang kiem tra cau hinh hop le..."
# Kiem tra day du cac truong
fields=('dbtype' 'dbuser' 'dbpass' 'dbname' 'dataroot')
lengthconfig=${#configs[@]}
error=false
for(( i=0; i<$lengthconfig; i++ ))
do
	if [ ${configs[$i]} = "-" ]
	then
		if [ $error = false ] 
		then
			error=true
			echo "$msgfail"
		fi
		echo "Thong tin ${fields[$i]} khong tim thay"
	fi
done

if [ $error = true ]
then
	exit
fi

<<comment1
# Kiem tra csdl

if [[ ${configs[0]} != 'mariadb' ]] && [[ ${configs[0]} != 'mysqli' ]]
then
	echo "$msgfail"
	echo "Khong ho tro dbtype la ${configs[0]}. Chi ho tro mariadb hoac mysqli."
	exit
fi
comment1

echo "$msgsuccess";

# sao luu du lieu
# TAO THU MUC
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang tao thu muc..."

folderbackup="moodle_`date +'%Y-%m-%d_%H-%M-%S'`"
#folderbackup="moodle_`date +'%Y-%m-%d'`"
pathbackup="$pathbackuproot/$folderbackup"

mkdir -p $pathbackup

if [ ! -e $pathbackup ]
then
	echo "$msgfail"
	echo "Tao thu muc that bai!"
	exit
fi
echo "$msgsuccess";


# BAT CHE DO BAO TRI
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang bat che do bao tri..."
php $pathmoodle/admin/cli/maintenance.php --enable
echo "$msgsuccess";

# SAO LUU MA NGUON
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang sao luu ma nguon..."
cp -rf $pathmoodle $pathbackup
echo "$msgsuccess";

# SAO LUU DB
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang sao luu CSDL..."
mysqldump -u ${configs[1]} -p${configs[2]} ${configs[3]} > $pathbackup/db.sql
echo "$msgsuccess";

# SAO LUU DATA
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang sao luu tap tin luu tru..."
cp -rf ${configs[4]} $pathbackup
echo "$msgsuccess";

#Huy che do bao tri
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang tat che do bao tri..."
php $pathmoodle/admin/cli/maintenance.php --disable
echo "$msgsuccess";


# Nen du lieu
curstatus=$[curstatus+1]
echo -n "[$curstatus/$total] Dang nen du lieu..."
tar -C $pathbackuproot -czf $pathbackup.tar.gz $folderbackup
rm -rf $pathbackup
echo "$msgsuccess";

echo "=== SAO LUU HOAN TAT ==="
