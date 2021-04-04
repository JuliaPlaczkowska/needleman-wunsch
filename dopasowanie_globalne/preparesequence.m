function [outSeq] = preparesequence(inSeq)
%PREPARESEQUENCE convert given reference to the proper sequence.
%
%If the given input argument is an accesion number to the NCBI gen bank 
%then the function returns the proper sequence.
%If its a reference to the FASTA file, then the sequence is being read from
%the file. 
%If the proper sequence is alredy given then the function gives it back

seqPattern = asManyOfPattern(characterListPattern('ACDEFGHIKLMNPQRSTVWY'));

if any(regexp(inSeq ,'[0-9]'))%if seq contains any numeric characters
    try
        outSeq = getgenbank(inSeq,'Sequence',true);
    catch
        warning('Wrong accession number.  Assigning a value of A.');
        outSeq = 'A';
    end
elseif matches(inSeq, seqPattern)%if seq matches nucleotide or amino acid patern
    outSeq = inSeq;
else %otherwise, the function tries to read FASTA file of a given name
    try
        %[header, outSeq] = fastaread(inSeq, 'Blockread', BlockreadValue,'ignoregaps',true);
        [header, outSeq] = fastaread(inSeq);
    catch
        warning('FASTA file not found. Assigning a value of A.');
         outSeq = 'A';
    end
end

if length(outSeq)>2000
    outSeq = outSeq(1:2000);
end

end

