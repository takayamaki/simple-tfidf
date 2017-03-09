require 'natto'

class Tfidf
  class << self
    def getTfAndIdf(docPaths)
      require 'bigdecimal' if $config[:BigDecimal]

      docsTf = {}
      df = {}

      mcb = Natto::MeCab.new
      regexp = /[!-~]|^[あ-ん]$/

      docPaths.each do |path|
        docsTf[path] = {}
        terms = []
        text = nil
        File.open(path) do |fp|
          text = fp.read
        end

        mcb.parse(text) do |term|
          next if (term.is_bos?() || term.is_eos?() || term.surface =~ regexp || term.feature.split(',')[0] == '記号')
          terms << term.surface
          docsTf[path][term.surface] ||= initDecimal
          docsTf[path][term.surface] +=1
        end

        terms.uniq.each do |term|
          df[term] ||= initDecimal
          df[term] +=1
        end
      end
      return docsTf,df
    end

    def initDecimal
      if Object.const_defined?(:BigDecimal)
        return BigDecimal(0)
      else
        return 0.0
      end
    end

    def calcTfIdf(docsTf,df)
      result = {}

      docsTf.each do |name,tfs|
        tfidfs = []

        tfs.each do |term,tf|
          tfidfs << [term,(tf/df[term]) ]
        end

        result[name] = tfidfs.sort_by do |tfidf|
          -tfidf[1]
        end

        result[name] = result[name][0...$config[:limit]] if $config[:limit]

      end
      return result
    end
  end
end
