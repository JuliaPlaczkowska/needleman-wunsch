function [mat, paths, temp] = algorytmNW(seq1, seq2, match, mismatch, penalty)
%
%ALGORYTMNW funkcja służąca do ilościowego globalnego porównania par sekwencji 
%kodujących białka lub DNA za pomocą algorytmu Needlemana-Wunscha.
%
%Przyjmuje następujące argumeny:
%
% seq1 i seq2 - sekwencje nukleotydów albo aminokwasów lub referencja do 
% tej sekwencji w formie nazwy pliku FASTA lubnumeru referencyjnego; 
% match - liczba punktów za dopasowanie poprzekątnej; 
% mismatch - liczba punktów za niedopasowanie po przekątnej;
% penalty - liczba punktów za ruch w pionie lub poziomie. 
%
%Argumenty wejściowe: 
%
% mat - macierz z wynikowymi punktami;
% paths - macierz trójwymiarowa informująca o kierunkach wypełniania macierzy;
% temp - macierz z jedną wybraną ścieżką.

 seq1 =  ['-', preparesequence(seq1)];
 seq2 =  ['.',preparesequence(seq2)];

 
m=length(seq1);
n=length(seq2);

mat = zeros(m, n);
paths = zeros(m, n, 3); % 1 -vertical, 2 -horizontal, 3 -diagonal

mat(:, 1) = 0:penalty:penalty*(m-1);
paths(2:end, 1, 1) = 1; % vertical path
mat(1, :) = (0:penalty:penalty*(n-1))';
paths(1, 2:end, 2) = 1; % horizontal path



for i = 2:m
    for j = 2:n
        
        v = mat(i-1, j) + penalty;
        h = mat(i, j-1) + penalty;
        
        if(seq1(i)==seq2(j))
            d = mat(i-1, j-1) + match;
        else
            d = mat(i-1, j-1) + mismatch;
        end
        
        mat(i, j) = max([v, h, d]);
        paths(i, j, :) = [mat(i, j)==v, mat(i, j)==h, mat(i, j)==d];
        
    end
end

temp = getPath(paths);

end

