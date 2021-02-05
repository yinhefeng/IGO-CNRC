# IGO-CNRC
competitive non-negative representation based classification with image gradient orientations (IGO-CNRC)<br>
<br>
The schematic diagram of our proposed IGO-CNRC is shown as follows,<br>
<br>
![image](https://github.com/yinhefeng/IGO-CNRC/blob/master/IGO_CNRC.jpg)
<br>
<br>
This demo is for face recognition with sunglasses on the AR dataset. We use seven neutral images plus one image with sunglasses (randomly chosen) from Session 1 for training (eight training images per class), and the remaining neutral images (all from Session 2) and the rest of the images with sunglasses (two taken from Session 1 and three from Session 2) for testing (twelve test images per class).
<br>
<br>
Run demo_AR_sunglasses.m with MATLAB, you can obtain the following result:
<br>
Accuracy of IGO_CNRC (1st) is 94.8%
<br>
Accuracy of IGO_CNRC (2nd) is 94.3%
<br>
Accuracy of IGO_CNRC (3rd) is 91.6%
<br>
Accuracy of IGO_CNRC is 97.4%
