######
# This is not an executable script.  It selects and configures rvm for
# bcsec-rails' CI process.
#
# Use it by sourcing it:
#
#  . ci-rvm.sh
#
# This script assumes:
#
# 1. the existence of JOB_NAME in the parent environment
# 2. RVM's create-on-use settings are set in your ~/.rvmrc:
#        rvm_install_on_use_flag=1
#        rvm_gemset_create_on_use_flag=1

set +x
echo ". ~/.rvm/scripts/rvm"
. ~/.rvm/scripts/rvm
set -x

BCSEC_JRUBY='jruby-1.4.0'
BCSEC_RVM_RUBY='ree-1.8.7-2010.02'
CELERITY_VERSION="0.7.9"
CULERITY_VERSION="0.2.12"
GEMSET="bcsec-rails-${JOB_NAME}"

echo "Adding jruby to the PATH for culerity"
set +xe
rvm use "${BCSEC_JRUBY}" # ensure it is installed
set -x
if [ $(gem list -i celerity -v $CELERITY_VERSION) == 'false' ]; then
  gem install celerity -v $CELERITY_VERSION
fi
if [ $(gem list -i culerity -v $CULERITY_VERSION) == 'false' ]; then
  gem install culerity -v $CULERITY_VERSION
fi
set -e

mkdir -p ci_bin
if [ -L ci_bin/jruby ]; then
  rm ci_bin/jruby
fi
ln -s ~/.rvm/bin/${BCSEC_JRUBY} ci_bin/jruby
PATH="ci_bin:$PATH"

echo "Switching to ${BCSEC_RVM_RUBY}"
set +xe
rvm use "$BCSEC_RVM_RUBY"
if [ $? -ne 0 ]; then
    echo "Switch failed"
    exit 2;
fi
echo "Switching to $GEMSET gemset"
rvm gemset use $GEMSET
set -xe
ruby -v
