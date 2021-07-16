function [ output_data ] = mikesmooth( input_data , span )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
output_data=zeros(size(input_data));
weight = row2col(hann(span),1);
weight = [weight(1:floor(length(weight)/2));zeros(length(weight)-floor(length(weight)/2),1)];
weight = weight/sum(weight);
for n=1:size(input_data,2)
% output_data(:,n)=conv(input_data(:,n),ones(span,1)/span,'same');
% output_data(:,n) = filtfilt(ones(span/2,1)/(span/2),1,input_data);
output_data(:,n) = filtfilt(weight,1,input_data);
endspan=span;
% if (mod(endspan,2)==0)
%     endspan=endspan+1;
% end
% for m=0:(endspan-3)/2;
%     output_data(m+1,n)=mean(input_data(1:m*2+1,n));
%     output_data(end-m,n)=mean(input_data(end-m*2:end,n));
% end

end


end

