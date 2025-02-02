program complex_calculator
    !Imported modules used for modularation
    use functions_module
    use utils_module
    implicit none

   ! Defined variables
    type(complex_number) :: a, b, c
    integer :: y, z, x
    logical :: exit = .false.
    character(len=25) :: input

    !Calls the main menu for calculator
do while(.not. exit)
    call main_menu()
    read(*,*) y

    if (y <=7 .AND. y >= 1) then
    
    if (y .NE. 7) then
    call format_result()
    read(*,*) z 
    endif
    select case(y)
        case(1) !Calls the add function
            call get_input(a, b, x, y, z)
            c = add(a, b)
            call print_format_result(c, z)
        case(2) !Calls the subtract function
            call get_input(a, b, x, y, z)
            c = subtract(a, b)
            call print_format_result(c, z)
        case(3) !Calls the multiply function
            call get_input(a, b, x, y, z)
            c = multiply(a, b)
            call print_format_result(c, z)
        case(4) !Calls the divide function
            call get_input(a, b, x, y, z)
            c = divide(a, b)
            call print_format_result(c, z)
        case(5) !Calls the power function
            call get_input(a, b, x, y, z)
            c = power(a, x)
            call print_format_result(c, z)
        case(6) !Calls the conjugate function
            if (z==1) then 
                print *, "Enter the complex number that is in the format-(Real, Imaginary): "
                read(*,"(F8.1, F8.1)") a%real, a%imag
            elseif (z==2) then
                print *, "Enter the complex number that is in the format-Real + Imaginary*i: "
                read(*, '(A)') input
                do while (.not.(parse_input(input, a)))
                    read(*, '(A)') input
                end do
            elseif (z==3) then
                print *, "Enter the complex number that is in the format-Real: "
                read(*,*) a%real
                a%imag = 0.0
            endif
            c = conjugate(a)
            call print_format_result(c, z)
        case(7)
            exit = .true.
            stop
        case default
            print *, "Invalid choice. Please try again."
    end select
end if
end do 
end program complex_calculator