require 'digest'

class Blockchain

	def initialize
		@chain = []
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
	'time' => Time.now.to_i,
	'nonce' => nonce,
	'pre block' => Digest::SHA256.hexdigest(JSON.dump(last_block)) #last_block.to_s 도 됌
}

@chain << block

end

def current_chain
	@chain
end

def last_block
	@chain[-1] #배열의 마지막 값을 알 수 있는 방법임. 0은 시작이고 마지막은 -1	
end

end

