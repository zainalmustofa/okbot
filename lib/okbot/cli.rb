require 'rubygems'
require 'thor'
require 'nokogiri'
require 'rainbow'
require 'okbot/cli/stack'
require 'net/http'
require 'json'
require "highline/import"
require 'terminal-table/import'
require 'pry'

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

      case answer 
      when "1", "pvj"
        doc = Nokogiri::XML(open("https://www.cgvblitz.com/en/schedule/cinema/0100"))
        puts Rainbow("Result schedule PVJ MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts Rainbow(l.content).aqua
        end
        puts "--------------------"
      when "2", "miko"
        doc = Nokogiri::HTML(open("https://www.cgvblitz.com/en/schedule/cinema/1200"))
        puts Rainbow("Result schedule MIKO MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts Rainbow(l.content).aqua
        end
        puts "--------------------"
      when "3", "bec"
        doc = Nokogiri::HTML(open("https://www.cgvblitz.com/en/schedule/cinema/1400"))
        puts Rainbow("Result schedule BEC MALL").yellow
        puts "--------------------"
        doc.css('.schedule-title').children.each do |l|
          puts Rainbow(l.content).aqua
        end
        puts "--------------------"
      else
        puts "Please check you choice!"
      end
    end

    desc "stack COMMANDS", "Get Stack overflow question"
    subcommand "stack", Okbot::CLI::Stack
  end
end