require 'pry'
require 'csv'

# Given a global directory of .txt samples, should output genes that occur in ALL samples (occur_all_genes)
# Then, remove any genes not in occur_all_genes from all the samples

input_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-AMabscall-cleaned'
output_dir = '/Users/yosriady/Downloads/Assignment2-GeneExpression/training/trainset-txt-fully-cleaned'


# First, collect counts of all genes across all samples

# TODO


# Then, filter out genes that do not have MAX_COUNT, where MAX_COUNT = number of samples