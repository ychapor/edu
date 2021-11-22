#
# Changes the owner of directory and its content.
#
# Arguments:
#   new_owner
#   directory

import sys
import os
import pwd

if os.geteuid() != 0:
    exit('Only root allowed to run this scenario!')

args = sys.argv
NEW_OWNER = args[1]
DIRECTORY = args[2]

try:
    pwd.getpwnam(NEW_OWNER)
except KeyError:
    exit('User does not exist!')

if not os.path.isdir(DIRECTORY):
    exit('Directory does not exist or is not a directory!')

cmd = 'chown -R ' + NEW_OWNER + ':' + NEW_OWNER + ' ' + DIRECTORY
os.system(cmd)
