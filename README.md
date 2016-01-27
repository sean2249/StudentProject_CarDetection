#NTU Course Pattern Analsis and Classification 
##--Final project: Car detection 

##Description:
Given a image, detect where the car is and illurstrate its bounding box

##Code Enviroment:
Matlab 2015a

##Method:
###Hypothesis Generate_Bounding box 
--use Matalb "trainCascasdeObject"
###Hypothesis Verification_Verify bounding box 
--HOG feature extract and use svm for training model 


##File:
###0. final_presentation.pptx
Our team presentation. You may check this file first to get overall algorithm acknowledge and the method we use.

###1. autorun.m:
It's the main script of project, the other file are scripts too. You need this to run other script, 'cause I set some conditional variable in "autorun.m"

###2. hogExtract.m:
Extract the HOG feature of training data and write into .mat for SVM training.

###3. trainSVM_MIX.m:
Use the hog feature of previous file to train SVM model. The tool is based on libSVM.

###4. trainDetector.m:
Use function of trainCascadeObject to train the bounding box model. 

###5. detectingAndGenerateBbox.m:
It's the score script of project. But I don't upload the test file, you may check what I do the part of HG and HV section. In the end, I write the bounding box into file.


##Summary
This method may have prescision 70%, but it may depend on the data you train. 

I think another method of faster-RCNN is better to use and have a higher prediction. 
It uses neural network to train the model and needs lots of time to train the model.
But good!!!

Hope you guys have fun in coding!
