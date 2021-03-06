module test_NWTC_RandomNumber

    use pFUnit_mod
    use NWTC_RandomNumber
    
    implicit none

    integer, parameter :: stdout=6
    character(9), parameter :: nullfile="/dev/null"
    character(11), parameter :: terminal="/dev/stdout"

contains
    
@test
subroutine test_RANLUX()

    type(NWTC_RandomNumber_ParameterType)  :: p              ! Paramters for random number generation
    integer(IntKi)               :: error_status
    character(ErrMsgLen)         :: error_message

    real(ReKi)                   :: random_numbers(2)  ! Uniformly distributed random numbers

    p%pRNG = pRNG_RANLUX
    p%RandSeed(1) = 1

    call RandNum_Init(p, error_status, error_message)
    @assertEqual( 0, error_status )

    call UniformRandomNumbers(p%pRNG, random_numbers)
    @assertEqual( (/ 0.94589489698410034, 0.47347849607467651 /), random_numbers )

end subroutine

@test
subroutine test_INTRINSIC()

    type(NWTC_RandomNumber_ParameterType)  :: p              ! Paramters for random number generation
    integer(IntKi)               :: error_status
    character(ErrMsgLen)         :: error_message

    integer                      :: expected_seed_count
    real(ReKi)                   :: random_numbers(2)  ! Uniformly distributed random numbers

    p%pRNG = pRNG_INTRINSIC
    p%RandSeed(1) = 1
    p%RandSeed(2) = 2

    open(unit=stdout, file=nullfile, status="old")
    call RandNum_Init(p, error_status, error_message)
    open(unit=stdout, file=terminal, status="old")
    @assertEqual( 0, error_status )

    ! We cant use this test since it will fail for various machine/compiler combinations
    ! call UniformRandomNumbers(p%pRNG, random_numbers)
    ! @assertEqual( (/ 0.80377975339288821, 0.47469797199574959 /), random_numbers )
end subroutine

end module
