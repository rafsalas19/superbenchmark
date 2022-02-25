#!/bin/bash

#rm -rf superbenchmark
#git clone -b v0.4.0 https://github.com/microsoft/superbenchmark
#cd superbenchmark
#git submodule add https://github.com/wilicc/gpu-burn.git third_party/gpu-burn
#cat .gitmodules
#cp ../Makefile third_party
#cp ../superbench/benchmarks/micro_benchmarks/* superbench/benchmarks/micro_benchmarks/
pip uninstall -y superbench
python3 -m pip install .
make postinstall
sleep 5
sb deploy -f ../local.ini -i superbench/superbench:v0.4.0-cuda11.1.1
sudo docker container ls
make -C third_party/gpu-burn

#sudo docker exec sb-workspace bash -c "make -C third_party/gpu-burn"
sudo docker cp superbench/benchmarks/micro_benchmarks/gpu_burn_test.py  sb-workspace:/opt/superbench/superbench/benchmarks/micro_benchmarks/
sudo docker cp superbench/benchmarks/micro_benchmarks/__init__.py  sb-workspace:/opt/superbench/superbench/benchmarks/micro_benchmarks/
sudo docker cp third_party/gpu-burn/gpu_burn sb-workspace:/opt/superbench/bin
sudo docker cp third_party/gpu-burn/compare.ptx sb-workspace:/opt/superbench/bin
sudo docker exec sb-workspace bash -c  'pip uninstall -y superbench'
sudo docker exec sb-workspace bash -c  'cd /opt/superbench/ && python3 -m pip install .'
