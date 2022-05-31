
% Add the Selective Search IJCV code path
addpath(genpath('./SelectiveSearchCodeIJCV'));
% Modify these two variables to fit your dataset
idx_file = './SelectiveSearchCodeIJCV/train.txt';
format_string = './SelectiveSearchCodeIJCV/image/%s.jpg';


% Read image set index file
fileID = fopen(idx_file);
img_list = textscan(fileID, '%s');
fclose(fileID);
img_list = img_list{:};

% Generating boxes
num_img = length(img_list);
boxes=cell(1,num_img);
indexes=cell(1,num_img); % index of images
fast_mode = true;
fprintf('Generating boxes...\n');  
parfor_progress(num_img);
parfor i = 1:num_img
    img_file = sprintf(format_string, string(img_list(i)));
    img = imread(img_file);
    ss_boxes = selective_search_boxes(img, fast_mode);
    for n = 1:length(ss_boxes)
        box = ss_boxes(n, :);
        temp=box(2);
        box(2)=box(1);
        box(1)=temp;
        temp=box(3);
        box(3)=box(4);
        box(4)=temp;
        ss_boxes(n, :)=box;
    end
    boxes{1, i} = ss_boxes; 
    str =img_file(33:38);% print it first, for example, if the name of image is 001234.jpg, just keep 001234. It works properly when the images are put in the folder "image"
    num=str2num(str);
    indexes{1,i}=num;
    parfor_progress;
end
parfor_progress(0);

% Save
fprintf('Save generated boxes&indexes to output.\n'); 
save('out_box.mat', 'boxes')
save('out_index.mat', 'indexes')