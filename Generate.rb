require "Prawn"
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

def addHexstoHtml taskss
	
	returnedHtml="<tr><td>"
	returnedHtml<<"<p>int a=#{taskss[0]}</p>"
	returnedHtml<<"<p>int b=#{taskss[1]}</p>"
	returnedHtml<<"<p>int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})</p>"
	returnedHtml<<"<p>res=??</p>"
	returnedHtml<<"</td></tr>"

	return returnedHtml

end

def addHexstoPDF(pdf,testNumber,taskss)
pdf[testNumber].text"
			int a=#{taskss[0]}
			int b=#{taskss[1]}
			int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})
			res=??
		"
end


numOfTest=ARGV[0].to_i
pdf=Array.new(numOfTest)
taskss=Array.new(12)
miniHtmls=Array.new(12)

for testNumber in 1..numOfTest
pdf[testNumber] = Prawn::Document.new
for taskNumber in 1..12
	taskss[taskNumber]=generateTask
	addHexstoPDF(pdf,testNumber,taskss[taskNumber])	
	miniHtmls[taskNumber]=addHexstoHtml(taskss[taskNumber])
	#p miniHtmls
	
end

pdf[testNumber].render_file "Test#{testNumber}.pdf"
end


