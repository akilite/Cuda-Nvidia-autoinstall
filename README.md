CUDA-NVIDIA AUTO-INSTALL SCRIPT
===
This script will automatically install cuda-9.2 and nvidia-390 except few steps in the cuda installation which have human interaction.

REQUIRED TO INSTALL
---
Below "cuda-nvidia autoinstall.sh" script is the only requirement to install automatically which includes below required files or packages.

**1) CUDA Toolkit**
    --> Base Installer which is main cuda package to instaven. 31 août 2018 11:45:22 CEST ll.
    --> Patch file (recommended patch updates to install). This requires the above base installer to be installed first. This patch update includes fix to cublas GEMM APIs on Tensor core GPUs when used with default algorithm CUBLAS_GEMM_DEFAULT_TENSOR_OP.

**2) NVIDIA package**
The driver nvidia-390 is the current "long term" driver and it support cards up-to and including Titan V. 
It can install (automatically) by run the below script. Also install (manually) from graphics drivers ppa using apt-get (if you encounter any error in automatic script).

ABOUT SCRIPT
---
**CUDA**

1) Download the base installer and patch https://developer.nvidia.com/cuda-92-download-archive file. It will download a two run file. This can do with below command. Sometimes wget won't work well, by that time use curl.

	wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux
	wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda_9.2.148.1_linux

2) Change the downloaded run file permission and add execute permission as below. /home/veesion instead of this change your home directory.

	sudo chmod u+x /home/veesion/cuda_9.2.148_396.37_linux.run
	sudo chmod u+x /home/veesion/cuda_9.2.148.1_linux.run

3) Now run the file with sudo. After run the file, it will have few manual steps that collect response from user and run accordinly. 

	sudo ./cuda_9.2.148_396.37_linux.run	##Base Installer##
	sudo ./cuda_9.2.148.1_linux.run		##Patch Updates##

4) Ignore the generated WARNING after base installation(you can't see while script running). It will fix with below and which is only for base installer not for patch updates. It's enough to run and install the patch updates.

   --> Create two file with sudo: cuda.sh in /etc/profile.d path and cuda.conf in /etc/ld.so.conf path.

	sudo touch /etc/profile.d/cuda.sh /etc/ld.so.conf.d/cuda.conf

   --> Add the below text in cuda.sh and cuda.conf correspondingly.

	export PATH=$PATH:/usr/local/cuda/bin
	export CUDADIR=/usr/local/cuda

	/usr/local/cuda/lib64

   --> Permission denied to add the text in the above (root)file. so before adding, change the file permission.

	sudo chmod o+w /etc/profile.d/cuda.sh /etc/ld.so.conf.d/cuda.conf
	echo -e "export PATH=$PATH:/usr/local/cuda/bin\nexport CUDADIR=/usr/local/cuda" >> /etc/profile.d/cuda.sh
	echo -e "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf
	sudo chmod o-w /etc/profile.d/cuda.sh /etc/ld.so.conf.d/cuda.conf

   --> DON'T FORGOT TO REMOVE PERMISSION.

5) We can see the installed cuda version with below command

	cat /usr/local/cuda/version.txt

CUDA installation fini...

**NVIDIA**

1) Verify the available and default driver in the system

	ubuntu-drivers devices

2) First, delete all the nvidia package installed (if any) and download from repository with ppa. Update the system before installing the nvidia driver. 

	sudo apt-get purge nvidia*
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt update
	sudo apt install -y nvidia-390
	reboot

3) DON'T FORGOT TO REBOOT.

4) We can see the installed nvidia driver with below command.

	nvidia-smi 

NVIDIA installation fini...


