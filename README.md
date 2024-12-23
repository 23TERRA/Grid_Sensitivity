# Exploring grid sensitivity in an ice sheet model: a case study of the Amery Ice Shelf https://doi.org/10.1016/j.accre.2024.12.001
# What's this?
These are the scripts used to compute data and produce figures for the paper:
Qian-Xi Wang, Teng Li, Xiao Cheng, Chen Zhao, Lei Zheng, Qi Liang (2024), Exploring grid sensitivity in an ice sheet model: A case study of the Amery Ice Shelf, Advances in Climate Change Research. https://doi.org/10.1016/j.accre.2024.12.001.(https://www.sciencedirect.com/science/article/pii/S1674927824001783)
# Unstructured Grid File
File Location: Grid_Sensitivity/Mesh;

Purpose: This file contains the unstructured grid system used to enhance the simulation of the Amery Ice Shelf. The grid is designed to adaptively adjust its resolution to provide a more detailed representation of the ice sheet's complex geometry and dynamics, particularly in critical glacial flow areas.
Key Features:

Adaptive Resolution: Automatically refines grid resolution in areas of interest for improved accuracy.

High Precision in Key Areas: 1. Floating Ice Shelf Grid Size: We set the grid size over the floating ice shelf to 2 km to capture the details of this dynamic region more accurately.
2. Within 10 km of the Grounding Line: The grid size was set to 2 km to better resolve the complex dynamics occurring near the boundary between the ice sheet and the ocean.
Within 5 km of the Grounding Line: To achieve even greater detail in the most critical zone, we reduced the grid size to 1 km.
3. Non-Tributary Glaciers: For regions that are not part of the main glacial flow, we used a grid size of 20 km, which strikes a balance between detail and computational efficiency.
4. High-Strain-Rate Areas: In areas where the ice experiences high strain rates, indicative of rapid flow or deformation, we refined the grid to 2 km to ensure that these areas are represented with the necessary precision.

Efficiency: Balances computational efficiency with the precision of glacial dynamic representation.

# Inversion Model Parameter File
File Location: Grid_Sensitivity/Experiment_Setup;

Purpose: This file includes the settings and configurations for the inversion experiments conducted in the study. It defines the parameters and conditions used to evaluate the sensitivity of inversion parameters to grid resolution and assess the transferability of these parameters across different grid resolutions.

Key Components:
1. Parameter Definitions: Specifies the rate factor A and basal slipperiness coefficient C used in the model.
2. Grid Resolution Sensitivity: Contains the setups for experiments that test how changes in grid resolution affect model outcomes.
3. Transferability Assessment: Setups for experiments that determine if inversion parameters can be transferred between grid systems of different resolutions.
# Calving Model Parameter File
File Location: Grid_Sensitivity/Calve;

Purpose: This file contains the model parameter settings related to the ice sheet's response to idealized calving scenarios. It is used to investigate the consistent response of the Antarctic Ice Sheet to hypothetical collapse situations.

Key Focus Areas:
1. Calving Scenarios: Parameters that simulate the effects of ice shelf calving on the ice sheet's dynamics.
2. Buttressing Effect: Settings that help assess the impact of ice shelf buttressing on the grounded ice.
3. Response Consistency: Configurations that test the model's response to different calving events and their implications for ice sheet stability.
