module Okbot
  module CLI
    class Stack < Thor
      desc "stack title", "Search stack overflow question and get link"
      option :tags
      def title
        title = ask "Input text: "
        url = "https://api.stackexchange.com/2.2/search/advanced?pagesize=5&order=desc&sort=activity&title=#{title}&site=stackoverflow&filter=!1zSk2G.tfS9G_M7ErPqm("
        uri = URI(url)
        response  = Net::HTTP.get(uri)
        output    = JSON.parse(response)
        rows = []

        output["items"].each_index do |i, t|
          rows << ['Tags', output["items"][i]["tags"]]
          rows << ['Title', output["items"][i]["title"]]
          rows << ['Is answered', output["items"][i]["is_answered"]]
          rows << ['Link', output["items"][i]["link"]]
          rows << :separator
        end
        puts table([nil, Rainbow("Result for: #{title}").red], *rows)
      end
    end
  end
end