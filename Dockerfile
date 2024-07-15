# Copyright 2023-2024 The MathWorks, Inc.

# To specify which MATLAB release to install in the container, edit the value of the MATLAB_RELEASE argument.
# Use lower case to specify the release, for example: ARG MATLAB_RELEASE=r2024a
ARG MATLAB_RELEASE=r2024a

# This Dockerfile builds on the Ubuntu-based mathworks/matlab image.
# To check the available matlab images, see: https://hub.docker.com/r/mathworks/matlab
FROM mathworks/matlab:$MATLAB_RELEASE

# Declare the global argument to use at the current build stage
ARG MATLAB_RELEASE

# By default, the MATLAB container runs as user "matlab". To install mpm dependencies, switch to root.
USER root

# Install mpm dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --no-install-recommends --yes \
    wget \
    unzip \
    ca-certificates \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Run mpm to install MathWorks products into the existing MATLAB installation directory,
# and delete the mpm installation afterwards.
# If mpm fails to install successfully then output the logfile to the terminal, otherwise cleanup.

# Switch to user matlab, and pass in $HOME variable to mpm,
# so that mpm can set the correct root folder for the support packages.
WORKDIR /tmp
USER matlab
RUN wget -q https://www.mathworks.com/mpm/glnxa64/mpm \
    && chmod +x mpm \
    && EXISTING_MATLAB_LOCATION=$(dirname $(dirname $(readlink -f $(which matlab)))) \
    && sudo HOME=${HOME} ./mpm install \
        --destination=${EXISTING_MATLAB_LOCATION} \
        --release=${MATLAB_RELEASE} \
        --doc \
        --products \
        5G_Toolbox \
        #AUTOSAR_Blockset \
        #Aerospace_Blockset \
        #Aerospace_Toolbox \
        Antenna_Toolbox \
        #Audio_Toolbox \
        #Automated_Driving_Toolbox \
        #Bioinformatics_Toolbox \
        Bluetooth_Toolbox \
        Communications_Toolbox \
        Computer_Vision_Toolbox \
        Control_System_Toolbox \
        Curve_Fitting_Toolbox \
        #DDS_Blockset \
        #DO_Qualification_Kit \
        #DSP_HDL_Toolbox \
        DSP_System_Toolbox \
        #Database_Toolbox \
        #Datafeed_Toolbox \
        #Deep_Learning_HDL_Toolbox \
        Deep_Learning_Toolbox \
        #Econometrics_Toolbox \
        #Embedded_Coder \
        #Filter_Design_HDL_Coder \
        #Financial_Instruments_Toolbox \
        #Financial_Toolbox \
        Fixed-Point_Designer \
        Fuzzy_Logic_Toolbox \
        #GPU_Coder \
        Global_Optimization_Toolbox \
        #HDL_Coder \
        #HDL_Verifier \
        #IEC_Certification_Kit \
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
        #MATLAB_Web_App_Server \
        #Mapping_Toolbox \
        # Mixed-Signal_Blockset \
        Model_Predictive_Control_Toolbox \
        # Motor_Control_Blockset \
        Navigation_Toolbox \
        Optimization_Toolbox \
        Parallel_Computing_Toolbox \
        Partial_Differential_Equation_Toolbox \
        Phased_Array_System_Toolbox \
        #Polyspace_Bug_Finder \
        #Polyspace_Bug_Finder_Server \
        #Polyspace_Code_Prover \
        #Polyspace_Code_Prover_Server \
        #Powertrain_Blockset \
        #Predictive_Maintenance_Toolbox \
        # RF_Blockset \
        #RF_PCB_Toolbox \
        RF_Toolbox \
        ROS_Toolbox \
        Radar_Toolbox \
        Reinforcement_Learning_Toolbox \
        #Requirements_Toolbox \
        #Risk_Management_Toolbox \
        Robotics_System_Toolbox \
        Robust_Control_Toolbox \
        Satellite_Communications_Toolbox \
        Sensor_Fusion_and_Tracking_Toolbox \
        #SerDes_Toolbox \
        Signal_Integrity_Toolbox \
        Signal_Processing_Toolbox \
        #SimBiology \
        #SimEvents \
        #Simscape \
        #Simscape_Driveline \
        #Simscape_Electrical \
        #Simscape_Fluids \
        #Simscape_Multibody \
        Simulink \
        #Simulink_3D_Animation \
        #Simulink_Check \
        #Simulink_Code_Inspector \
        #Simulink_Coder \
        #Simulink_Compiler \
        #Simulink_Control_Design \
        #Simulink_Coverage \
        #Simulink_Design_Optimization \
        #Simulink_Design_Verifier \
        #Simulink_Desktop_Real-Time \
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
        # Vehicle_Dynamics_Blockset \
        Vehicle_Network_Toolbox \
        #Vision_HDL_Toolbox \
        WLAN_Toolbox \
        Wavelet_Toolbox \
        #Wireless_HDL_Toolbox \
        Wireless_Testbench \
    || (echo "MPM Installation Failure. See below for more information:" && cat /tmp/mathworks_root.log && false) \
    && sudo rm -rf mpm /tmp/mathworks_root.log ${HOME}/.MathWorks

# When running the container a license file can be mounted,
# or a license server can be provided as an environment variable.
# For more information, see https://hub.docker.com/r/mathworks/matlab

# Alternatively, you can provide a license server to use
# with the docker image while building the image.
# Specify the host and port of the machine that serves the network licenses 
# if you want to bind in the license info as an environment variable.
# You can also build with something like --build-arg LICENSE_SERVER=27000@MyServerName,
# in which case you should uncomment the following two lines.
# If these lines are uncommented, $LICENSE_SERVER must be a valid license
# server or browser mode will not start successfully.
# ARG LICENSE_SERVER
# ENV MLM_LICENSE_FILE=$LICENSE_SERVER

# The following environment variables allow MathWorks to understand how this MathWorks 
# product is being used. This information helps us make MATLAB even better. 
# Your content, and information about the content within your files, is not shared with MathWorks. 
# To opt out of this service, delete the environment variables defined in the following line.
# See the Help Make MATLAB Even Better section in the accompanying README to learn more: 
# https://github.com/mathworks-ref-arch/matlab-dockerfile#help-make-matlab-even-better
ENV MW_DDUX_FORCE_ENABLE=true MW_CONTEXT_TAGS=$MW_CONTEXT_TAGS,MATLAB:TOOLBOXES:DOCKERFILE:V1

WORKDIR /home/matlab
