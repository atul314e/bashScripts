#!/bin/bash
# Create an array which holds list of courses. This should be used to compare if the course name is passed in CLI
courses=(
"ML_courses"
"linux_courses"
)

# function for usage
usage() {
	echo "Usage":
        echo "     ./course_mount.sh -h To print this help message"
        echo "     ./course_mount.sh -m -c [course] For mounting a given course"
        echo "     ./course_mount.sh -u -c [course] For unmounting a given course"
        echo "If course name is ommited all courses will be (un)mounted"
}

#function to check mount exists
check_mount() {
	pn="/home/trainee/courses/"
	pn+=$1
	if [ -d $pn ];then
		echo 0
	else
		echo 1
	fi
}

#function for mount a course
mount_course() {
    # Check if the given course exists in course array
    # Check if the mount is already exists
    # Create directory in target
    # Set permissions
    # Mount the source to target
    flag=0
    for i in ${courses[@]}; do
	if [ "$i" == "$1" ];then
		flag=1
		break
	fi
    done
    isnotmount=$(check_mount $1)
    COURSE_PATH=""
    TARGET_PATH=""
    if [ $flag -eq 1 ] && [ $isnotmount -eq 1 ];then
	    COURSE_PATH="/home/user1/courses/"$1
	    TARGET_PATH="/home/trainee/courses/"$1
	    if [ -d $TARGET_PATH ];then
	    	 bindfs -p a-w -u trainee -g ftpaccess ${COURSE_PATH} ${TARGET_PATH}
	    else
		 mkdir $TARGET_PATH
		 bindfs -p a-w -u trainee -g ftpaccess ${COURSE_PATH} ${TARGET_PATH}
	    fi
    fi
}

# function to mount all courses
mount_all() {
    # Loop through courses array
    # call mount_course
    for i in ${courses[@]};do
	mount_course "$i"
    done
}

# function for unmount course
unmount_course() {
    # Check if mount exists
    # If mount exists unmount and delete directory in target folder
    ismount=$(check_mount "$1")
    if [ $ismount -eq 0 ];then
    	TARGET_PATH="/home/trainee/courses/"$1
    	umount $TARGET_PATH
	rmdir $TARGET_PATH
    fi
}

# function for unmount all courses
unmount_all() {
    # Loop through courses array
    # call unmount_course
    for i in ${courses[@]};do
       unmount_course "$i"
    done
}

if [ "$1" == "-h" ];then
	usage
elif [ "$1" == "-m" ] && [ "$2" == "-c" ];then
	if [ "$#" -eq 3 ];then
		mount_course "$3"
	elif [ "$#" -eq 2 ];then
		mount_all
	fi
elif [ "$1" == "-u" ] && [ "$2" == "-c" ];then
	if [ $# -eq 3 ];then
		unmount_course "$3"
	elif [ $# -eq 2 ];then
		unmount_all	
	fi
else 
	echo "do -h to find more"
fi
