###### CUDA-NVIDIA AUTO-INSTALL SCRIPT #######

########## CUDA ##########
####Download cuda base installer and run the script####
wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux
echo -e "\nDownload completed.\n\n"
sudo mv /home/veesion/cuda_9.2.148_396.37_linux /home/veesion/cuda_9.2.148_396.37_linux.run
sudo chmod u+x /home/veesion/cuda_9.2.148_396.37_linux.run
echo "Hit ctrl+c once you see large text and follow the prompt"
sudo ./cuda_9.2.148_396.37_linux.run

#echo $?
#if [echo $?==0]
#then
#    echo -e "\n\nCuda run file completed.\n\n"
#else
#    echo -e "\n\n Failed"
#    exit
#fi

sudo touch /etc/profile.d/cuda.sh
sudo chmod o+w /etc/profile.d/cuda.sh
echo -e "export PATH=$PATH:/usr/local/cuda/bin\nexport CUDADIR=/usr/local/cuda" >> /etc/profile.d/cuda.sh
sudo touch /etc/ld.so.conf.d/cuda.conf
sudo chmod o+w /etc/ld.so.conf.d/cuda.conf
echo -e "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf
sudo ldconfig
sudo chmod o-w cuda.sh cuda.conf
echo -e "\n\nCUDA INSTALLATION COMPLETED\n\n"
sleep 10s

####load that environment in a shell right now (without logging out) after installation####
#source /etc/profile.d/cuda.sh

####activate your CUDA environment only when and where you need it. Remove the comment (#) for below commands.####
#cat cuda-92-env
#echo -e "export PATH=$PATH:/usr/local/cuda-9.2/bin\nexport CUDADIR=/usr/local/cuda-9.2\nexport LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-9.2/lib64" >> /home/veesion/cuda-92-env
#mkdir cuda-testing
#source cuda-92-env
#cp -a /usr/local/cuda/samples  cuda-testing/
#cd cuda-testing/samples
#make -j4

####Download Patch pkg for cuda and run he script####
wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda_9.2.148.1_linux
sudo mv /home/veesion/cuda_9.2.148.1_linux /home/veesion/cuda_9.2.148.1_linux.run
sudo chmod u+x /home/veesion/cuda_9.2.148.1_linux.run
echo "Hit ctrl+c once you see large text and follow the prompt"
sudo ./cuda_9.2.148.1_linux.run
echo -e "\n\nPATCH PACKAGE FOR CUDA INSTALLATION COMPLETED\n\n"
sleep 5s

####Display cuda version after installation####
echo -e "\nInstalled CUDA version here:\n"
cat /usr/local/cuda/version.txt
sleep 10s

########### NVIDIA ###########
echo -e "\nCheck the drivers available and default driver:-"
ubuntu-drivers devices
sleep 10s
#sudo ubuntu-drivers autoinstall #auto-install all recommended drivers
sudo apt-get purge nvidia*
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install -y nvidia-390
echo -e "\n NVIDIA-390 INSTALLATION COMPLETED"
sleep 5s
echo -e "\nSystem gonna reboot..\nAfter reboot ctrl+alt+t --> nvidia-smi --> it display installed nvidia-driver information"
sleep 15s
reboot   
#nvidia-smi 
