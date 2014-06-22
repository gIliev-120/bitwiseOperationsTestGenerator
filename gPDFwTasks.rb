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

def genHtml
	taskss=generateTask
	returnedHtml="<tr><td>"
	returnedHtml<<"<p>int a=#{taskss[0]}</p>"
	returnedHtml<<"<p>int b=#{taskss[1]}</p>"
	returnedHtml<<"<p>int res=a#{taskss[2]}(b#{taskss[3]}#{taskss[4]})</p>"
	returnedHtml<<"<p>res=??</p>"
	returnedHtml<<"</td></tr>"

	return returnedHtml
end

def genWholeHtml 
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
		k=genHtml
		file<<"#{k}"
	}
		file<<"#{endHtml}"
	end

end

genWholeHtml



