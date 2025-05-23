# CIRBE-ISTP-CDF-skeletons
This repository contains the code used to create Common Data Format (CDF) files from data collected by the Relativistic Electron and Proton Telescope integrated little experiment-2 (REPTile-2) onboard the Colorado Inner Radiation Belt Experiment (CIRBE) spacecraft to be uploaded to NASA's Space Physics Data Center (SPDC) and Coordinated Data Analysis Web (CDAWeb).

# Instrument Description
CIRBE was a 3U cubesat containing one instrument, REPTile-2. It was launched on April 15th, 2023, into a sun-synchronous orbit with a 97.4 degree inclination and a semi-major axis of approximately 500 km. REPTile-2 is a 10x10x15 cm energetic particle telescope. It contains four 1.5 mm thick silicon detectors obtained from Micron Semiconductors in the UK. The four detectors are separated into inner areas with diameters of 20mm (referred to as 'D1' through 'D4'), and outer areas with diameters of 40mm (collectively referred to as 'G'). 

# CIRBE/REPTile-2 Data Release Assembly
These MATLAB files and supporting files are the code that assembled the NetCDF files for the initial public data release for the data collected by the Relativistic Electron and Proton Telescope integrated little experiment-2 (REPTile-2) instrument onboard the Colorado Inner Radiation Belt Experiment (CIRBE) spacecraft, which was constructed and operated by the Laboratory for Atmospheric and Space Physics (LASP), which is affiliated with the University of Colorado at Boulder. This code was written and assembled by David Brennan, who can be contacted via email at david.brennan@lasp.colorado.edu (or 2001davidbrennan@gmail.com if the previous one does not work).



# Data Assembly Notes
The raw data used to assemble these data product files are pulled from the internal LASP store. These files in the internal LASP store are not available to the public. The vast majority of data points are unaltered from the original raw telemetry from the spacecraft, but there were some errors in the data that when unadressed do not accurately reflect physical reality, so these data points were either altered, flagged, or removed. The only data points where the recorded value was altered was instances where the integration period for a specific data point was mislabeled, indicating a much higher or lower particle count rate than was actually present. There are some data points that were removed, including instances where data points are doubled or data points where the recorded counts data and the recorded time of the measurement deviate significantly from each other. Data points that are flagged include instances where the recorded time for a measurement deviates from reality by up to 10 seconds, data points that are corrupted or nonsensical, or data points where it is suspected that an issue with the pointing angle of the instrument impacts the measurements being taken.

We acknowledge the use of the IRBEM library (4.4.0) to process the data, the latest version of which can be found at https://doi.org/10.5281/zenodo.6867552. The McIlwain's L parameter, Magnetic Local Time, and magnetic latitude were calculated using the location data of the spacecraft using the IRBEM library, under an assumption of no external magnetic field. This means that these values may not exactly represent the true values at the location of the spacecraft, especially during active solar times.

# Released Data Explanation and Location.
The released data products can be accessed here: (link to SPDC). An description of the instrument can be found here: https://lasp.colorado.edu/cirbe/instrument-description/, or in the papers listed in the Acknowledgments. Brief descriptions of the variables in the data product can be found in the metadata of the files themselves. A more detailed description of the variables can be found in this readme.

# Rules of Use
The CIRBE/REPTile-2 data are available for science research. Users should contact the PI, professor Xinlin Li, to discuss the possible issues and appropriate applications of these data. Users publishing results should provide appropriate acknowledgement and should provide the version number of the data being used.

# Acknowledgments
The REPTile-2 data are provided by the University of Colorado; the REPTile-2 PI is Dr. Xinlin Li. The references below can be cited for the REPTile-2 data products. 

Reference 1:  Li, X., Kohnert, R., Palo, S., Selesnick, R., Khoo, L.-Y., Schiller, Q., et al. (2022). Two Generations of CubeSat Missions (CSSWE and CIRBE) to Take on the Challenges of Measuring Relativistic Electrons in the Earth’s Magnetosphere. Proceedings of the Small Satellite Conference, SSC22-III-03. https://digitalcommons.usu.edu/smallsat/2022/all2022/152/

Reference 2: Khoo, L.-Y., Li, X., Selesnick, R. S., Schiller, Q., Zhang, K., Zhao, H., et al. (2022). On the challenges of measuring energetic particles in the inner belt: A Geant4 simulation of an energetic particle detector instrument, REPTile-2. Journal of Geophysical Research: Space Physics, 127, e2021JA030249. https://doi.org/10.1029/2021JA030249

Reference 3: Li, X., Selesnick, R., Mei, Y., O’Brien, D., Hogan, B., Xiang, Z., et al. (2024). First results from REPTile-2 measurements onboard CIRBE. Geophysical Research Letters, 51, e2023GL107521. https://doi.org/10.1029/2023GL107521
