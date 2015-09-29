require 'csv'
require 'pry'

train_input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/testing/testset-txt-normalized-with-trainset'
test_input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-fully-cleaned'
test_output_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-normalized-with-testset'

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

training_genes = get_all_genes(train_input_dir)

# Filter out genes not in training dataset
def filter(input, output, training_genes)
  line_num = 1
  File.open(output, 'w') do |output| # 'w' for a new file, 'a' append to existing
    File.open(input, 'r').each do |line|
      gene = line.split("\t")[0]
      is_training_gene = training_genes.include? gene
      if is_training_gene
        output.write(line)
      end
      line_num += 1
    end
  end
end

def enumerate(input_dir, output_dir, training_genes)
  Dir.foreach(input_dir) do |item|
    next unless item.end_with? '.TXT'
    input = "#{input_dir}/#{item}"
    output = "#{output_dir}/#{item}"
    filter(input, output, training_genes)
  end
end


enumerate(test_input_dir, test_output_dir, training_genes)

p 'Done!'