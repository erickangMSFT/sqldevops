### Windows

1. Install [Ruby 2.3.3-x64](https://rubyinstaller.org/downloads/) to c:\ruby23-x64
2. Install [Ruby DevKit](https://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe) to c:\rubydevkit

```powershell
setx PATH "%PATH%;C:\ruby32-x64\bin" /M
setx PATH "%PATH%;C:\rubydevkit\bin" /M

cd c:\rubydevkit

ruby dk.rb init
ruby dk.rb install

```

```powershell

gem install ./slacker-1.0.16.gem

```

### macOS
[https://www.microsoft.com/en-us/sql-server/developer-get-started/ruby/mac/](https://www.microsoft.com/en-us/sql-server/developer-get-started/ruby/mac/)

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew install rbenv ruby-build
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

rbenv install 2.4.0
rbenv global 2.4.0
ruby -v

brew install FreeTDS

gem install ./slacker-1.0.16.gem

```

## Linux (Ubuntu ~>16.0.4)

[https://www.microsoft.com/en-us/sql-server/developer-get-started/ruby/ubuntu/](https://www.microsoft.com/en-us/sql-server/developer-get-started/ruby/ubuntu/)

```bash
sudo apt-get update
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
sudo apt-get install git

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.4.0
rbenv global 2.4.0
ruby -v

wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz
tar -xzf freetds-1.00.27.tar.gz
cd freetds-1.00.27
./configure --prefix=/usr/local --with-tdsver=7.3
make
make install

gem install ./slacker-1.0.16.gem
```