
lower_energy_edges = [0.24,0.24,0.25,0.25,0.26,0.27,0.28,0.29,0.30,0.32,0.33,0.35,0.37,0.39,0.41,0.43,0.46,0.49,0.52,0.56,0.6,0.64,0.69,0.74,0.79,0.85,0.92,0.99,1.07,1.15,1.24,1.34,1.45,1.57,1.69,1.83,1.98,2.14,2.32,2.51,2.72,2.94,3.19,3.46,3.74,4.06,4.41,4.77,5.21,5.62]'; %from the SI for lengying's paper
upper_energy_edges = [0.3,0.35,0.32,0.31,0.32,0.33,0.33,0.34,0.35,0.36,0.37,0.39,0.41,0.43,0.45,0.47,0.5,0.53,0.57,0.61,0.65,0.69,0.74,0.8,0.86,0.92,0.99,1.07,1.15,1.25,1.34,1.45,1.57,1.69,1.83,1.98,2.15,2.32,2.52,2.72,2.95,3.2,3.46,3.75,4.07,4.46,4.84,5.2,5.61,6.08]';

energy_edges = single(horzcat(lower_energy_edges,upper_energy_edges));

%FOLLOWING COMMANDS USE THE SPDF CDF PATCH FOR MATLAB
timeminvalue = spdfdatenumtoepoch(datenum('2000/01/01 00:00:00')+(735236932702/1000/3600/24)); %first Epoch value on first day of data, taken manually from 4/19/2023 file
timemaxvalue = spdfdatenumtoepoch(datenum('2000/01/01 00:00:00')+(780822875132/1000/3600/24)); %last Epoch value on last day of data, taken manually from 9/28/2024 file
timeminvaluepoint = spdfdatenumtoepoch(datenum('2000/01/01 00:00:00')+(735184418000/1000/3600/24)); %first Pointing_timestamp value on first day of data, taken manually from 4/19/2023 file
timemaxvaluepoint = spdfdatenumtoepoch(datenum('2000/01/01 00:00:00')+(780875299000/1000/3600/24)); %last Pointing_timestamp value on last day of data, taken manually from 9/28/2024 file

time_fillval = spdfparseepoch('9999-12-31T23:59:59.999');

trange = ['2023-04-19';'2024-09-28']; %Selects the time range for which files will be automatically created
%trange = ['2023-04-19';'2023-04-26']; %there are multiple just for convenience
%trange = ['2024-01-01';'2024-01-31'];
%trange = ['2024-08-29';'2024-09-28'];

start_datenum = datenum(trange(1,:));
end_datenum = datenum(trange(2,:));

for i = start_datenum:end_datenum
    file_datestring_1 = datestr(i,"yyyymmdd");
    file_datestring_2 = datestr(i,"yyyy_mm_dd");
    file_path_1 = ['C:\Users\2001d\OneDrive - UCB-O365\Desktop\LASP Data\Data release\spdf_cdf_files\l2_electron_files\CIRBE_REPTile-2_L2_electron_',file_datestring_1,'v1_0.nc']; %previously created L2 file, not released to public, change path
    file_path_2 = ['CIRBE_L1_combined_science_',file_datestring_2,'_V0.nc']; %original combined science file, path is not specified because I have added these to global path, you will need to either add these to your global path or specify the path in the code
    file_path_4 = ['C:\Users\2001d\OneDrive - UCB-O365\Desktop\LASP Data\Data release\netcdf file\daily_netcdf_v2_1\CIRBE_REPTile-2_L1_',file_datestring_1,'v2_0.nc']; %previously created (and released) L1 file, if you put all of these into a file and then properly specify the path you should be fine
    fileID_CIRBE_1 = fopen(file_path_2);
    if fileID_CIRBE_1 > 0

        Datafilename = strjoin(["cirbe_reptile-2_l1b_rng_elecs_",file_datestring_1,"_v01_01.cdf"],"");
        skeleton = cdflib.create(Datafilename); %creating the file itself
        cdflib.setMajority(skeleton,"COLUMN_MAJOR") %set to column major because this works best with matlab
        
        % CREATING AND WRITING GLOBAL ATTRIBUTES
        
        project = cdflib.createAttr(skeleton,"Project","global_scope");
        cdflib.putAttrgEntry(skeleton,project,0,"CDF_CHAR","H-FORT>Heliophysics-Flight Opportunities in Research and Technology")
        
        source_name = cdflib.createAttr(skeleton,"Source_name","global_scope");
        cdflib.putAttrgEntry(skeleton,source_name,0,"CDF_CHAR","CIRBE>Colorado Inner Radiation Belt Experiment")
        
        discipline = cdflib.createAttr(skeleton,"Discipline","global_scope");
        cdflib.putAttrgEntry(skeleton,discipline,0,"CDF_CHAR","Space Physics>Magnetospheric Science")
        cdflib.putAttrgEntry(skeleton,discipline,1,"CDF_CHAR","Solar Physics>Heliospheric Physics")
        
        data_type = cdflib.createAttr(skeleton,"Data_type","global_scope");
        cdflib.putAttrgEntry(skeleton,data_type,0,"CDF_CHAR","L1B>Level 1B Data Product>Range Electrons")
        
        descriptor = cdflib.createAttr(skeleton,"Descriptor","global_scope");
        cdflib.putAttrgEntry(skeleton,descriptor,0,"CDF_CHAR","REPTile-2>Relativistic Electron Proton Telescope integrated little experiment-2")
        
        data_version = cdflib.createAttr(skeleton,"Data_version","global_scope");
        cdflib.putAttrgEntry(skeleton,data_version,0,"CDF_CHAR","v01_01") %change if version changes
        
        file_id = cdflib.createAttr(skeleton,"Logical_file_id","global_scope");
        cdflib.putAttrgEntry(skeleton,file_id,0,"CDF_CHAR","cirbe_reptile-2_l1b_rng_elecs_yyyyMMdd_v01_01")
        
        pi_name = cdflib.createAttr(skeleton,"PI_name","global_scope");
        cdflib.putAttrgEntry(skeleton,pi_name,0,"CDF_CHAR","Xinlin Li")
        
        pi_affil = cdflib.createAttr(skeleton,"PI_affiliation","global_scope");
        cdflib.putAttrgEntry(skeleton,pi_affil,0,"CDF_CHAR","University of Colorado at Boulder")
        
        text = cdflib.createAttr(skeleton,"TEXT","global_scope");
        cdflib.putAttrgEntry(skeleton,text,0,"CDF_CHAR","CIRBE is a 3U-CubeSat designed and developed by students and engineers at the Laboratory for Atmospheric and Space Physics.")
        cdflib.putAttrgEntry(skeleton,text,1,"CDF_CHAR","The primary objective of the science mission is to understand the formation of the inner belt (L<2) electrons (100s of keV to multiple MeV), and to determine the source, the intensity and dynamic variations of these electrons.")
        cdflib.putAttrgEntry(skeleton,text,2,"CDF_CHAR","The goal is to make accurate measurements with fine energy resolution (>40 channels) for electrons of 0.3-3 MeV throughout the slot region and inner belt, with secondary measurements of 6.7-35 MeV protons.")
        cdflib.putAttrgEntry(skeleton,text,3,"CDF_CHAR","Such measurements are required to address the following science questions:")
        cdflib.putAttrgEntry(skeleton,text,4,"CDF_CHAR","1) Where is the break point in terms of energy of electrons for a given event, below which electrons can be transported into the inner belt from the outer belt but above which electrons cannot, and what is the injection mechanism?")
        cdflib.putAttrgEntry(skeleton,text,5,"CDF_CHAR","2) What is the CRAND contribution to inner belt electrons, and what is the low energy neutron density near Earth?")
        cdflib.putAttrgEntry(skeleton,text,6,"CDF_CHAR","3) What is the role of wave-particle interactions in shaping inner-belt electron energy spectra?")
        cdflib.putAttrgEntry(skeleton,text,7,"CDF_CHAR","A detailed description of the instrument can be found at https://doi.org/10.1029/2021JA030249.")
        cdflib.putAttrgEntry(skeleton,text,8,"CDF_CHAR","We acknowledge the use of the IRBEM library (4.4.0) to process the data, the latest version of which can be found at https://doi.org/10.5281/zenodo.6867552.")
        
        rules = cdflib.createAttr(skeleton,"Rules_of_use","global_scope");
        cdflib.putAttrgEntry(skeleton,rules,0,"CDF_CHAR","The CIRBE/REPTile-2 data are available for science research. Users should contact the PI, professor Xinlin Li, to discuss the possible issues and appropriate applications of these data. Users publishing results should provide appropriate acknowledgement and should provide the version number of the data being used.")
        
        acks = cdflib.createAttr(skeleton,"Acknowledgment","global_scope");
        cdflib.putAttrgEntry(skeleton,acks,0,"CDF_CHAR","The REPTile-2 data are provided by the University of Colorado. The following references can be cited for the REPTile-2 data products.")
        cdflib.putAttrgEntry(skeleton,acks,1,"CDF_CHAR","Mission Overview Paper > Li, X., Kohnert, R., Palo, S., Selesnick, R., Khoo, L.-Y., Schiller, Q., et al. (2022). Two Generations of CubeSat Missions (CSSWE and CIRBE) to Take on the Challenges of Measuring Relativistic Electrons in the Earth’s Magnetosphere. Proceedings of the Small Satellite Conference, SSC22-III-03. https://digitalcommons.usu.edu/smallsat/2022/all2022/152/.")
        cdflib.putAttrgEntry(skeleton,acks,2,"CDF_CHAR","Instrument Calibration Paper > Khoo, L.-Y., Li, X., Selesnick, R. S., Schiller, Q., Zhang, K., Zhao, H., et al. (2022). On the challenges of measuring energetic particles in the inner belt: A Geant4 simulation of an energetic particle detector instrument, REPTile-2. Journal of Geophysical Research: Space Physics, 127, e2021JA030249. https://doi.org/10.1029/2021JA030249.")
        cdflib.putAttrgEntry(skeleton,acks,3,"CDF_CHAR","First Results Paper > Li, X., Selesnick, R., Mei, Y., O''Brien, D., Hogan, B., Xiang, Z., et al. (2024). First results from REPTile-2 measurements onboard CIRBE. Geophysical Research Letters, 51, e2023GL107521. https://doi.org/10.1029/2023GL107521.")
        
        type = cdflib.createAttr(skeleton,"Instrument_type","global_scope");
        cdflib.putAttrgEntry(skeleton,type,0,"CDF_CHAR","Particles (space)")
        
        group = cdflib.createAttr(skeleton,"Mission_group","global_scope");
        cdflib.putAttrgEntry(skeleton,group,0,"CDF_CHAR","Smallsats/Cubesats")
        
        source = cdflib.createAttr(skeleton,"Logical_source","global_scope");
        cdflib.putAttrgEntry(skeleton,source,0,"CDF_CHAR","cirbe_reptile-2_l1b_rng_elecs")
        
        source_desc = cdflib.createAttr(skeleton,"Logical_source_description","global_scope");
        cdflib.putAttrgEntry(skeleton,source_desc,0,"CDF_CHAR","Colorado Inner Radiation Belt Experiment, Relativistic Electron Proton Telescope integrated little experiment-2, Level 1B Data Product, Range Electrons")
        
        generated_by = cdflib.createAttr(skeleton,"Generated_by","global_scope");
        cdflib.putAttrgEntry(skeleton,generated_by,0,"CDF_CHAR","Laboratory for Atmospheric and Space Physics, David Brennan")
        
        % CREATING VARIABLE ATTRIBUTES
        
        catdesc = cdflib.createAttr(skeleton,"CATDESC","variable_scope");
        fieldnam = cdflib.createAttr(skeleton,"FIELDNAM","variable_scope");
        validmin = cdflib.createAttr(skeleton,"VALIDMIN","variable_scope");
        validmax = cdflib.createAttr(skeleton,"VALIDMAX","variable_scope");
        scalemin = cdflib.createAttr(skeleton,"SCALEMIN","variable_scope");
        scalemax = cdflib.createAttr(skeleton,"SCALEMAX","variable_scope");
        scaletyp = cdflib.createAttr(skeleton,"SCALETYP","variable_scope");
        units = cdflib.createAttr(skeleton,"UNITS","variable_scope");
        lablaxis = cdflib.createAttr(skeleton,"LABLAXIS","variable_scope");
        display_type = cdflib.createAttr(skeleton,"DISPLAY_TYPE","variable_scope");
        fillval = cdflib.createAttr(skeleton,"FILLVAL","variable_scope");
        format = cdflib.createAttr(skeleton,"FORMAT","variable_scope");
        var_type = cdflib.createAttr(skeleton,"VAR_TYPE","variable_scope");
        var_notes = cdflib.createAttr(skeleton,"VAR_NOTES","variable_scope");
        depend_0 = cdflib.createAttr(skeleton,"DEPEND_0","variable_scope");
        depend_1 = cdflib.createAttr(skeleton,"DEPEND_1","variable_scope");
        time_scale = cdflib.createAttr(skeleton,"TIME_SCALE","variable_scope");
        bin_location = cdflib.createAttr(skeleton,"BIN_LOCATION","variable_scope");
        resolution = cdflib.createAttr(skeleton,"RESOLUTION","variable_scope");
        monoton = cdflib.createAttr(skeleton,"MONOTON","variable_scope");
        
        % CREATING VARIABLES
        
        epoch = cdflib.createVar(skeleton,"Epoch","CDF_EPOCH",1,[],true,[]);
        alt = cdflib.createVar(skeleton,"Altitude","CDF_REAL4",1,[],true,[]);
        lat = cdflib.createVar(skeleton,"Latitude","CDF_REAL4",1,[],true,[]);
        lon = cdflib.createVar(skeleton,"Longitude","CDF_REAL4",1,[],true,[]);
        mcL = cdflib.createVar(skeleton,"L_McIlwain","CDF_REAL4",1,[],true,[]);
        mlt = cdflib.createVar(skeleton,"MLT","CDF_REAL4",1,[],true,[]);
        mlat = cdflib.createVar(skeleton,"MLAT","CDF_REAL4",1,[],true,[]);
        rng_energy_e = cdflib.createVar(skeleton,"Channel_Energies","CDF_REAL4",1,50,false,true);
        rng_energy_edges_e = cdflib.createVar(skeleton,"Channel_Energy_Edges","CDF_REAL4",1,[50 2],false,[true true]);
        rng_countrate_e = cdflib.createVar(skeleton,"Channel_Count_Rates","CDF_REAL8",1,50,true,true);
        rng_counts_e = cdflib.createVar(skeleton,"Channel_Counts","CDF_INT4",1,50,true,true);
        intprd = cdflib.createVar(skeleton,"Integration_Period","CDF_INT2",1,[],true,[]);
        point = cdflib.createVar(skeleton,"Spacecraft_Pointing_Mode","CDF_INT2",1,[],true,[]);
        flag = cdflib.createVar(skeleton,"Data_Quality_Flag","CDF_INT2",1,[],true,[]);
        offang_time = cdflib.createVar(skeleton,"Epoch_2","CDF_EPOCH",1,[],true,[]);
        offang = cdflib.createVar(skeleton,"Pointing_Angle","CDF_REAL4",1,[],true,[]);

        % SETTING VARIABLE COMPRESSION (ONLY MULTI-DIMENSIONAL VARIABLES)
        cdflib.setVarCompression(skeleton,9,"GZIP_COMPRESSION",6) %using gzip6 because it is the most common
        cdflib.setVarCompression(skeleton,10,"GZIP_COMPRESSION",6)
        
        % WRITING ATTRIBUTES TO VARIABLES
        
        %CATDESC
        cdflib.putAttrEntry(skeleton,catdesc,0,"CDF_CHAR","Default Epoch in UTC")
        cdflib.putAttrEntry(skeleton,catdesc,1,"CDF_CHAR","Geodetic Altitude of CIRBE in km")
        cdflib.putAttrEntry(skeleton,catdesc,2,"CDF_CHAR","Geodetic Latitude of CIRBE in Degrees (-90 to 90)")
        cdflib.putAttrEntry(skeleton,catdesc,3,"CDF_CHAR","Geodetic Longitude of CIRBE in Degrees (-180 to 180)")
        cdflib.putAttrEntry(skeleton,catdesc,4,"CDF_CHAR","McIlwain's L Parameter at CIRBE's Position")
        cdflib.putAttrEntry(skeleton,catdesc,5,"CDF_CHAR","Magnetic Local Time at CIRBE's Position (0 to 24)")
        cdflib.putAttrEntry(skeleton,catdesc,6,"CDF_CHAR","Magnetic Latitude at CIRBE's Position (-90 to 90)")
        cdflib.putAttrEntry(skeleton,catdesc,7,"CDF_CHAR","Characteristic Energies of the Channels in MeV")
        cdflib.putAttrEntry(skeleton,catdesc,8,"CDF_CHAR","Energy Edges of the Channels in MeV")
        cdflib.putAttrEntry(skeleton,catdesc,9,"CDF_CHAR","Range Electron Count Rates per Channel Energy")
        cdflib.putAttrEntry(skeleton,catdesc,10,"CDF_CHAR","Range Electron Counts per Channel Energy")
        cdflib.putAttrEntry(skeleton,catdesc,11,"CDF_CHAR","Integration Period Length in ms")
        cdflib.putAttrEntry(skeleton,catdesc,12,"CDF_CHAR","Pointing Mode of the Spacecraft")
        cdflib.putAttrEntry(skeleton,catdesc,13,"CDF_CHAR","Data Quality Flag")
        cdflib.putAttrEntry(skeleton,catdesc,14,"CDF_CHAR","Secondary Epoch in UTC")
        cdflib.putAttrEntry(skeleton,catdesc,15,"CDF_CHAR","Instrument Pointing Angle Relative to the Local Magnetic Field")
        
        %FIELDNAM
        cdflib.putAttrEntry(skeleton,fieldnam,0,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,fieldnam,1,"CDF_CHAR","Altitude (Geodetic)")
        cdflib.putAttrEntry(skeleton,fieldnam,2,"CDF_CHAR","Latitude (Geodetic)")
        cdflib.putAttrEntry(skeleton,fieldnam,3,"CDF_CHAR","Longitude (Geodetic)")
        cdflib.putAttrEntry(skeleton,fieldnam,4,"CDF_CHAR","L")
        cdflib.putAttrEntry(skeleton,fieldnam,5,"CDF_CHAR","MLT")
        cdflib.putAttrEntry(skeleton,fieldnam,6,"CDF_CHAR","MLAT")
        cdflib.putAttrEntry(skeleton,fieldnam,7,"CDF_CHAR","Channel Energies")
        cdflib.putAttrEntry(skeleton,fieldnam,8,"CDF_CHAR","Channel Energy Edges")
        cdflib.putAttrEntry(skeleton,fieldnam,9,"CDF_CHAR","Channel Count Rates")
        cdflib.putAttrEntry(skeleton,fieldnam,10,"CDF_CHAR","Channel Counts")
        cdflib.putAttrEntry(skeleton,fieldnam,11,"CDF_CHAR","Integration Period")
        cdflib.putAttrEntry(skeleton,fieldnam,12,"CDF_CHAR","Pointing Mode")
        cdflib.putAttrEntry(skeleton,fieldnam,13,"CDF_CHAR","Data Quality Flag")
        cdflib.putAttrEntry(skeleton,fieldnam,14,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,fieldnam,15,"CDF_CHAR","Pointing Angle")
        
        %VALIDMIN
        cdflib.putAttrEntry(skeleton,validmin,0,"CDF_EPOCH",timeminvalue)
        cdflib.putAttrEntry(skeleton,validmin,1,"CDF_REAL4",single(0))
        cdflib.putAttrEntry(skeleton,validmin,2,"CDF_REAL4",single(-90))  
        cdflib.putAttrEntry(skeleton,validmin,3,"CDF_REAL4",single(-180)) 
        cdflib.putAttrEntry(skeleton,validmin,4,"CDF_REAL4",single(1))    
        cdflib.putAttrEntry(skeleton,validmin,5,"CDF_REAL4",single(0))
        cdflib.putAttrEntry(skeleton,validmin,6,"CDF_REAL4",single(-90))
        cdflib.putAttrEntry(skeleton,validmin,7,"CDF_REAL4",single(0.3))
        cdflib.putAttrEntry(skeleton,validmin,8,"CDF_REAL4",single(0.24))
        cdflib.putAttrEntry(skeleton,validmin,9,"CDF_REAL8",double(0))
        cdflib.putAttrEntry(skeleton,validmin,10,"CDF_INT4",int32(0))
        cdflib.putAttrEntry(skeleton,validmin,11,"CDF_INT2",int16(100))
        cdflib.putAttrEntry(skeleton,validmin,12,"CDF_INT2",int16(0))
        cdflib.putAttrEntry(skeleton,validmin,13,"CDF_INT2",int16(0))
        cdflib.putAttrEntry(skeleton,validmin,14,"CDF_EPOCH",timeminvaluepoint)
        cdflib.putAttrEntry(skeleton,validmin,15,"CDF_REAL4",single(0))
        
        %VALIDMAX
        cdflib.putAttrEntry(skeleton,validmax,0,"CDF_EPOCH",timemaxvalue)
        cdflib.putAttrEntry(skeleton,validmax,1,"CDF_REAL4",single(550))
        cdflib.putAttrEntry(skeleton,validmax,2,"CDF_REAL4",single(90))
        cdflib.putAttrEntry(skeleton,validmax,3,"CDF_REAL4",single(180))
        cdflib.putAttrEntry(skeleton,validmax,4,"CDF_REAL4",single(30))
        cdflib.putAttrEntry(skeleton,validmax,5,"CDF_REAL4",single(24))
        cdflib.putAttrEntry(skeleton,validmax,6,"CDF_REAL4",single(90))
        cdflib.putAttrEntry(skeleton,validmax,7,"CDF_REAL4",single(5.83))
        cdflib.putAttrEntry(skeleton,validmax,8,"CDF_REAL4",single(6.62))
        cdflib.putAttrEntry(skeleton,validmax,9,"CDF_REAL8",double(1E9))
        cdflib.putAttrEntry(skeleton,validmax,10,"CDF_INT4",int32(1E9))
        cdflib.putAttrEntry(skeleton,validmax,11,"CDF_INT2",int16(5000))
        cdflib.putAttrEntry(skeleton,validmax,12,"CDF_INT2",int16(3))
        cdflib.putAttrEntry(skeleton,validmax,13,"CDF_INT2",int16(2))
        cdflib.putAttrEntry(skeleton,validmax,14,"CDF_EPOCH",timemaxvaluepoint)
        cdflib.putAttrEntry(skeleton,validmax,15,"CDF_REAL4",single(180))
        
        %SCALEMIN
        cdflib.putAttrEntry(skeleton,scalemin,4,"CDF_REAL4",single(1))
        cdflib.putAttrEntry(skeleton,scalemin,9,"CDF_REAL8",double(0))
        cdflib.putAttrEntry(skeleton,scalemin,10,"CDF_INT4",int32(0))
        
        %SCALEMAX
        cdflib.putAttrEntry(skeleton,scalemax,4,"CDF_REAL4",single(15))
        cdflib.putAttrEntry(skeleton,scalemax,9,"CDF_REAL8",double(1E7))
        cdflib.putAttrEntry(skeleton,scalemax,10,"CDF_INT4",int32(1E7))
        
        %SCALETYP
        cdflib.putAttrEntry(skeleton,scaletyp,7,"CDF_CHAR","log")
        cdflib.putAttrEntry(skeleton,scaletyp,8,"CDF_CHAR","log")
        cdflib.putAttrEntry(skeleton,scaletyp,9,"CDF_CHAR","log")
        cdflib.putAttrEntry(skeleton,scaletyp,10,"CDF_CHAR","log")

        %UNITS
        cdflib.putAttrEntry(skeleton,units,0,"CDF_CHAR","ms")
        cdflib.putAttrEntry(skeleton,units,1,"CDF_CHAR","km")
        cdflib.putAttrEntry(skeleton,units,2,"CDF_CHAR","degrees")
        cdflib.putAttrEntry(skeleton,units,3,"CDF_CHAR","degrees")
        cdflib.putAttrEntry(skeleton,units,4,"CDF_CHAR"," ")
        cdflib.putAttrEntry(skeleton,units,5,"CDF_CHAR","hrs")
        cdflib.putAttrEntry(skeleton,units,6,"CDF_CHAR","degrees")
        cdflib.putAttrEntry(skeleton,units,7,"CDF_CHAR","MeV")
        cdflib.putAttrEntry(skeleton,units,8,"CDF_CHAR","MeV")
        cdflib.putAttrEntry(skeleton,units,9,"CDF_CHAR","#/s")
        cdflib.putAttrEntry(skeleton,units,10,"CDF_CHAR"," ")
        cdflib.putAttrEntry(skeleton,units,11,"CDF_CHAR","ms")
        cdflib.putAttrEntry(skeleton,units,12,"CDF_CHAR"," ")
        cdflib.putAttrEntry(skeleton,units,13,"CDF_CHAR","0=Valid Data")
        cdflib.putAttrEntry(skeleton,units,14,"CDF_CHAR","ms")
        cdflib.putAttrEntry(skeleton,units,15,"CDF_CHAR","degrees")
        
        %LABLAXIS
        cdflib.putAttrEntry(skeleton,lablaxis,0,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,lablaxis,1,"CDF_CHAR","Altitude")
        cdflib.putAttrEntry(skeleton,lablaxis,2,"CDF_CHAR","Latitude")
        cdflib.putAttrEntry(skeleton,lablaxis,3,"CDF_CHAR","Longitude")
        cdflib.putAttrEntry(skeleton,lablaxis,4,"CDF_CHAR","L")
        cdflib.putAttrEntry(skeleton,lablaxis,5,"CDF_CHAR","MLT")
        cdflib.putAttrEntry(skeleton,lablaxis,6,"CDF_CHAR","MLAT")
        cdflib.putAttrEntry(skeleton,lablaxis,7,"CDF_CHAR","Energy")
        cdflib.putAttrEntry(skeleton,lablaxis,8,"CDF_CHAR","Energy Channel Edges")
        cdflib.putAttrEntry(skeleton,lablaxis,9,"CDF_CHAR","Count Rate")
        cdflib.putAttrEntry(skeleton,lablaxis,10,"CDF_CHAR","Counts")
        cdflib.putAttrEntry(skeleton,lablaxis,11,"CDF_CHAR","Integration Period")
        cdflib.putAttrEntry(skeleton,lablaxis,12,"CDF_CHAR","Pointing Mode")
        cdflib.putAttrEntry(skeleton,lablaxis,13,"CDF_CHAR","Data Quality Flag")
        cdflib.putAttrEntry(skeleton,lablaxis,14,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,lablaxis,15,"CDF_CHAR","Pointing Angle")

        %DISPLAY_TYPE
        cdflib.putAttrEntry(skeleton,display_type,1,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,2,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,3,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,4,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,5,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,6,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,9,"CDF_CHAR","spectrogram")
        cdflib.putAttrEntry(skeleton,display_type,10,"CDF_CHAR","spectrogram")
        cdflib.putAttrEntry(skeleton,display_type,11,"CDF_CHAR","time_series")
        cdflib.putAttrEntry(skeleton,display_type,15,"CDF_CHAR","time_series")
        
        %FILLVAL
        cdflib.putAttrEntry(skeleton,fillval,0,"CDF_EPOCH",time_fillval)
        cdflib.putAttrEntry(skeleton,fillval,1,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,2,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,3,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,4,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,5,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,6,"CDF_REAL4",single(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,9,"CDF_REAL8",double(-1.0E31))
        cdflib.putAttrEntry(skeleton,fillval,10,"CDF_INT4",int32(-2147483648))
        cdflib.putAttrEntry(skeleton,fillval,11,"CDF_INT2",int16(-32768))
        cdflib.putAttrEntry(skeleton,fillval,12,"CDF_INT2",int16(-32768))
        cdflib.putAttrEntry(skeleton,fillval,13,"CDF_INT2",int16(-32768))
        cdflib.putAttrEntry(skeleton,fillval,14,"CDF_EPOCH",time_fillval)
        cdflib.putAttrEntry(skeleton,fillval,15,"CDF_REAL4",single(-1.0E31))
        
        %FORMAT
        cdflib.putAttrEntry(skeleton,format,1,"CDF_CHAR","F8.4")
        cdflib.putAttrEntry(skeleton,format,2,"CDF_CHAR","F8.4")
        cdflib.putAttrEntry(skeleton,format,3,"CDF_CHAR","F9.4")
        cdflib.putAttrEntry(skeleton,format,4,"CDF_CHAR","F7.4")
        cdflib.putAttrEntry(skeleton,format,5,"CDF_CHAR","F7.4")
        cdflib.putAttrEntry(skeleton,format,6,"CDF_CHAR","F8.4")
        cdflib.putAttrEntry(skeleton,format,7,"CDF_CHAR","F4.2")
        cdflib.putAttrEntry(skeleton,format,8,"CDF_CHAR","F4.2")
        cdflib.putAttrEntry(skeleton,format,9,"CDF_CHAR","E10.4")
        cdflib.putAttrEntry(skeleton,format,10,"CDF_CHAR","E10.4")
        cdflib.putAttrEntry(skeleton,format,11,"CDF_CHAR","I4")
        cdflib.putAttrEntry(skeleton,format,12,"CDF_CHAR","I1")
        cdflib.putAttrEntry(skeleton,format,13,"CDF_CHAR","I1")
        cdflib.putAttrEntry(skeleton,format,15,"CDF_CHAR","F8.4")
        
        %VAR_TYPE
        cdflib.putAttrEntry(skeleton,var_type,0,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,1,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,2,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,3,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,4,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,5,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,6,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,7,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,8,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,9,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,10,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,11,"CDF_CHAR","data")
        cdflib.putAttrEntry(skeleton,var_type,12,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,13,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,14,"CDF_CHAR","support_data")
        cdflib.putAttrEntry(skeleton,var_type,15,"CDF_CHAR","data")
        
        %VAR_NOTES
        cdflib.putAttrEntry(skeleton,var_notes,0,"CDF_CHAR","This time variable corresponds to the location, counts and integration period, spacecraft pointing mode, and flag variables.")
        cdflib.putAttrEntry(skeleton,var_notes,1,"CDF_CHAR","Geodetic altitude was computed from TLEs using SPG4 and WGS84 from the Skyfield Python package. TLEs can have an initial error of up to approximately 1 km and the error can increase by 1-2 km per day depending on factors such as drag and geomagnetic activity. For more details, please see the CIRBE Data User's Guide.")
        cdflib.putAttrEntry(skeleton,var_notes,2,"CDF_CHAR","Geodetic latitude was computed from TLEs using SPG4 and WGS84 from the Skyfield Python package. TLEs can have an initial error of up to approximately 1 km and the error can increase by 1-2 km per day depending on factors such as drag and geomagnetic activity. For more details, please see the CIRBE Data User's Guide.")
        cdflib.putAttrEntry(skeleton,var_notes,3,"CDF_CHAR","Geodetic longitude was computed from TLEs using SPG4 and WGS84 from the Skyfield Python package. TLEs can have an initial error of up to approximately 1 km and the error can increase by 1-2 km per day depending on factors such as drag and geomagnetic activity. For more details, please see the CIRBE Data User's Guide.")
        cdflib.putAttrEntry(skeleton,var_notes,4,"CDF_CHAR","Calculated via IRBEM (4.4.0) using the IGRF model for Earth's magnetic field and assuming no external magnetic field, using position values from the position variables.")
        cdflib.putAttrEntry(skeleton,var_notes,5,"CDF_CHAR","Calculated via IRBEM (4.4.0) using the IGRF model for Earth's magnetic field and assuming no external magnetic field, using position values from the position variables.")
        cdflib.putAttrEntry(skeleton,var_notes,6,"CDF_CHAR","Calculated via IRBEM (4.4.0) using the IGRF model for Earth's magnetic field and assuming no external magnetic field, using position values from the position variables.")
        cdflib.putAttrEntry(skeleton,var_notes,7,"CDF_CHAR","Calculated via bowtie method, outlined in the instrument calibration paper in the acknowledgments. The characteristic energy is the energy which best describes the behavior of the energy channel.")
        cdflib.putAttrEntry(skeleton,var_notes,8,"CDF_CHAR","Calculated via bowtie method, outlined in the instrument calibration paper in the acknowledgments. The characteristic energy is the energy which best describes the behavior of the energy channel.")
        cdflib.putAttrEntry(skeleton,var_notes,9,"CDF_CHAR","This variable contains the count rates in each of the energy channels of particles that are categorized as range electrons (using logic outlined in the instrument description paper). The instrument has a field of view of approximately 51 degrees and the pointing angle is usually perpendicular to the local magnetic field, though it will sometimes deviate from 90 degrees as can be seen in the Pointing_Angle variable. This must be taken into account when analyzing the data. The vast majority of radiation belt particles are measured near the South Atlantic Anomaly region.")
        cdflib.putAttrEntry(skeleton,var_notes,10,"CDF_CHAR","This variable contains the counts in each of the energy channels over the integration period of particles that are categorized as range electrons (using logic outlined in the instrument description paper). The instrument has a field of view of approximately 51 degrees and the pointing angle is usually perpendicular to the local magnetic field, though it will sometimes deviate from 90 degrees as can be seen in the Pointing_Angle variable. This must be taken into account when analyzing the data. The vast majority of radiation belt particles are measured near the South Atlantic Anomaly region.")
        cdflib.putAttrEntry(skeleton,var_notes,11,"CDF_CHAR","Near the South Atlantic Anomaly region (SAA) there is a one second integration period. Outside of the SAA there is a five second integration period.")
        cdflib.putAttrEntry(skeleton,var_notes,12,"CDF_CHAR","0 is nominal science mode where the spacecraft is pointed perpendicular to the local magnetic field at all times except for periods of downlink and uplink, 1 is sun-point static mode where the primary pointing direction is towards the sun and angle relative to local magnetic field is neglected, 2 is sun-point star-tracker mode where the primary pointing direction is towards the sun and the secondary pointing direction is perpendicular to the local magnetic field, 3 is low-drag mode.")
        cdflib.putAttrEntry(skeleton,var_notes,13,"CDF_CHAR","0 means the data is valid. 1 means the timestamp is inaccurate by a magnitude of up to 10 seconds, but the counts and counts rate data is accurate. 2 means that the counts data is flawed, and the data should be used with extreme caution or omitted entirely.")
        cdflib.putAttrEntry(skeleton,var_notes,14,"CDF_CHAR","This time variable corresponds to the Pointing_Angle variable only. These data were taken at an irregular time cadence different from the rest of the variables.")
        cdflib.putAttrEntry(skeleton,var_notes,15,"CDF_CHAR","The pointing angle is the angle between the instrument's pointing direction and the local magnetic field. Data points are usually only recorded when there is deviation from 90 degrees, so during gaps between recorded pointing angles the pointing angle can be assumed to be 90 degrees. If there is a data point with a missing value, use caution as the pointing angle may not be at 90 degrees.")
        
        %DEPEND_0
        cdflib.putAttrEntry(skeleton,depend_0,1,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,2,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,3,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,4,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,5,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,6,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,9,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,10,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,11,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,12,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,13,"CDF_CHAR","Epoch")
        cdflib.putAttrEntry(skeleton,depend_0,15,"CDF_CHAR","Epoch_2")
        
        %DEPEND_1
        cdflib.putAttrEntry(skeleton,depend_1,9,"CDF_CHAR","Channel_Energies")
        cdflib.putAttrEntry(skeleton,depend_1,10,"CDF_CHAR","Channel_Energies")
        
        %TIME_SCALE
        cdflib.putAttrEntry(skeleton,time_scale,0,"CDF_CHAR","UTC")
        cdflib.putAttrEntry(skeleton,time_scale,14,"CDF_CHAR","UTC")

        %BIN_LOCATION
        cdflib.putAttrEntry(skeleton,bin_location,0,"CDF_REAL4",single(1.0))

        %RESOLUTION
        cdflib.putAttrEntry(skeleton,resolution,0,"CDF_CHAR","1s")

        %MONOTON
        cdflib.putAttrEntry(skeleton,monoton,0,"CDF_CHAR","INCREASE")
        cdflib.putAttrEntry(skeleton,monoton,14,"CDF_CHAR","INCREASE")
        
        % GETTING VARIABLE VALUES

        mainepoch = double(ncread(file_path_1,"Epoch"));  %Epoch values from L2 file, these are in UTC, could be taken from released L1
        mainepoch = datenum('2000/01/01 00:00:00')+(mainepoch/3600/24); %convert these to datenum
        mainepoch = spdfdatenumtoepoch(mainepoch); %Use SPDF MATLAB patch to convert from datenum to CDF_EPOCH format
        mainepoch(isnan(mainepoch))=double(-1.0E31);
        
        altitude = single(ncread(file_path_1,"Alt")); %position and magnetic variables taken from L2, but could be taken from released L1
        altitude(isnan(altitude))=single(-1.0E31);
        
        latitude = single(ncread(file_path_1,"Lat"));
        latitude(isnan(latitude))=single(-1.0E31);
        
        longitude = single(ncread(file_path_1,"Lon"));
        longitude(isnan(longitude))=single(-1.0E31);
        
        lvals = single(ncread(file_path_1,"L"));
        lvals(isnan(lvals))=single(-1.0E31);
        
        maglocaltime = single(ncread(file_path_1,"MLT"));
        maglocaltime(isnan(maglocaltime))=single(-1.0E31);

        maglatitude = single(ncread(file_path_1,"MLAT"));
        maglatitude(isnan(maglatitude))=single(-1.0E31);
        
        rngenergy = single(ncread(file_path_1,"RNG_energies"));
        
        rngcounts = int32(ncread(file_path_4,"Ebins_RNG"))';
        rngcounts(isnan(rngcounts))=int32(-1.0E31);
        
        intperiod = int16(ncread(file_path_1,"IntePrd"));
        intperiod(isnan(intperiod))=int16(-32768);

        rngcountrates = double(double(rngcounts*1000)./double(intperiod));
        
        spacepoint = int16(ncread(file_path_1,"spacecraft_pointing_mode"));
        spacepoint(isnan(spacepoint))=int16(-32768);
        
        invalflag = int16(ncread(file_path_1,"invalid_data_flag")); %must be taken from L2
        invalflag(isnan(invalflag))=int16(-32768);
        
        secondepoch = double(ncread(file_path_1,"OffAng_timestamp")); %UTC
        secondepoch = datenum('2000/01/01 00:00:00')+(secondepoch/3600/24); %convert to datenum
        secondepoch = spdfdatenumtoepoch(secondepoch); %use spdfdatenumtoepoch to convert to CDF_EPOCH
        secondepoch(isnan(secondepoch))=double(-1.0E31);
        
        angle = single(ncread(file_path_1,"OffAng"));
        angle(isnan(angle))=single(-1.0E31);
        
        % WRITING VALUES TO VARIABLES

        for k = linspace(0,length(mainepoch)-1,length(mainepoch)) 
            cdflib.putVarRecordData(skeleton,epoch,k,mainepoch(k+1))
            cdflib.putVarRecordData(skeleton,alt,k,altitude(k+1))
            cdflib.putVarRecordData(skeleton,lat,k,latitude(k+1))
            cdflib.putVarRecordData(skeleton,lon,k,longitude(k+1))
            cdflib.putVarRecordData(skeleton,mcL,k,lvals(k+1))
            cdflib.putVarRecordData(skeleton,mlt,k,maglocaltime(k+1))
            cdflib.putVarRecordData(skeleton,mlat,k,maglatitude(k+1))
            cdflib.putVarRecordData(skeleton,rng_countrate_e,k,rngcountrates(k+1,:))
            cdflib.putVarRecordData(skeleton,rng_counts_e,k,rngcounts(k+1,:))
            cdflib.putVarRecordData(skeleton,intprd,k,intperiod(k+1))
            cdflib.putVarRecordData(skeleton,point,k,spacepoint(k+1))
            cdflib.putVarRecordData(skeleton,flag,k,invalflag(k+1))
        end

        for j = linspace(0,length(angle)-1,length(angle))
            cdflib.putVarRecordData(skeleton,offang_time,j,secondepoch(j+1))
            cdflib.putVarRecordData(skeleton,offang,j,angle(j+1))
        end

        cdflib.putVarRecordData(skeleton,rng_energy_e,0,rngenergy)
        cdflib.putVarRecordData(skeleton,rng_energy_edges_e,0,energy_edges)

        cdflib.close(skeleton)

    end

end


%%

[cddata,cdinfo] = cdfread("cirbe_reptile-2_l1b_rng_elecs_20230419_v01_01.cdf");

