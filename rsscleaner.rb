require 'sinatra'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

urls = {}
urls["localnews"] = "http://www.codyenterprise.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/local,news/local/*&f=rss"
urls["codyobits"] = "http://www.codyenterprise.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/obituaries,news/obituaries/*&f=rss"

get '/:slug' do
  source = urls[params[:slug].to_s]
  content = ""
  open(source) do |s| 
    content = s.read 
  end
  rss = RSS::Parser.parse(content, false)
  
  content_type :rss 
  "#{rss}"
end
