require 'sinatra'
require "sinatra/reloader"

#같은 디렉토리에 있다고 표시하는 것이 .점 그 상태에서 /는 디렉토리 위치를 표시 파일 이름에 .rb는 생략함
require './block'

b = Blockchain.new
  
get '/' do 
	"지금 전체 블럭수는 :" + b.my_blocks.to_s
end	
	
get '/mine' do 

	 b.mining.to_s + " ㅇㅇ"

	
end