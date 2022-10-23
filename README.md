# SelectiveSearchForWSOD

You can use this project to generate the proposals (pkl) file for your own dataset.

It works well in PCL and WETECTRON.

# Overview

0、prepare your own dataset, this project only need pictures and the split file "train.txt/test.txt/val.txt" used in **VOC** format.

1、Use this [Project](https://github.com/WalterMa/SelectiveSearch-RCNN) to generate proposals by **Matlab** 

note: I made some modifications to it.

2、merge the regions into a pkl file by a simple **python** program

# **Get Started**

1、Download this [Project](https://github.com/WalterMa/SelectiveSearch-RCNN) And use its demo to make sure it works

2、Replace it's __start.m__ with [start.m](https://github.com/ghZHM/SelectiveSearchForWSOD/blob/main/start.m), I make some modifications to do following things

```
1、In pkl file, proposals list of an image needs a index to point out with picture it belongs to.
2、The boxes are in [ymin, xmin, ymax, xmax] format, I transfer them into [xmin,ymin,xmax,ymax]
```

3、make a new folder named **image** in ***SelectiveSearchCodeIJCV*** and put the images of your dataset into it

4、put the split file (ie. test.txt;val.txt etc.) into ***SelectiveSearchCodeIJCV***

Now, Your project should be like
```
--SelectiveSearch-RCNN
  --SelectiveSearchCodeIJCV
    --image
      the images of your dataset 
    train.txt(if needed)
    test.txt(if needed)
    val.txt(if needed)
    trainval.txt(if needed)
    ...and others
 ```
5、change [this line](https://github.com/ghZHM/SelectiveSearchForWSOD/blob/main/start.m#L5) to specify the subset to be generate and run **start.m**.

**Note: remember to save the out_box.mat & out_index.mat to another place everytime you run and make sure you know which split they below to. Otherwise they will be overwrite**

```
for example:
idx_file = './SelectiveSearchCodeIJCV/train.txt'; for training set
idx_file = './SelectiveSearchCodeIJCV/test.txt'; for test set
idx_file = './SelectiveSearchCodeIJCV/val.txt'; for validation set
```

6、merge two .mat into a pkl file with [mergeRegions.py](https://github.com/ghZHM/SelectiveSearchForWSOD/blob/main/mergeRegions.py).

out_box.mat and out_index.mat need to be in the same folder with mergeRegions.py

**Note: Now you have the pkl for one subset in the whole dataset, you need to repeat from step 5 for every subset you need**



