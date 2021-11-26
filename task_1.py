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
    exit('Provided user does not exist!')

if not os.path.isdir(DIRECTORY):
    exit('Provided directory does not exist or is not a directory!')

os.system('chown -R ' + NEW_OWNER + ':' + NEW_OWNER + ' ' + DIRECTORY)
print('You have changed the owner of ' + str(DIRECTORY) + ' to '
      + str(NEW_OWNER))
