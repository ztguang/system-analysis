#!/bin/bash
# based on git log info

android_repo_path="/opt/git/lollipop-x86"
Repo="/home/xly/repository/bin/repo"

cd $android_repo_path

all_projects=$($Repo list | awk '{print $3}')

for prj_ in $all_projects
do
	cd $android_repo_path

	#echo $prj_ 
	cd $prj_*
	base_loginfo=(` git log -1 --pretty=format:"%h %cd %ae \"%an\"" --date=iso `)

	multi_loginfo=(` git log multiwindow -1 --pretty=format:"%h %cd %ae \"%an\"" --date=iso `)
	single_loginfo=(` git log singlewindow -1 --pretty=format:"%h %cd %ae \"%an\"" --date=iso `)

	if [ "${base_loginfo[0]}"x = "${multi_loginfo[0]}"x -a "${base_loginfo[0]}"x = "${single_loginfo[0]}"x ]
	then
		continue
	fi
	
	echo -e "\033[31m$prj_\033[0m"
	echo -e "git log: ${base_loginfo[@]}"
	echo -e "multiwindow: ${multi_loginfo[@]}"
	echo -e "singlewindow: ${single_loginfo[@]}"
	echo '------------------------------'

done
