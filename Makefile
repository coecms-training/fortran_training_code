FC=ifort
FLAGS=
LFLAGS=$(FLAGS)
CFLAGS=$(FLAGS) -c

.SUFFIXES:
.SUFFIXES: .F90 .o

prime : prime.o mod_prime.o
	$(FC) $(LFLAGS) -o $@ $^

.F90.o:
	$(FC) $(CFLAGS) -o $@ $<

# Dependencies

prime.o : mod_prime.o

clean :
	rm -rf *.o *.mod prime data.dat

.PHONY: clean