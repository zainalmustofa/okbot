module Okbot
  module CLI
    class Stack < Thor
      desc "title", "Search stack overflow question and get link"
      option :tags
      def title
        title = ask "Input text: "
        print "Doing your title..."
        spin_it{
          sleep rand(4)+2
        }
        
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

    desc "spin_it", "FOR LOADING"
    def spin_it(fps=10)
      chars = %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷]
      delay = 1.0/fps
      iter = 0
      spinner = Thread.new do
        while iter do  # Keep spinning until told otherwise
          print chars[(iter+=1) % chars.length]
          sleep delay
          print "\b"
        end
      end
      yield.tap{       # After yielding to the block, save the return value
        iter = false   # Tell the thread to exit, cleaning up after itself…
        spinner.join   # …and wait for it to do so.
      }                # Use the block's return value as the method's
    end
    end
  end
end