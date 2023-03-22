clear all; close all; clc;

% setup path
addpath(genpath(pwd));
projectName = 'Loc2023';
bidsDir = '~/Desktop/MRI/Loc2023';
githubDir = '~/Documents/GitHub';
fsDir = '/Applications/freesurfer/7.2.0';
addpath(genpath(fullfile(githubDir, 'wpToolbox')));
setup_user(projectName,bidsDir,githubDir,fsDir);

% define params
sub = 'sub-0201';
ses = 'ses-01';
space = 'fsnative';
run = 1:8;
rois = {'mt','mstL','mstR','fst'};

% load data
datafiles = load_data(bidsDir,'loc',space,'.mgh',sub,ses,run) ;
 
% make design matrix
tmp{1} = repmat(repelem([1 0;0 1],10,1),15,1);
matrices = repmat(tmp(1), 1, 8);

% run glm
for iRoi = 1:numel(rois)
    results.(char(rois{iRoi})) = GLMestimatemodel(matrices([iRoi iRoi+4]),datafiles([iRoi iRoi+4]),1,1,'assume',[],0);
end

% visualize R2 for each roi
close all;
visualize_R2(results,sub,rois);
