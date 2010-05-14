######
# This is not an executable script.  It selects and configures rvm for
# bcsec's CI process based on the BCSEC_ENV environment variable.
#
# Use it by sourcing it:
#
#  . ci-rvm.sh
#
# Assumes that the create-on-use settings are set in your ~/.rvmrc:
#
#  rvm_install_on_use_flag=1
#  rvm_gemset_create_on_use_flag=1

set +x
echo ". ~/.rvm/scripts/rvm"
. ~/.rvm/scripts/rvm
set -x

BCSEC_JRUBY='jruby-1.4.0'
BCSEC_RVM_RUBY='ree-1.8.7-2010.01'
CELERITY_VERSION="0.7.9"

echo "Adding jruby to the PATH for culerity"
set +x
rvm use "${BCSEC_JRUBY}" # ensure it is installed
set -x
gem list -i celerity -v $CELERITY_VERSION
if [ $? -ne 0 ]; then
  gem install celerity -v 0.7.9
fi
mkdir -p ci_bin
if [ -L ci_bin/jruby ]; then
  rm ci_bin/jruby
fi
ln -s ~/.rvm/bin/${BCSEC_JRUBY} ci_bin/jruby
PATH="ci_bin:$PATH"

echo "Switching to ${BCSEC_RVM_RUBY}"
set +x
rvm use "$BCSEC_RVM_RUBY"
set -x
ruby -v
