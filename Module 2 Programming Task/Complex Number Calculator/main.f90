!        add(a, b): Adds two complex numbers a and b.
!        subtract(a, b): Subtracts complex number b from a.
!        multiply(a, b): Multiplies two complex numbers a and b.
!        divide(a, b): Divides complex number a by b.
!        power(a, n): Raises complex number a to the power of integer n. 

program complex_calculator
    use complex_module
    use functions_module
    !use operations_module
    implicit none

    type(complex) :: a, b, c
    integer :: x, y, z

do while(.false.)
    call main_menu()
    read(*,*) y

    if (y <= 5) then
    call format_menu()
    read(*,*) z
    else
        exit = .true.
        stop
    end if  

    select case(y)
        case(1)
            call add(a, b, result)
            c = add(a, b)
            call print_format_result(c, z)
        case(2)
            call subtract(a, b, result)
            c = subtract(a, b)
            call print_format_result(c, z)
        case(3)
            call multiply(a, b, result)
            c = multiply(a, b)
            call print_format_result(c, z)
        case(4)
            call divide(a, b, result)
            c = divide(a, b)
            call print_format_result(c, z)
        case(5)
            call power(a, b, result)
            c = power(a, b)
            call print_format_result(c, z)
        case(6)
            exit = .true.
            stop
        case default
            print *, "Invalid choice. Please try again."
    end select
end do 
end program complex_calculator


    print *, "Enter the real part of the first complex number: "
    read *, real_part
    print *, "Enter the imaginary part of the first complex number: "
    read *, imaginary_part
    a = complex(real_part, imaginary_part)

    print *, "Enter the real part of the second complex number: "
    read *, real_part
    print *, "Enter the imaginary part of the second complex number: "
    read *, imaginary_part
    b = complex(real_part, imaginary_part)

    print *, "Addition: ", add(a, b)
    print *, "Subtraction: ", subtract(a, b)
    print *, "Multiplication: ", multiply(a, b)
    print *, "Division: ", divide(a, b)
    print *, "Power: ", power(a, 2)