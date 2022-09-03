#!/bin/bash

aktualizrconfig() {
	
	yes | sudo apt-get install jq
	cd ${HOME}/Desktop/ota-lith/
	./scripts/gen-device.sh
	cd .. 

	yes | git clone --recursive https://github.com/advancedtelematic/aktualizr
	cd aktualizr/
	git submodule update --init --recursive
	mkdir build
       	cd build
 	cmake -DCMAKE_BUILD_TYPE=Debug ..
	make package
	sudo dpkg -i aktualizr.deb
}

otacli-config(){
	cd ${HOME}/Desktop/ota-lith/
	./scripts/get-credentials.sh  

	cd ..  
	yes | git clone https://github.com/simao/ota-cli.git

	cd ota-cli/
	sudo apt-get update
	sudo apt-get -y install cargo
	make ota
	${HOME}/.cargo/bin/ota init --campaigner http://campaigner.ota.ce --director http://director.ota.ce --registry http://deviceregistry.ota.ce --credentials ../ota-lith/ota-ce-gen/credentials.zip --reposerver http://reposerver.ota.ce

}

Help(){
	#Display Help
	echo "Installing resources | Create  ota-cli"
	echo 
	echo "SYNTAX: "
	echo "OPTIONS:"
	echo "-a	 Install aktualizr"
	echo "-o	 Create ota-cli"
	echo "-h	 Prints help"
	echo "-i	 Install aktualizr & ota-cli"	
	echo 

}

while getopts ":ihoa:" option; do
	case $option in
		h) # display Help
 			Help
         	exit;;
		i) # Install aktualizr & ota-cli
			aktualizrconfig
			otacli-config
			exit;;
		a) # Install aktualizr
			aktualizrconfig
			exit;;
		o) # Create ota-cli
		 	otacli-config
		 	exit;;
     		\?) # Invalid option
		        echo "Error: Invalid option"
		        exit;;
	esac
done

aktualizrconfig
otacli-config

$SHELL
