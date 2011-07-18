######
# This is not an executable script.  It selects and configures rvm for
# aker-rails' CI process.
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

AKER_RVM_RUBY='ree-1.8.7-2011.03'
GEMSET="aker-rails-${JOB_NAME}"

echo "Switching to ${AKER_RVM_RUBY}"
set +xe
rvm use "$AKER_RVM_RUBY"
if [ $? -ne 0 ]; then
    echo "Switch failed"
    exit 2;
fi
echo "Switching to $GEMSET gemset"
rvm gemset use $GEMSET
set -xe
ruby -v
