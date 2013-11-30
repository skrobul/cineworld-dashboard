require 'httparty'

class MyCineworld
    include HTTParty
    base_uri 'http://www.cineworld.com/api/quickbook'
    #default_params :output => 'json'
    format :json

    def initialize(key)
        @key = key
        %w{cinemas films performances dates}.each do |meth|
                self.class.send(:define_method, meth) do |opts={}|
                opts.merge!(:key => @key)
                self.class.get("/#{meth}", :query => opts)
            end
        end
    end
end