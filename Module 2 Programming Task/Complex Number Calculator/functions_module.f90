module functions_module
    implicit none

    type complex_number
      real(kind=8) :: real, imag
    end type complex_number

    function parse_input(input, a) result(valid_input)
        character(len=*), intent(in) :: input
        type(complex_number), intent(out) :: a
        logical :: valid_input
        integer :: position_add, position_sub, position_i
        position_add = index(input, "+")
        if (position_add == 0) then
            position_sub = index(input, "-", back=.true.)
        endif
        position_i = index(input, "i")

        if (position_add > 0 .and. position_i > 0) then
            read(input(1:position_add - 1), *) real_num
            read(input(position_add + 1:position_i - 1), *) imag_num
            a%real = real_num
            a%imag = imag_num
            valid_input = .true.
        else if (position_sub > 0 .and. position_i > 0) then
            read(input(1:position_sub - 1), *) real_num
            read(input(position_sub + 1:position_i - 1), *) imag_num
            a%real = real_num
            a%imag = imag_num
            valid_input = .true.
        else
            print *, "Invalid input. Enter input in Real + Imaginary*i format:"
            valid_input = .false.
        endif
    end function parse_input

    function add(a, b) result(c)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: c
        c%real = a%real + b%real
        c%imag = a%imag + b%imag
    end function add  

    function subtract(a, b) result(c)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: c
        c%real = a%real - b%real
        c%imag = a%imag - b%imag
    end function subtract

    function multiply(a, b) result(c)
        complex(kind=8), intent(in) :: a, b
        complex(kind=8), intent(out) :: c
        c%real = a%real * b%real - a%imag * b%imag
        c%imag = a%real * b%imag + a%imag * b%real
    end function multiply

    function divide(a, b) result(c)
        complex(kind=8), intent(in) :: a, b, denominator
        complex(kind=8), intent(out) :: c
        denominator = b%real ** 2 + b%imag ** 2
        if (denominator == 0.0) then
            print *, "Undefined.Cannot divide by zero."
        else
            c%real = (a%real * b%real + a%imag * b%imag)/denominator
            c%imag = (a%real * b%imag - a%imag * b%real)/denominator
        endif
    end function divide

    function power(a, b) result(c)
        complex(kind=8), intent(in) :: a, c
        integer :: b
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

    function conjugate(a) result(c)
        type(complex_number), intent(in) :: a, c
        c%real = a%real
        c%imag = -a%imag
    end function conjugate

end module functions_module