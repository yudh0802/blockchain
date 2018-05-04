require 'digest'
require 'securerandom'
require 'httparty'

class Blockchain

	def initialize
		@chain = []
		@transaction = []
		@wallet = {} #information that have hash값
		@node = [] #우리는 일단 이곳에 port만 들어감.
	end

	def make_a_wallet
		new_wallet_address = SecureRandom.uuid
		@wallet[new_wallet_address] = 1000
		@wallet.to_s

	end

	def trans(s, r, a) #trans를 돌릴 때는 sender, receiver, amount가 있어야 돌린다.라는 의미
		puts @wallet[s]
		if @wallet[s].nil?
			"not exist wallet"
		elsif @wallet[r].nil?
			'not exist wallet'
		elsif @wallet[s].to_f < a.to_f
			"empty amount"
		else
		#여기 t는 여기에서만 사용되기 때문에 t를 쓰던 tt를 스던 상관 없음 다만 아래 @를 이어서 쓰자면
		t = {
			"sender" => s,
			"receiver" => r,
			"amount" => a
		}
		@wallet[r] = @wallet[r] + a.to_f
		@wallet[s] = @wallet[s] - a.to_f
		#@를 붙인건 위에서 initialize에서 선언했으므로 계속 똑같이 쓰임.
		@transaction << t
		"it's complete!"
	end
end

def mining
# history = Array.new	 #[]는 리스트다 라는 걸 의미함

		begin  # 루프 대신 begin end 도 같은 의미
			nonce = rand(100)
			
		end while nonce != 0
# a = 3은 a에 3을 넣을 때고, ==은 a가 3이 맞냐? 라고 묻을 때 쓰는 거임
# 1 ~ 100 에서 랜덤으로 뽑고 반복해서 돌건데 nonce가 0이 될때까지 돈다.
#10으로 나눴을 때 나머지란 의미 = %

block = {
	'index' => @chain.length + 1,
	'time' => Time.now,
	'nonce' => nonce,
	'pre block' => Digest::SHA256.hexdigest(last_block.to_s), #last_block.to_s 도 됌
	'transaction' => @transaction
}
@transaction = []
@chain << block

end

def current_chain
	@chain
end

def last_block
	@chain[-1] #배열의 마지막 값을 알 수 있는 방법임. 0은 시작이고 마지막은 -1	
end

def show_all_wallet
	@wallet
end

def get_other_blocks
	@node.each do |n|
		other_blocks = HTTParty.get("http://localhost:" + n.to_s + "/total_blocks").body
		if @chain.size < other_blocks.to_i
			full_blocks = HTTParty.get("http://localhost:" + n.to_s + "/get_blocks?blocks=" + @chain.to_json)
			@chain = JSON.parse(full_blocks)
		end
	end
end

def add_node(node)
	@node << node
	node
end

def total_nodes
	@node
end

def add_new_blocks(new_blocks)
	new_blocks.each do |b|
		@chain << b
	end
	end
end
