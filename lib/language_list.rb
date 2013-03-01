require 'yaml'

module LanguageList
  class LanguageInfo
    attr_reader :name, :iso_639_3, :iso_639_1, :type

    def initialize(options)
      @name = options[:name]
      @iso_639_3 = options[:iso_639_3]
      @iso_639_1 = options[:iso_639_1]
      @common = options[:common]
      @type = options[:type]
    end

    def common?
      @common
    end

    def <=>(other)
      self.name <=> other.name
    end

    def iso_639_1?
      !@iso_639_1.nil?
    end

    [:ancient, :constructed, :extinct, :historical, :living, :special].each do |type|
      define_method("#{type.to_s}?") do
        @type == type
      end
    end

    def to_s
      "#{@iso_639_3}#{" (#{@iso_639_1})" if @iso_639_1} - #{@name}"
    end

    def self.find_by_iso_639_1(code)
      LanguageList::ISO_639_1.detect{|l| l.iso_639_1 == code }
    end

    def self.find_by_iso_639_3(code)
      LanguageList::ALL_LANGUAGES.detect{|l| l.iso_639_3 == code }
    end

    def self.find_by_name(name)
      LanguageList::ALL_LANGUAGES.detect{|l| l.name == name }
    end

    def self.find(code)
      find_by_iso_639_1(code) || find_by_iso_639_3(code) || find_by_name(code)
    end
  end
  
  LANGUAGE_HASH = YAML.load_file(File.expand_path(File.join(File.dirname(__FILE__),'..', 'data', 'languages.yml')))
  ALL_LANGUAGES = LANGUAGE_HASH.map{|e| LanguageInfo.new(e) }
  ISO_639_1 = ALL_LANGUAGES.select(&:iso_639_1?)
  LIVING_LANGUAGES = ALL_LANGUAGES.select(&:living?)
  COMMON_LANGUAGES = ALL_LANGUAGES.select(&:common?)
end
