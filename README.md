# Exploring grid sensitivity in an ice sheet model: a case study of the Amery Ice Shelf https://doi.org/10.1016/j.accre.2024.12.001
# What's this?
These are the scripts used to compute data and produce figures for the paper:
Qian-Xi Wang, Teng Li, Xiao Cheng, Chen Zhao, Lei Zheng, Qi Liang (2024), Exploring grid sensitivity in an ice sheet model: A case study of the Amery Ice Shelf, Advances in Climate Change Research. https://doi.org/10.1016/j.accre.2024.12.001.(https://www.sciencedirect.com/science/article/pii/S1674927824001783)
# Unstructured Grid File
File Location: Grid_Sensitivity/Mesh
Purpose: This file contains the unstructured grid system used to enhance the simulation of the Amery Ice Shelf. The grid is designed to adaptively adjust its resolution to provide a more detailed representation of the ice sheet's complex geometry and dynamics, particularly in critical glacial flow areas.
Key Features:
Adaptive Resolution: Automatically refines grid resolution in areas of interest for improved accuracy.
High Precision in Key Areas: Offers enhanced detail within 20 km downstream of the grounding line, essential for simulating ice sheet margins.
Efficiency: Balances computational efficiency with the precision of glacial dynamic representation.
# Inversion Model Parameter File
File Location: Grid_Sensitivity/Experiment_Setup
Purpose: This file includes the settings and configurations for the inversion experiments conducted in the study. It defines the parameters and conditions used to evaluate the sensitivity of inversion parameters to grid resolution and assess the transferability of these parameters across different grid resolutions.
Key Components:
Parameter Definitions: Specifies the rate factor A and basal slipperiness coefficient C used in the model.
Grid Resolution Sensitivity: Contains the setups for experiments that test how changes in grid resolution affect model outcomes.
Transferability Assessment: Setups for experiments that determine if inversion parameters can be transferred between grid systems of different resolutions.
# Calving Model Parameter File
File Location: Grid_Sensitivity/Calve
Purpose: This file contains the model parameter settings related to the ice sheet's response to idealized calving scenarios. It is used to investigate the consistent response of the Antarctic Ice Sheet to hypothetical collapse situations.
Key Focus Areas:
Calving Scenarios: Parameters that simulate the effects of ice shelf calving on the ice sheet's dynamics.
Buttressing Effect: Settings that help assess the impact of ice shelf buttressing on the grounded ice.
Response Consistency: Configurations that test the model's response to different calving events and their implications for ice sheet stability.
