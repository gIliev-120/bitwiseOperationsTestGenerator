a=420.to_s(16)
b=120.to_s(16)
a="0x"+a
b="0x"+b


p a 
p b

File.open("demo.c", "w") do  |file| 
	file<<"
	#include<stdio.h>
	int main(){
		int a=#{a};
		int b=#{b};
		int res=a^b;
		printf(\"%04x\",a);
		printf(\"%04x\",b);
		printf(\"%04x\",res);


  		return 0;
	}

	"
end

system("gcc demo.c -o demo")
system("./demo.out")