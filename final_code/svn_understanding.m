clc
close all
clear all

% Load the data and select features for classification
        load fisheriris
        
        data = [meas(:,1), meas(:,2)];
        % Extract the Setosa class
        groups = ismember(species,'setosa');
        % Randomly select training and test sets
        [train, test] = crossvalind('holdOut',groups);
        cp = classperf(groups);
        
        % Use a linear support vector machine classifier
        svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);
        
        % Add a title to the plot
        title(sprintf('Kernel Function: %s',...
              func2str(svmStruct.KernelFunction)),...
              'interpreter','none');
        
        % Classify the test set using svmclassify
        classes = svmclassify(svmStruct,data(test,:),'showplot',true);

        % See how well the classifier performed
        classperf(cp,classes,test);
        cp.CorrectRate