sudo aptitude -y install autoconf automake bison build-essential curl git-core libc6-dev libffi-dev libgdbm-dev libreadline6 libreadline6-dev libsqlite3-dev libssl-dev libtool libxml2-dev libxslt-dev libyaml-dev ncurses-dev openssl pkg-config sqlite3 subversion zlib1g zlib1g-dev

RUBY_VERSION=2.1.2
RBENV_ROOT=/usr/local/rbenv

cd /usr/local
sudo git clone git://github.com/sstephenson/rbenv.git
sudo git clone https://github.com/sstephenson/ruby-build.git
cd /usr/local/ruby-build
sudo ./install.sh

cat <<EOF | sudo tee /etc/profile.d/rbenv.sh
PATH="$RBENV_ROOT/bin:$PATH"
eval "\$(rbenv init -)"
EOF
source /etc/profile.d/rbenv.sh

rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv rehash
