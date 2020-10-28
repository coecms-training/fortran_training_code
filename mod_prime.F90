module mod_prime
    use, intrinsic :: iso_fortran_env, only: int64
    implicit none
contains
    function is_prime(n)
        integer(kind=int64), intent(in) :: n
        logical :: is_prime
        integer(kind=int64) :: max_test, i
        ! First a few direct removals
        if (n <= 1_int64) then
            ! Negative numbers, zero, and one are not primes.
            is_prime = .FALSE.
            return
        end if
        if (n == 2_int64) then
            ! 2 is the only even prime
            is_prime = .TRUE.
            return
        end if
        if ( modulo(n, 2_int64) == 0 ) then
            ! If it were 2, we would have already returned true,
            ! all other even numbers are not primes.
            is_prime = .FALSE.
            return
        end if
        ! If we don't find a divisor before reaching the square root
        ! we won't find any other later
        max_test = int(sqrt(real(n)), kind=int64)

        is_prime = .TRUE.

        ! Test all odd number from 3 up to max_test
        do i = 3, max_test, 2
            if ( modulo(n, i) == 0_int64 ) then
                ! Found a divisor, it's not a prime
                is_prime = .FALSE.
!                exit
            end if
        end do

        ! If we reach here, we haven't found a divisor, so it is a prime.
        return
    end function is_prime
end module mod_prime