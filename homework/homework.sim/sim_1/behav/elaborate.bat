@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.1\\bin
call %xv_path%/xelab  -wto 97d6c19998c54318a5db2c47fef41e29 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot lab1_behav xil_defaultlib.lab1 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
