#!/bin/sh

# Bien dac biet

echo PID hien tai $$
echo Ten file script $0
echo Tham so thu nhat la $1
echo So tham so duoc cung cap $#
echo Tat ca cac tham so la $*
echo cac tham so rieng re $@
echo Trang thai thoat ra cua lenh truoc $? # 0: success; 1: fail; other
echo so tien trinh cua lenh backgroud truoc $!
for TOKEN in $@
do
   echo $TOKEN
done
