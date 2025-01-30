program complex_calculator
    use functions_module
    use utils_module
    implicit none

    type(complex) :: a, b, c
    integer :: y, z

do while(.false.)
    call main_menu()
    read(*,*) y

    if (0 > y <= 5) then
    call format_menu()
    read(*,*) z 

    select case(y)
        case(1)
            call get_input(a, b, x, y, z)
            c = add(a, b)
            call print_format_result(c, z)
        case(2)
            call get_input(a, b, x, y, z)
            c = subtract(a, b)
            call print_format_result(c, z)
        case(3)
            call get_input(a, b, x, y, z)
            c = multiply(a, b)
            call print_format_result(c, z)
        case(4)
            call get_input(a, b, x, y, z)
            c = divide(a, b)
            call print_format_result(c, z)
        case(5)
            call get_input(a, b, x, y, z)
            c = power(a, b)
            call print_format_result(c, z)
        case(6)
            exit = .true.
            stop
        case default
            print *, "Invalid choice. Please try again."
    end select
    end if 
end do 
end program complex_calculator