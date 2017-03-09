require 'optparse'

class Tfidf
  class << self
    def optparse
      op = OptionParser.new
      config = {}

      op.on('-l LIMIT','--limit LIMIT',Integer,"Limit of words each docs. Default:no limit") do |v|
          raise(OptionParser::InvalidArgument,"LIMIT must at least 1.") if v < 1
          config[:limit] = v
      end

      op.on('-b [Precision]','--bigdecimal [PRECISION]',Integer,"Useing BigDecimal for calculation. You can specify precision by PRECISION. Default:10") do |v|
        config[:BigDecimal] = v || 10
        raise(OptionParser::InvalidArgument,"Precision must at least 1.") if config[:BigDecimal] < 1
      end
      op.parse!(ARGV)
      return config
    end

    def findDocs(arg)
      if 0 == arg.length
        raise(OptionParser::InvalidArgument,"Missing target directory.")
      elsif 1 < arg.length
        raise(OptionParser::InvalidArgument,"Only one target directory can be specified.")
      elsif !Dir.exists? arg[-1]
        raise(OptionParser::InvalidArgument,"No such directory.")
      elsif File.ftype(arg[-1]) != "directory"
        raise(OptionParser::InvalidArgument,"Target must be directory.")
      else
        target = arg[-1].gsub(/\/$/,'')
        docPaths = Dir.glob("#{target}/**/*").delete_if do |item| File.ftype(item) != "file" end
      end
    end
  end
end
