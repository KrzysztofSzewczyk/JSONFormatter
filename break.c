
#include <stdio.h>

main(argc, argv) char * argv[]; {
	int brk;
	char * buf;
	
	if(argc != 2) {
		while(!feof(stdin))
			putchar(getchar());
		exit(0);
	} else
		brk = atoi(argv[1]);
	
	buf = malloc(brk);
	
	if(!buf) {
		perror("malloc");
		exit(1);
	}
	
	while(!feof(stdin)) {
		fgets(buf, brk, stdin);
		fprintf(stdout, "%s\n", buf);
	}
}
