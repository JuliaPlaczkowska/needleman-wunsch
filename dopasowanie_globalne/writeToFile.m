function writeToFile(filename, seq1, seq2, mode, match, mismatch, gap, mat)

length = sum(sum(mat>0));

str1= strings(1, length);
str2= strings(1, length);
str3= strings(1, length);



n = 1;
score = 0;
gaps = 0;
i = 1;
j = 1;


while 1 
        
        if i < size(mat, 1) && j < size(mat, 2) && mat(i+1,j+1) == 1
            str1(n)=seq1(i);
            str2(n)=seq2(j);
            n = n + 1;
            i = i+1;
            j = j+1;
        elseif (j < size(mat, 2) && mat(i,j+1) == 1)
            str1(n)='-';
            str2(n)=seq2(j);
            n = n + 1;
            j = j+1;
            gaps = gaps +1;
        elseif (i < size(mat, 1) && mat(i+1,j) == 1)
            str1(n)=seq1(i);
            str2(n)='-';
            n = n + 1;
            i = i+1;
            gaps = gaps+1;
        end
        
        if str2(n-1) == str1(n-1)
            str3(n-1)='|';
            score = score +1;
        else
            str3(n-1)=' ';
        end
        
        if  i  == size(seq1,2)+1 && j == size(seq2, 2) +1
            break;
        end
        
end


length = length - 1;


% text = ['# 1: ', seq1,'\n# 2: ', seq2, '\n# Mode: ',mode,'\n# Match: ', num2str(match),'\n# Mismatch: ', num2str(mismatch),'\n# Gap: ', num2str(gap),'\n# Score: ', num2str(mat(end, end)), '\n# Length: ', num2str(length), '\n# Identity: ', '?', '\n# Gaps', '?'];
% text2 = ['\n', str1, '\n', str3, '\n', str2];
fid = fopen(filename,'wt');
format = '%s \n';
fprintf(fid, format, ['# 1: ', seq1], ['# 2: ', seq2] , ['# Mode: ',mode],['# Match: ', num2str(match)],['# Mismatch: ', num2str(mismatch)],['# Gap: ', num2str(gap)],['# Score: ', num2str(mat(end, end))], ['# Length: ', num2str(length)], ['# Identity: ', num2str(score),'/', num2str(length), ' (', num2str(round(score/length*100, 0)),'%)'], ['# Gaps: ', num2str(gaps),'/', num2str(length), ' (',num2str(round(gaps/length*100,0)),'%)'], char(str1),char(str3),char(str2));
fclose(fid);
end

