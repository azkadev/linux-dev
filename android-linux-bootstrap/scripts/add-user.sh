#!/system/bin/sh
# generate user files in the bootstrap

mkdir -p bootstrap/home/$1 
echo "$1:x:$USER_ID:$USER_ID:guest:/home/$1:/bin/sh" >> bootstrap/etc/passwd
echo "$1 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$1
chmod 0440 /etc/sudoers.d/$1