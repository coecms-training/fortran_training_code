program prime
    use, intrinsic :: iso_fortran_env, only: int64
    use :: mod_prime
    implicit none
    integer(kind=int64) :: start, ii
    integer :: n, idx, m
    logical :: p
    integer, parameter :: fileunit = 1010
    integer :: ios
    character(len=200) :: iom
    integer(kind=int64), allocatable :: primes(:)

#ifdef AUTO
    start = 10000000_int64
    n = 100000
#else
    print *, "Calculates the n prime numbers after a given number"
    print *, "Enter a starting number: "
    read *, start
    print *, "Enter n:"
    read *, n
#endif

    allocate(primes(n))
    idx = 0

    open(unit=fileunit, file='data.dat', action='write', status='unknown', &
        iostat=ios, iomsg=iom, form='formatted')
    call check('OPEN')

    do ii = start, huge(start)
        p = is_prime(ii)
        if ( p ) then
            idx = idx + 1
            primes(idx) = ii
            n = n - 1
            if ( n < 1 ) then
                exit
            end if
        end if
    end do

    write(fileunit, fmt='(1I10)', iostat=ios, iomsg=iom) primes
    call check('WRITE')

    close(fileunit, iostat=ios, iomsg=iom)
    call check('CLOSE')

    print *, ii

contains

    subroutine check(op)
        character(len=*), intent(in) :: op
        if (ios /= 0) then
            print *, "Encountered Error during ", op
            print *, iom
            stop 1
        end if
    end subroutine check

end program prime

