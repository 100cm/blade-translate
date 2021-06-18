require "uri"
require "net/http"
require "json"
require "rainbow/ext/string"


module Blade
  API_URL = "http://fanyi.youdao.com/openapi.do?keyfrom=bladetrans&key=902909552&type=data&doctype=json&version=1.1&q="
  class Translate
    def initialize(input)
      @words = input
      query_for_hash
    end

    def query_for_hash
      query_url    = API_URL + URI.encode_www_form_component(@words.gsub(/ /, '+'))
      result_json  = Net::HTTP.get(URI(query_url))
      @result_hash = JSON.parse(result_json)
    end

    def translations
      translations = @result_hash["translation"]
      lines        = translations.collect do |translation|
        "  " + translation.color(:green)
      end
      lines << ""
    end

    def word_and_phonetic
      line     = " " + @words
      phonetic = @result_hash["basic"]["phonetic"] if @result_hash["basic"]
      line     += " [ #{phonetic} ]".color(:magenta) if phonetic
      [line, ""]
    end

    def dict_explains
      dict_explains = @result_hash["basic"]["explains"] if @result_hash["basic"]
      lines         = dict_explains.collect do |explain|
        " - " + explain.color(:green)
      end
      lines << ""
    end

    def web_results
      return [] unless @result_hash["web"]
      lines       = []
      web_results = @result_hash["web"]
      web_results.each_with_index do |web_result, i|
        web_result_key   = web_result["key"].gsub(/#{@words}/i, @words.color(:yellow))
        web_result_value = web_result["value"].join(', ').color(:cyan)
        lines << " #{i+1}. #{web_result_key}"
        lines << "    #{web_result_value}"
      end
      lines << ""
    end

    # 一般来说，有道词典解释的比较好
    # 但是长一点的句子有道词典没有结果，需要用有道翻译
    # 所以如果有道词典有结果就只用词典的结果，否则用有道翻译
    def yd_result
      @result_hash["basic"].nil? ? translations : dict_explains
    end

    def result
      output = []
      output << word_and_phonetic << yd_result << web_results
      output.flatten
    end
  end
end
