require 'rubygems'
require 'thor'
require 'nokogiri'
require 'rainbow/ext/string'
require 'okbot/cli/stack'
require 'net/http'
require 'json'
require "highline/import"
require 'terminal-table/import'
require 'pry'
require 'open-uri'

module Okbot
  class MyCli < Thor
    desc "blitz", "Get schedule theater on blitz bandung"

    def blitz
      puts "Please choice your theater!"
      puts "1. pvj"
      puts "----------"
      puts "2. miko"
      puts "----------"
      puts "3. bec"
      puts "----------"
      answer = STDIN.gets.chomp
      print "Doing your schedule..."
      spin_it{
        sleep rand(4)+2
      }
      print "done!"
      case answer 
      when "1", "pvj"
        doc = Nokogiri::XML(open("https://www.cgvblitz.com/en/schedule/cinema/0100"))
        puts Rainbow("Result schedule PVJ MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts l.content.color(:cyan)
        end
        puts "--------------------"
      when "2", "miko"
        doc = Nokogiri::HTML(open("https://www.cgvblitz.com/en/schedule/cinema/1200"))
        puts Rainbow("Result schedule MIKO MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts l.content.color(:cyan)
        end
        puts "--------------------"
      when "3", "bec"
        doc = Nokogiri::HTML(open("https://www.cgvblitz.com/en/schedule/cinema/1400"))
        puts Rainbow("Result schedule BEC MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts l.content.color(:cyan)
        end
        puts "--------------------"
      else
        puts "Please check you choice!"
      end
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
    desc "stack COMMANDS", "Get Stack overflow question"
    subcommand "stack", Okbot::CLI::Stack
  end
end