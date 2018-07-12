
I = imread('10Fingerprint.tif');
bw=imbinarize(I); 
subplot(121); imshow(I);
bw2 = ~bw;
J = imclose( bw2, strel('disk',1,8));
K = imopen( J, strel('disk',1,8));
K = ~K;
L = bwareaopen(K, 6);
L =~L;
N = bwmorph(L,'thin',1);
subplot(122); imshow(N);


