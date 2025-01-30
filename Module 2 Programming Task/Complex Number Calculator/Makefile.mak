MAKEFLAGS += --no-built-in-rules --no-builtin-variables

FC := gfortran
SRC := functions_module.f90 utils_module.f90 main.f90 # List of source files
OBJS := $(SRC:.f90=.o) # Replace .f90 with .o
TEST_EXE := Complex_Calculator # Name of the executable
EXE_EXT := .exe
RM := del /Q

# Rules
.PHONY: all clean # Define phony targets

all: $(TEST_EXE) # Define the default target

$(TEST_EXE)$(EXE_EXT): $(OBJS) # Define the target Compile the source files
	$(FC) -o $@ $^

$(OBJS): %.o: %.f90 # Define the rule for compiling source files # Compile the source file
	$(FC) -c -o $@ $< 

clean:
	$(info Cleaning...)
	$(RM) $(OBJS) $(wildcard *.mod)
