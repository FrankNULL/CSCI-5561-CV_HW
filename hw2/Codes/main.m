clc 
clear all
close all


image_cell=cell(4,1);
template=rgb2gray(imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\cv_frames_me\TEMPLATE.bmp'));
image_cell{1}=rgb2gray(imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\cv_frames_me\IMAGE1.jpg'));
image_cell{2}=rgb2gray(imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\cv_frames_me\IMAGE2.jpg'));
image_cell{3}=rgb2gray(imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\cv_frames_me\IMAGE3.jpg'));
image_cell{4}=rgb2gray(imread('E:\STUDY\UMN\COURSEWORK\COMPUTER VISION\hw2\cv_frames_me\IMAGE4.jpg'));

[A_cell]=TrackMultiFrames(template,image_cell);


