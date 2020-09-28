SRC_BASE_DIR=~/git/psunix

if ! which git > /dev/null; then
  sudo apt install git
fi

mkdir -p $SRC_BASE_DIR
cd $SRC_BASE_DIR

if [ ! -d "$SRC_BASE_DIR/dp" ]; then
  git clone https://github.com/psunix/dp.git
  cd dp
else
  cd dp
  git pull
fi

git submodule update --init

if ! which ansible-playbook > /dev/null; then
  ./bin/install_ansible.sh
fi


if [ $# -eq 0 ]; then
  ansible-playbook ansible/desktop.yml --ask-become-pass
else
  ansible-playbook ansible/desktop.yml --ask-become-pass -t=$1
fi

exit 0
