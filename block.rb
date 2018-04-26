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


				end
			end

