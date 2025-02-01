module utils_module
    use functions_module
    implicit none

    logical :: valid_input

    contains
        subroutine main_menu()
            print *, "Complex Number Calculator"
            print *, "--------------------------"
            print *, "1. Add"
            print *, "2. Subtract"
            print *, "3. Multiply"
            print *, "4. Divide"
            print *, "5. Power"
            print *, "6. Exit"
            print *, "Enter your calculation choice: "
        end subroutine main_menu

        subroutine format_result()
            print *, "How do you want to format the result?"
            print *, "-------------------------------------"
            print *, "1. (Real, Imaginary)"
            print *, "2. Real + Imaginary*i"
            print *, "3. Real (for real numbers)"
            print *, "Enter your choice: "
        end subroutine format_result

        subroutine get_input(a, b, x, y, z)
            type(complex_number), intent(out) :: a, b
            integer, intent(in) :: y, z
            character(len=25) :: input
            logical :: valid_input
            integer :: x

            select case(z)
            case(1)
                print *, "Enter the first complex number in the following format (Real, Imaginary): "
                read(*,"(F8.1, F8.1)") a%real, a%imag
                if (y == 5) then
                    print *, "Enter the integer power of the first complex number: "
                    read(*,*) x
                else
                    print *, "Enter the second complex number in the following format (Real, Imaginary):"
                    read(*,"(F8.1, F8.1)") b%real, b%imag
                endif
            case(2)
                print *, "Enter the first complex number in the following format Real + Imaginary*i: "
                read(*, '(A)') input
                valid_input = parse_input(input, a)
                if (y == 5) then
                    print *, "Enter the integer power of the first complex number: "
                    read(*,*) x
                else
                    print *, "Enter the second complex number in the following format Real + Imaginary*i:"
                    read(*, '(A)') input
                    valid_input = parse_input(input, b)
                endif
            case(3)
                print *, "Enter the first Real number: "
                read(*,*) a%real
                a%imag = 0.0
                if (y == 5) then
                    print *, "Enter the integer power of the first Real number: "
                    read(*,*) x
                else
                    print *, "Enter the second Real number:"
                    read(*,*) b%real
                    b%imag =0.0
                endif
            end select
        end subroutine get_input

        subroutine print_format_result(c, z)
            type(complex_number), intent(in) :: c
            integer, intent(in) :: z
            if (z == 1) then
                print *, "The result is: (", c%real, ", ", c%imag, ")"
            else if (z == 2) then
                print *, "The result is: ", c%real, " + ", c%imag, "*i"
            else if (z == 3) then
                print *, "The result is: ", c%real
            endif
        end subroutine print_format_result

    end module utils_module