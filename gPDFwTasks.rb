require 'prawn'
pdf = Prawn::Document.new

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
	#return res
	
end

def addHexstoHtmlAndPdf pdf
	taskss=generateTask
	ans=calculateBitWise
	returnedHtml="<tr><td>"
	returnedHtml<<"<p>int a=#{taskss[0]}</p>"
	returnedHtml<<"<p>int b=#{taskss[1]}</p>"
	returnedHtml<<"<p>int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})</p>"
	returnedHtml<<"<p>res=??</p>"
	returnedHtml<<"</td></tr>"

	
	pdf.text"
	int a=#{taskss[0]}
	int b=#{taskss[1]}
	int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})
	res=??
	"



	return returnedHtml
end	

def addAnstoHtmlandPdf pdf
	taskss=generateTask
	ans=calculateBitWise
	returnedHtml="<tr><td>"
	returnedHtml<<"<p>int a=#{taskss[0]}</p>"
	returnedHtml<<"<p>int b=#{taskss[1]}</p>"
	returnedHtml<<"<p>int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})</p>"
	returnedHtml<<"<p> int res=#{ans}</p>"
	returnedHtml<<"</td></tr>"




	pdf.text"
	int a=#{taskss[0]}
	int b=#{taskss[1]}
	int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})
	int res=#{ans}
	"
	return returnedHtml
end


def genWholeHtml pdf
	htmlIntro="<!DOCTYPE html>
	<html>
	<head>
	<style>
	</style>
	<head>
	<body>
	<table border=\"1\" style=\"width:200px\">"
	endHtml="</table>
	</body>
	</html>"
	File.open("Test1.html", "w") do |file|  
		
		file<<"#{htmlIntro}"
		12.times{
			k=addHexstoHtmlAndPdf(pdf)
			file<<"#{k}"
		}
		file<<"#{endHtml}"
	end

end

def genWholeHtmlAns pdf
	htmlIntro="<!DOCTYPE html>
	<html>
	<head>
	<style>
	</style>
	<head>
	<body>
	<table border=\"1\" style=\"width:200px\">"
	endHtml="</table>
	</body>
	</html>"
	File.open("Ans1.html", "w") do |file|  
		
		file<<"#{htmlIntro}"
		12.times{
			k=addAnstoHtmlandPdf(pdf)
			file<<"#{k}"
		}
		file<<"#{endHtml}"
	end

end



genWholeHtml pdf
pdf.render_file "Test1.pdf"
genWholeHtmlAns pdf



