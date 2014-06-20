require "prawn"








#shiftsNum
#shifts['<<','>>']
tasksNum=ARGV[0].to_i



def generateTask
			hexIntro="0x"
			firstNum=hexIntro+Random.new.rand(1..1024).to_s(16)
			secondNum=hexIntro+Random.new.rand(1..1024).to_s(16)
			operators=['|','^','&']	

			return firstNum,secondNum,operators
		
		
	
end

def generateTest tasksNum

	Prawn::Document.generate "example.pdf" do |pdf|

	tasksNum.times {
		taskss=generateTask
			pdf.text"
			int a=#{taskss[0]}
			int b=#{taskss[1]}
			int res=a#{taskss[2][Random.new.rand(0..2)]}b
			res=??

					"
		 }
    end
	
end

generateTest tasksNum


