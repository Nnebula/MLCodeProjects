
load('easy_ham_features.mat');
non_spam=V;
load('spam_features.mat');
spam=V;


%concatenate and label the training set:
train = [non_spam ; spam ];
label = [ones(size(non_spam,1),1); -ones(size(spam,1),1)]; %spam -1 & non_spam +1

%shuffling the data:
rp = randperm(size(label,1));

for i=1:size(label,1)
    train_data(i,:) = train(rp(i),:);
    train_label(i,:) = label(rp(i),:);
end


model=svmtrain(train_label, train_data, '-s 0 -t 1 -d 3 -c 100');

load('test_data.mat');
test_data = V;

%make test label
test_label = round (rand(size(test_data,1),1));
test_label(~test_label)=-1;

v = svmpredict(test_label, test_data, model);

name = 'nra18';
save('spamtest.mat','v','name');
