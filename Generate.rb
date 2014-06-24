require "prawn"
htmlIntro="<!DOCTYPE html>
<html>
<head>
<style>
</style>
</head>
<body>
<table border=\"1\" style=\"width:200px\">"

endHtml="</table>
</body>
</html>"

def generateTask

	difficulty=ARGV[1].to_s
	hexIntro="0x"
#			firstNum=hexIntro+Random.new.rand(1..12000).to_s(16)
#			secondNum=hexIntro+Random.new.rand(1..12000).to_s(16)
operators=['|','^','&']
opIndex=Random.new.rand(0..2)
shifts=['<<','>>']
shIndex=Random.new.rand(0..1)
#			numOfShifts=Random.new.rand(1..32)

unless difficulty == "Hard" 
	firstNum=hexIntro+Random.new.rand(1..2048).to_s(16)
	secondNum=hexIntro+Random.new.rand(1..2048).to_s(16)
	x = Random.new.rand(0..5)
	numOfShifts = 2 ** x
else 
	firstNum=hexIntro+Random.new.rand(1..12000).to_s(16)
	secondNum=hexIntro+Random.new.rand(1..12000).to_s(16)
	numOfShifts=Random.new.rand(1..16)
end	
return firstNum,secondNum,operators[opIndex],shifts[shIndex],numOfShifts

end
def calculateBitWise 
	tasks = generateTask
	File.open("demo.c", "w") do |file|  
		file<<"
		#include<stdio.h>

		int main(){
			int a=#{tasks[0]};
			int b=#{tasks[1]};
			unsigned int res=a#{tasks[2]}(b#{tasks[3]} #{tasks[4]});
			printf(\"0x\");
			printf(\"%x\",res);

			return 0;

		}
		"
	end	
	p res = `gcc demo.c && ./a.out `
	
end


def addHexstoHtml taskss
	
	returnedHtml="<tr><td>"
	returnedHtml<<"<p>int a=#{taskss[0]}</p>"
	returnedHtml<<"<p>int b=#{taskss[1]}</p>"
	returnedHtml<<"<p>int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})</p>"
	returnedHtml<<"<p>res=??</p>"
	returnedHtml<<"</td></tr>"

	return returnedHtml

end


def addAnswerstoPDF(pdfWithAnswers,testNumber,taskss,ans)
	pdfWithAnswers[testNumber].text"
	int a=#{taskss[0]}
	int b=#{taskss[1]}
	int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})
	res=??
	Answer->res=#{ans}
	"

end

def genWholeHTML htmlIntro,endHtml,miniHtmls,testNumber
	
	File.open("Test#{testNumber}.html", "w") do |file|  
		file<<"#{htmlIntro}"
		file<<"#{miniHtmls}"
		file<<"#{endHtml}"
	end 	

end



numOfTest=ARGV[0].to_i
pdf=Array.new(numOfTest)
pdfWithAnswers=Array.new(numOfTest)
taskss=Array.new(12)
 
for testNumber in 1..numOfTest
pdf[testNumber] = Prawn::Document.new
pdfWithAnswers[testNumber] = Prawn::Document.new
miniHtmls=""
miniHtmlsWithAnswers=""
for taskNumber in 1..12
 
        taskss[taskNumber]=generateTask
        addHexstoPDF(pdf,testNumber,taskss[taskNumber])
        miniHtmls<<addHexstoHtml(taskss[taskNumber])
        genWholeHTML(htmlIntro,endHtml,miniHtmls,testNumber)                   
        ans = calculateBitWise(taskss[taskNumber])
        addAnswerstoPDF(pdfWithAnswers,testNumber,taskss[taskNumber],ans)
 
end
pdfWithAnswers[testNumber].render_file "Answers_Test#{testNumber}.pdf"
pdf[testNumber].render_file "Test#{testNumber}.pdf"
end
