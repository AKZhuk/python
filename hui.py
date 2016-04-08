import sys
def check_substring(sub, argv):
	for i in argv:
		if i.find(sub)==-1:
			return False
	return True

sys.argv.pop(0)
argv = sys.argv
argv.sort(key=lambda x: len(x))
if len(argv) == 0:
	print('')
	sys.exit()
length = len(argv[0])
while length > 0:
	for i in range(0, len(argv[0])-length+1):
		if(check_substring(argv[0][i:i+length], argv)):
			print(argv[0][i:i+length] + '\n')
			sys.exit()
	length-=1;
print(' ')