sequence1 = "CCGTCAGAGCGCCGACACTCTTCTCTGTGCGAGCGAGCCGCCGACCGCCAAGCAAAATGGGAAATGAGGCAAGTTATCCTTTGGAAATGTGCTCACACTTTGATGCAGATGAAATTAAAAGGCTAGGAAAGAGATTTAAGAAGCTCGATTTGGACAATTCTGGTTCTTTGAGTGTGGAAGAGTTCATGTCTCTACCTGAGTTACAA"
annotations1 = "........................................................iEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"

sequence2 = 'GAGAGTGGTTGCACTTTAGGCTCCTTCGACCCCTTCTGCGTGTCGGGGCCCCGGTGCCGGCGACTCCTCCTGGGGACCTTCGGACCCTCGGACCCCACCACCATGGAAGGGGGCTCCGAGCTGCTCTTCTACGTGAACGGCCGCAAGGTGACAGAAAAAAATGTTGATCCTGAAACAATGCTATTGCCATATCTGAGGAAAAAGCTCCGACTCACAGGAACTAAATATGGCTGTGGAGGGGGAGGCTGTGGT'
annotations2 = '......................................................................................................iEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'

sequence3 = 'GAGAGTGGTTGCACTTTAGGCTCCTTCGACCCCTTCTGCGTGTCGGGGCCCCGGTGCCGGCGACTCCTCCTGGGGACCTTCGGACCCTCGGACCCCACCACCGAAGGGGGCTCCGAGCTGCTCTTCTACGTGAACGGCCGCAAGGTGACAGAAGATCCTGAAACACTATTGCCATATCTGAGGAAAAAGCTCCGACTCACAGGAACTAACTGTGGAGGGGGAGGCTGTGGTATG'
annotations3 = '.......................................................................................................................................................................................................................................iEE'

MIDPOINT = 99
LENGTH = 201

# generate pos.fasta
def generate_pos(sequence, annotations)
    tis_index = annotations.index('i')
    atg_indexes = index_pattern('ATG', sequence)
    center(atg_indexes[0], sequence)
end

# generate neg.fasta
def generate_neg(sequence, annotations)
  tis_index = annotations.index('i')
  atg_indexes = index_pattern('ATG', sequence)
  atg_indexes.delete(tis_index)
  neg_examples = []
  atg_indexes.each do |index|
    example = center(index, sequence)
    neg_examples << example
  end
  neg_examples
end

# Helper methods
def index_pattern(pattern, sequence)
  indexes = []
  sequence.scan(pattern) do |c|
    indexes << $~.offset(0)[0]
  end
  indexes
end

def center(index, sequence)
  if index < MIDPOINT
    sequence.slice(0, LENGTH - (MIDPOINT - index)).rjust(LENGTH, 'N')
  else
    sequence.slice(index - MIDPOINT, LENGTH).ljust(LENGTH, 'N')
  end
end

result = generate_neg(sequence1, annotations1)
p result
p result.size