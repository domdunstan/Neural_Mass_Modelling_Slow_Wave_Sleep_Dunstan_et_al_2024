# Neural Mass Modelling Slow Wave Sleep Dunstan et al 2024
This repository contains code to generate the figures and run the algorithms described in Dunstan et al. (2025) https://onlinelibrary.wiley.com/doi/10.1111/epi.18293

This software uses a number of external toolboxes. We are grateful to the 
authors of these toolboxes. In each case, the licenses are stated within the corresponding header.

See Dunstan_et_al_figures.m script for recreating figures in the paper from saved datasets.

See Dunstan_et_al_MOEA_example.m for implementing the multiobjective evolutionary algorithm described in the paper to an example subject.
For further details on optimizing neural mass models to data using evolutionary algorithm, see the toolbox 'NerualMassModellingToolbox' and Dunstan et al 2023  https://doi.org/10.1371/journal.pcbi.1010985

Note, for computational efficiency, a mex function is generated and utilized throughout this toolbox. Hence, the mex functionality needs to be enabled. See Dunstan_et_al_figures.m for further details or https://www.mathworks.com/help/matlab/ref/mex.html.

For any queries, please email me: dmd206@exeter.ac.uk
