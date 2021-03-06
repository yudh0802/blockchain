require 'sinatra'
require "sinatra/reloader"
require 'json'


#같은 디렉토리에 있다고 표시하는 것이 .점 그 상태에서 /는 디렉토리 위치를 표시 파일 이름에 .rb는 생략함
require './block'

b = Blockchain.new

get '/' do 
	message = ""
	b.current_chain.each do |c|
		message << "Index is " + c['index'].to_s + "<br>"
		message << "Nonce is " + c['nonce'].to_s + "<br>"
		message << "Time is " + c['time'].to_s  + "<br>"
		message << "Pre block is " + c['pre block'].to_s + "<br>"
		message << "Current block is " + Digest::SHA256.hexdigest(c.to_s) + "<br>"
		message << "transaction is " + c['transaction'].to_s + "<br>"
		message << "<hr>"
	end

	message

end	

get '/mine' do
	"블럭찾았다 " + b.mining.to_s
end

get '/new_wallet' do
	b.make_a_wallet

end

get '/transaction' do
	# "person who send : " + params["sender"] +
	# "<br>" + "person who receive : " + params["receiver"] +"<br>"
	# + "amount of transaction : " + params["amount"]

	b.trans(params["sender"], params["receiver"], params["amount"])
	
end

get '/all_wallet' do
	b.show_all_wallet.to_s
end

get '/total_blocks' do
	b.current_chain.size.to_s
end

get '/other_blocks' do
	b.get_other_blocks.to_s
end

get '/register' do
	b.add_node(params["node"])
end

get '/my_nodes' do
	b.total_nodes.to_s
end

get '/get_blocks' do
	new_blocks = JSON.parse(params["blocks"])
	b.add_new_blocks(new_blocks)
	b.current_chain.to_json
end