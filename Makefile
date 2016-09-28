VERSION=1.2
BINDIR=/usr/bin
ETCDIR=/etc
MANDIR=/usr/share/man/man1
FILES=CHANGES LICENSE Makefile README rocknroll rocknroll.conf

all:
	@echo "possible target are :"
	@grep ^[a-z]*: Makefile | grep -v ^all:

install:
	perl -MCPAN -e 'File::Path::Tiny'
	perl -MCPAN -e 'Config::General' 
	perl -MCPAN -e 'Config::General::Extended'
	perl -MCPAN -e 'Dir::Which' 
	install	-o root -g root -m 755 rocknroll ${BINDIR}
	install	-o root -g root -m 644 rocknroll.conf ${ETCDIR}
	install	-o root -g root -m 644 rocknroll.1 ${MANDIR}
	
dist:
	#[ -d man1 ] || mkdir man1
	pod2text rocknroll > README
	pod2html rocknroll > README.html
	./rocknroll --man > rocknroll.1
	sed -i -e '/version management for git/s/".*"/"${VERSION}"/' rocknroll
	#tar cfz rocknroll-${VERSION}.tgz ${FILES}
