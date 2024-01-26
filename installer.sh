#!/bin/bash

su -c "wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda_11.7.0_515.43.04_linux.run && \
sh cuda_11.7.0_515.43.04_linux.run && \
wget cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive.tar.xz && \
tar -xf cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive.tar.xz && \
mv cudnn-linux-x86_64-8.4.1.50_cuda11.6-archive cuda && \
cp ./cuda/include/* /usr/local/cuda-11.7/include/ && \
cp ./cuda/lib/* /usr/local/cuda-11.7/lib64/ && \
chmod a+r /usr/local/cuda-11.7/lib64/* && \
chmod a+r /usr/local/cuda-11.7/include/*"

pacman -S cudnn --noconfirm --needed

echo '# CUDA' >> ~/.bashrc
echo 'export PATH=/usr/local/cuda-11.7/bin${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
source ~/.bashrc

conda create -n videoEnv python=3.8
conda activate videoEnv

git clone https://github.com/YaoFANGUK/video-subtitle-remover && cd video-subtitle-remover

pip install torch==2.1.0 torchvision==0.16.0 --index-url https://download.pytorch.org/whl/cu118
pip install paddlepaddle-gpu==2.4.2.post117 -f https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html
pip install -r requirements.txt
