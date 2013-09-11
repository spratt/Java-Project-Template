######################################################################
# Project Setttings
######################################################################

CLASSES  = 	TestBuild \
			TestBuild2

######################################################################
# Global Settings
######################################################################

JAVAC    =	javac
JAVA     =	java

JCFLAGS  =	-Xlint -g
JFLAGS   =	-enableassertions

.MAIN: doc

# http://www.gnu.org/software/make/manual/make.html#Phony-Targets
.PHONY: doc all run clean ${addprefix run_,${CLASSES}}

######################################################################
# Global Rules
######################################################################

doc:
	@echo "make all       - compiles all classes"
	@echo "make run       - runs each class with standard input from CLASSNAME_input.txt"

all:	${addsuffix .class, ${CLASSES}}

run:	all ${addprefix run_, ${CLASSES}}

clean:
	rm -f ${addsuffix .class, ${CLASSES}}

.SUFFIXES: .java .class

# http://www.gnu.org/software/make/manual/make.html#Pattern-Rules
# http://www.gnu.org/software/make/manual/make.html#Automatic-Variables
%.class:	%.java
	${JAVAC} ${JCFLAGS} $<

run_%: %.class
	@echo ======================================================================
	@echo Running ${basename $<}
	@echo ======================================================================
	${JAVA} ${basename $<} < ${addsuffix _input.txt,${basename $<}}
