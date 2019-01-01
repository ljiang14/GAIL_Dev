% longtests_cubMC_g: long tests for cubMC_g

warning('off', 'MATLAB:meanMC_g:maxreached')

%% doctests
% cubMC_g
format short
doctest dt_cubMC_g

%% unit tests
% cubMC_g
run_handle_ut('ut_cubMC_g')

%% other tests
% MCQMC paper
run_handle('MCQMC2012Figs')
run_handle('FoolAutomaticAlgorithms')
run_handle('RunTestcubMConGeoAsianCall')
run_handle('RunTestcubMConGaussian')
run_handle('RunTestcubMConGaussiand1')

try
    DisplayTestResults_BlacknColor({'ex1', 'ex2', 'ex3'},'black')
catch err
    disp('Error: DisplayTestResults_BlacknColor is wrongly coded. We skip it.')
    disp(['File: ', err.stack(1).name, '; Line number ', int2str(err.stack(1).line),  '; Error: ',  err.message ])
end

warning('on', 'MATLAB:meanMC_g:maxreached')



