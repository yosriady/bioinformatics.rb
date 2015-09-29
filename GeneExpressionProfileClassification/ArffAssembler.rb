require 'csv'
require 'pry'

input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-normalized-with-testset'
annotations_filepath = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset10-02-01annotation.csv'
output_filepath = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/training.arff'

def load_annotations(filepath)
  c = {}
  CSV.foreach(filepath, headers: true) do |row|
    c[row["Chip"]] = row["Coding"]
  end
  c
end

classifications = load_annotations(annotations_filepath)

def construct_vector(dir, filename, classifications)
  filepath = "#{dir}/#{filename}"
  vector = []
  File.open(filepath, 'r').each do |line|
    avgdiff = line.split("\t")[4] || "?"
    vector << avgdiff
  end
  sample = filename.delete('.TXT')

  vector << classifications[sample]
  vector
end

def get_all_genes(dir)
  samples = Dir.entries(dir)
  filename = samples.select {|filename| filename.end_with? '.TXT'}[0]
  filepath = "#{dir}/#{filename}"
  genes = []
  File.open(filepath, 'r').each do |line|
    gene = line.split("\t")[0]
    genes << gene
  end
  genes
end

all_genes = get_all_genes(input_dir)

File.open(output_filepath, 'w') do |file|
  file.write("@relation 'CS2220 Gene Expression Profiles'\n\n")
  all_genes.each do |gene|
    file.write("@attribute #{gene} numeric \n")
  end
  file.write("@attribute Class {#{classifications.values.uniq.join(',')}}\n\n")
  file.write("@data \n\n")

  Dir.foreach(input_dir) do |filename|
    next unless filename.end_with? '.TXT'
    vector = construct_vector(input_dir, filename, classifications)
    file.write(vector.join(',') + "\n")
  end
end

p 'Done!'