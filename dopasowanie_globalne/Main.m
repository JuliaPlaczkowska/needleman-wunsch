%    from FASTA files
crocus = preparesequence('crocus_chloroplast.txt'); %KU230351
pillansia = preparesequence('pillansia_chloroplast.txt'); %JX903634
dab = preparesequence('dab_chloroplast.txt'); %JF506311

%%
%     from genbank
cat = preparesequence('NM_001009277');
tiger = preparesequence('AF354938');
human = preparesequence('NM_000894');
seriola = preparesequence('LC019039');

%%

seq1 = crocus(1:50);
seq2 = dab(1:50);

%%
seq1 = 'ACA';
seq2 = 'AAC';
%%

[mat, paths, temp] = algorytmNW(seq1, seq2, 1, -1, -2);


figure;
imagesc(mat); 
colorbar;
hold on
% for i = 1:size(temp, 3)
%     spy(sparse(temp(:,:,i)),24);
% end
spy(sparse(temp),10);
ylabel('Sequence 1', 'FontSize', 12);
xlabel('Sequence 2', 'FontSize', 12);
set(gca,'xtick',[1:size(seq2, 2)+1],'xticklabel',{'-',seq2'},'XAxisLocation','top');
set(gca,'ytick',[1:size(seq1, 2)+1],'yticklabel',{'-',seq1'});

%%
writeToFile('zapis.txt', seq1, seq2, 'distance', 1, -1, -2, temp);