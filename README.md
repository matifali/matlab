# matlab

A custom matlab docker image for my own use.

This image has been built on top of the [matlab](https://hub.docker.com/r/mathworks/matlab/) image from MathWorks.

## Build

Builds on `mathworks/matlab:r2026a` by default. Override with `MATLAB_RELEASE`:

```bash
docker build -t matlab .
docker build --build-arg MATLAB_RELEASE=r2025b -t matlab:r2025b .
```

## Run MATLAB in desktop mode and interact with it via VNC

To start the MATLAB desktop, execute:

```bash
docker run -it --rm -p 5901:5901 -p 6080:6080 --shm-size=512M ghcr.io/matifali/matlab:latest -vnc
```

To connect to the MATLAB desktop, either:

1. Point a browser to port 6080 of the docker host machine running this container e.g [http://localhost:6080](http://localhost:6080) for the local machine.
2. Use a VNC client to connect to display 1 of the docker host machine (hostname:1)
The VNC password is matlab by default. Use the `PASSWORD` environment variable to change it.

## Run MATLAB and interact with it via a web browser

To start the container, execute:

```bash
docker run -it --rm -p 8888:8888 --shm-size=512M ghcr.io/matifali/matlab:latest -browser
```

Running the above command prints text to your terminal containing the URL to access MATLAB. For example:

MATLAB can be accessed at:
[http://localhost:8888/index.html](http://localhost:8888/index.html)

## List of toolboxes

All R2026a products. Uncommented ones are installed in this image; edit the `--products` list in the Dockerfile to change it.

```bash
    5G_Toolbox \
    #AUTOSAR_Blockset \
    #Aerospace_Blockset \
    #Aerospace_Toolbox \
    Antenna_Toolbox \
    #Audio_Toolbox \
    #Automated_Driving_Toolbox \
    #Bioinformatics_Toolbox \
    Bluetooth_Toolbox \
    #C2000_Microcontroller_Blockset \
    Communications_Toolbox \
    Computer_Vision_Toolbox \
    Control_System_Toolbox \
    Curve_Fitting_Toolbox \
    #DDS_Blockset \
    #DSP_HDL_Toolbox \
    DSP_System_Toolbox \
    #Data_Acquisition_Toolbox \
    #Database_Toolbox \
    #Datafeed_Toolbox \
    #Deep_Learning_HDL_Toolbox \
    Deep_Learning_Toolbox \
    #Econometrics_Toolbox \
    #Embedded_Coder \
    #Financial_Instruments_Toolbox \
    #Financial_Toolbox \
    Fixed-Point_Designer \
    Fuzzy_Logic_Toolbox \
    #GPU_Coder \
    Global_Optimization_Toolbox \
    #HDL_Coder \
    #HDL_Verifier \
    #Image_Acquisition_Toolbox \
    Image_Processing_Toolbox \
    #Industrial_Communication_Toolbox \
    #Instrument_Control_Toolbox \
    LTE_Toolbox \
    Lidar_Toolbox \
    #MATLAB \
    MATLAB_Coder \
    MATLAB_Compiler \
    MATLAB_Compiler_SDK \
    MATLAB_Parallel_Server \
    #MATLAB_Production_Server \
    #MATLAB_Report_Generator \
    #MATLAB_Test \
    #MATLAB_Web_App_Server \
    #Mapping_Toolbox \
    #Medical_Imaging_Toolbox \
    #Mixed-Signal_Blockset \
    Model_Predictive_Control_Toolbox \
    #Model-Based_Calibration_Toolbox \
    #Motor_Control_Blockset \
    Navigation_Toolbox \
    Optimization_Toolbox \
    Parallel_Computing_Toolbox \
    Partial_Differential_Equation_Toolbox \
    Phased_Array_System_Toolbox \
    #Polyspace_Bug_Finder \
    #Polyspace_Bug_Finder_Server \
    #Polyspace_Code_Prover \
    #Polyspace_Code_Prover_Server \
    #Polyspace_Test \
    #Polyspace_as_You_Code \
    #Powertrain_Blockset \
    #Predictive_Maintenance_Toolbox \
    #RF_Blockset \
    #RF_PCB_Toolbox \
    RF_Toolbox \
    ROS_Toolbox \
    Radar_Toolbox \
    #Raspberry_Pi_Blockset \
    Reinforcement_Learning_Toolbox \
    #Requirements_Toolbox \
    #Risk_Management_Toolbox \
    Robotics_System_Toolbox \
    Robust_Control_Toolbox \
    #STM32_Microcontroller_Blockset \
    Satellite_Communications_Toolbox \
    Sensor_Fusion_and_Tracking_Toolbox \
    #SerDes_Toolbox \
    Signal_Integrity_Toolbox \
    Signal_Processing_Toolbox \
    #SimBiology \
    #SimEvents \
    #Simscape \
    #Simscape_Battery \
    #Simscape_Driveline \
    #Simscape_Electrical \
    #Simscape_Fluids \
    #Simscape_Multibody \
    Simulink \
    #Simulink_3D_Animation \
    #Simulink_Check \
    #Simulink_Coder \
    #Simulink_Compiler \
    #Simulink_Control_Design \
    #Simulink_Coverage \
    #Simulink_Design_Optimization \
    #Simulink_Design_Verifier \
    #Simulink_Desktop_Real-Time \
    #Simulink_FMU_Builder \
    #Simulink_Fault_Analyzer \
    #Simulink_PLC_Coder \
    #Simulink_Real-Time \
    #Simulink_Report_Generator \
    #Simulink_Test \
    #SoC_Blockset \
    #Spreadsheet_Link \
    #Stateflow \
    Statistics_and_Machine_Learning_Toolbox \
    Symbolic_Math_Toolbox \
    #System_Composer \
    System_Identification_Toolbox \
    Text_Analytics_Toolbox \
    UAV_Toolbox \
    #Vehicle_Dynamics_Blockset \
    Vehicle_Network_Toolbox \
    #Vision_HDL_Toolbox \
    WLAN_Toolbox \
    Wavelet_Toolbox \
    #Wireless_HDL_Toolbox \
    #Wireless_Network_Toolbox \
    Wireless_Testbench
```
