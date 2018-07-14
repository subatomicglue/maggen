
location='https://bintray.com/olikraus/u8glib/download_file?file_path=u8glib_arduino_v1.18.1.zip'

echo -e "\nwe're going to install a fresh u8glib... (hit [enter])"; read
cd $HOME/Documents/Arduino/libraries
pwd
ls -l .

echo -e "\n- we're going to remove existing ./U8glib if it exists... (hit [enter])"; read
rm -rf ./U8glib
pwd
ls -l .

echo -e "\n- we're going to download U8glib from:\n $location\n (hit [enter])"; read
curl -L -o u8glib_arduino.zip $location
pwd
ls -l .

echo -e "\n- we're going to unzip U8glib zip file... (hit [enter])"; read
unzip u8glib_arduino.zip
pwd
ls -l .

echo -e "\n- we're going to remove U8glib zip file... (hit [enter])"; read
rm -rf u8glib_arduino.zip
pwd
ls -l .

echo -e "\ndone... (hit [enter])"; read
cd -
pwd
ls -l .

