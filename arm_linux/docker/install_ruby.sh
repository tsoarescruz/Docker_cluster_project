Installs Ruby 2.4 using rbenv/ruby-build on the Raspberry Pi (Raspbian)
#
# Run from the web:
#   bash <(curl -s https://gist.githubusercontent.com/blacktm/8302741/raw/install_ruby_rpi.sh)
# --------------------------------------------------------------------------------------------

# Welcome message
echo -e "
This will install Ruby 2.4 using rbenv/ruby-build.
It will take about 2 hours to compile on the original Raspberry Pi,
35 minutes on the second generation, and 16 minutes on the third.\n"

# Prompt to continue
#read -p "  Continue? (y/n) " ans
#if [[ $ans != "y" ]]; then
#  echo -e "\nQuitting...\n"
#  exit
#fi
#echo

# Time the install process
START_TIME=$SECONDS

# Check out rbenv into ~/.rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Add ~/.rbenv/bin to $PATH, enable shims and autocompletion
read -d '' String <<"EOF"
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
EOF

# Save to ~/.bashrc
echo -e "\n${String}" >> ~/.bashrc

# Enable rbenv for current shell
eval "${String}"

# Install ruby-build as an rbenv plugin, adds `rbenv install` command
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install dependencies
#  See: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
sudo apt update
sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Install Ruby 2.4, don't generate RDoc to save lots of time
CONFIGURE_OPTS="--disable-install-doc --enable-shared" rbenv install 2.4.1 --verbose

# Set Ruby 2.4 as the global default
rbenv global 2.4.1

# Don't install docs for gems (saves lots of time)
echo "gem: --no-document" > ~/.gemrc

# Reminder to reload the shell
echo -e "\nReload the current shell to get access to rbenv using:"
echo "  source ~/.bashrc"

# Print the time elapsed
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\nFinished in $(($ELAPSED_TIME/60/60)) hr, $(($ELAPSED_TIME/60%60)) min, and $(($ELAPSED_TIME%60)) sec\n"
