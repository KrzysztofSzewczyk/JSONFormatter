
#include <stdio.h>

main(argc, argv) char * argv[]; {
	FILE * shape;
	int c, i;
	
	if(argc != 2)
		abort();
	
	shape = fopen(argv[1], "r");
	
	if(!shape)
		abort();
	
	while(!feof(shape)) {
		c = fgetc(shape);
		if(c == '@')
			if((i = getchar()) == EOF)
				break;
		putchar(c == '@' ? i : c);
	}
	
	fclose(shape);
}
