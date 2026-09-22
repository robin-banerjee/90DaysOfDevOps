# #!/bin/bash

# log_rotation(){
	
# 	~/2026/day-19/scripts/log_rotate.sh /var/log/demo-app/ >> /var/log/maintenance.log
# }

# backup(){
# 	 ~/2026/day-19/scripts/backup.sh ~/Downloads ~/demo >> /var/log/maintenance.log
# }

# main(){
# 	echo -e "\n$(date) : Starting Maintenance... " >> /var/log/maintenance.log
# 	log_rotation
# 	backup
# 	echo "Maintenance completed for today" >> /var/log/maintenance.log
# }

# main
# echo "Successfully written logs to /var/log/maintenance.log"


#!/bin/bash
set -eu

# Get the directory where maintenance.sh is currently located
SCRIPT_DIR="$(dirname "$0")"

log_rotation(){
    "$SCRIPT_DIR/log_rotate.sh" /var/log/demo-app/ >> /var/log/maintenance.log 2>&1
}

backup(){
    "$SCRIPT_DIR/backup.sh" /home/user/dummy-data /home/user/backup >> /var/log/maintenance.log 2>&1
}

main(){
    echo -e "\n$(date) : Starting Maintenance... " >> /var/log/maintenance.log
    log_rotation
    backup
    echo "$(date) : Maintenance completed for today" >> /var/log/maintenance.log
}

main
echo "Successfully written logs to /var/log/maintenance.log"