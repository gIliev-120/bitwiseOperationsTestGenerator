require "prawn"








#shiftsNum

tasksNum=ARGV[0].to_i



def generateTask
			hexIntro="0x"
			firstNum=hexIntro+Random.new.rand(1..1024).to_s(16)
			secondNum=hexIntro+Random.new.rand(1..1024).to_s(16)
			operators=['|','^','&']
			opIndex=Random.new.rand(0..2)
			shifts=['<<','>>']
			shIndex=Random.new.rand(0..1)
			numOfShifts=Random.new.rand(1..16)

			return firstNum,secondNum,operators[opIndex],shifts[shIndex],numOfShifts
		
		
	
end




def generateTestAndAnswers tasksNum

	Prawn::Document.generate "example.pdf" do |pdf|

	tasksNum.times {
		taskss=generateTask
			pdf.text"
			int a=#{taskss[0]}
			int b=#{taskss[1]}
			int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})
			res=??

					"

			File.open("demo.c", "w") do |file|  
				file<<"
					#include<stdio.h>
					int main(){
					int a=#{taskss[0]};
					int b=#{taskss[1]};
					int res=a#{taskss[2]}(b#{taskss[3]} #{taskss[4]});
					printf(\"%d\",a);
			
					return 0;

					}
				"

			end	

			`gcc demo.c -o demo`
			

		 }
    end
	
end

generateTestAndAnswers tasksNum


