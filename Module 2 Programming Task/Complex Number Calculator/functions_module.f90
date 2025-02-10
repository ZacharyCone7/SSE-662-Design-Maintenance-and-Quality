module functions_module
    implicit none

    ! Complex number type
    type complex_number
      real(kind=8) :: real, imag
    end type complex_number

    contains
        ! Function to parse user input
        function parse_input(input, a) result(valid_input)
            character(len=*), intent(in) :: input
            type(complex_number) :: a
            logical :: valid_input
            integer :: position_add, position_sub, position_i
            real(kind=8) :: real_num, imag_num
            
            ! Find the position of the plus sign and the minus sign
            position_add = index(input, "+")
            if (position_add == 0) then
                position_sub = index(input, "-", back=.true.)
            endif
            position_i = index(input, "i")

            ! Check if the input is in the correct format
            if (position_add > 0 .and. position_i > 0) then !Add format
                read(input(1:position_add - 1), *) real_num
                read(input(position_add + 1:position_i - 1), *) imag_num
                ! Set the real and imaginary parts of the complex number
                a%real = real_num
                a%imag = imag_num
                valid_input = .true.
            else if (position_sub > 0 .and. position_i > 0) then !Subtract format
                read(input(1:position_sub - 1), *) real_num
                read(input(position_sub + 1:position_i - 1), *) imag_num
                ! Set the real and imaginary parts of the complex number
                a%real = real_num
                a%imag = imag_num
                valid_input = .true.
            else
                print *, "Invalid input. Enter input in Real + Imaginary*i format:"
                valid_input = .false.
            endif
        end function parse_input
        
        ! Complex number operations
        function add(a, b) result(c)! Add function
            type(complex_number), intent(in) :: a, b
            type(complex_number) :: c
            c%real = a%real + b%real
            c%imag = a%imag + b%imag
        end function add  

        function subtract(a, b) result(c)! Subtract function
            type(complex_number), intent(in) :: a, b
            type(complex_number) :: c
            c%real = a%real - b%real
            c%imag = a%imag - b%imag
        end function subtract

        function multiply(a, b) result(c)! Multiply function
            type(complex_number), intent(in) :: a, b
            type(complex_number) :: c
            c%real = a%real * b%real - a%imag * b%imag
            c%imag = a%real * b%imag + a%imag * b%real
        end function multiply

        function divide(a, b) result(c)! Divide function
            type(complex_number), intent(in) :: a, b
            type(complex_number) :: c
            type(complex_number) :: denominator
            !We need to calculate the denominator which is the square of the imaginary part of b and the real part of b
            denominator = multiply(b, conjugate(b))
            if (denominator%real == 0.0 .AND. denominator%imag == 0.0) then
                print *, "Undefined.Cannot divide by zero."
            else
                c = multiply(a, conjugate(b))
                c%real = c%real / denominator%real
                c%imag = c%imag / denominator%real
            endif
        end function divide

        function power(a, b) result(c)! Power function
            type(complex_number) :: a 
            type(complex_number) :: c
            integer :: b, i
            c = a 
            if (b == 0) then
                c%real = 1
                c%imag = 0
                return
            else if (b == 1) then !return c
                return
            end if
            do i = 2, b !b is the integer assigned, i iterates up from 2 until i > b
                c = multiply(a, c)
            end do  
        end function power

        function conjugate(a) result(c)! Conjugate function
            type(complex_number), intent(in) :: a
            type(complex_number) :: c
            c%real = a%real
            c%imag = -a%imag
        end function conjugate

    end module functions_module