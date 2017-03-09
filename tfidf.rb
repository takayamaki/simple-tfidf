require_relative 'lib/opt.rb'
require_relative 'lib/func.rb'
require 'json'

$config = Tfidf.optparse

docPaths = Tfidf.findDocs(ARGV)

docsTf, df = Tfidf.getTfAndIdf(docPaths)

result = Tfidf.calcTfIdf(docsTf,df)

puts JSON.generate(result)
