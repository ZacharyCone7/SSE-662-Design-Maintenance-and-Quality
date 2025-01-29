module functions_module
    implicit none

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

    subroutine get_choice(choice)
        integer, intent(out) :: choice
        read *, choice
    end subroutine get_choice

    subroutine print_format_result()
    
    subroutine get_inputs(a, b)
        complex(kind=8), intent(out) :: a, b
        print *, "Enter first complex number: "
        read *, a
        print *, "Enter second complex number: "
        read *, b
    end subroutine get_inputs

    subroutine add(a, b, result)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: result
        result = a + b
    end subroutine add  

    subroutine subtract(a, b, result)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: result
        result = a - b
    end subroutine subtract

    subroutine multiply(a, b, result)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: result
        result = a * b
    end subroutine multiply

    subroutine divide(a, b, result)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: result
        result = a / b
    end subroutine divide

    subroutine power(a, n, result)
        complex(kind=8), intent(in) :: a
        integer, intent(in) :: n
        complex(kind=8), intent(out) :: result
        result = a ** n
    end subroutine power







end module functions_module