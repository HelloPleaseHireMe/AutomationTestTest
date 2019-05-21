class problem1

  div(:label_1, id: 'lbl_val_1')
  div(:label_2, id: 'lbl_val_2')
  div(:label_3, id: 'lbl_val_3')
  div(:label_4, id: 'lbl_val_4')
  div(:label_5, id: 'lbl_val_5')
  div(:label_total, id: 'lbl_ttl_val')

  div(:text_1, id 'txt_val_1')
  div(:text_2, id 'txt_val_2')
  #Don't know if it was a typo but 3 is skipped in the slide
  div(:text_3, id 'txt_val_4')
  div(:text_4, id 'txt_val_5')
  div(:text_5, id 'txt_val_6')
  div(:text_total, id 'txt_ttl_val')

  def is_num(string)
    if Float(string) == false
      puts "Fail - String is not a number"
    end
  end

  def verify_layout
    #This test is not at all ideal, usually you wouldn't just check if the right about of elements exist on a page
    #There would probably be a reason each element is checked and content inside to confirm is has loaded correctly
    #If you want me to go further with this test let me know, I'm just following what the PowerPoint said
    elements = [label_1, label_2, label_3, label_4, label_5, label_total, text_1, text_2, text_3, text_4, text_5, text_total]
    elements.each do |element|
      if !(element.exists?)
        puts "Fail - The page layout is missing elements"
        return false
      end
    end
    puts "All elements are on the page"
    return true
  end

  def verify_values(state)
    values = [ text_1, text_2, text_3, text_4, text_5, text_total ]
    case state
    when "absolute_zero"
      values.each do |value|
        #Only removing first $, any others mean value is not in an acceptable numeric state
        num = value.text.sub("$","").gsub(",","")
        is_num(num)
        if num > 0
          puts "Fail - Number is greater than 0"
          return false
        else
          puts "Number is not greater than 0"
        end
      end
    when "currency"
      values.each do |value|
        num = value.text
        #is_num will check first if there are any non currency or numerical values
        is_num(num.sub("$","").gsub(",",""))
        if !(num.start_with?("$"))
          puts "Fail - #{value} does not begin with a $, value listed is #{num}"
          return false
        end
        if num( num.length - 3) != "."
          puts "Fail - #{value} requires a decimal point with two numbers after it, value listed is #{num}"
          return false
        end
        comma_check_string = num( 1, num.length - 4 )
        expected_comma_count = ( comma_check_string.length/3 ) - 1
        actual_comma_count = comma_check_string.count(',')
        if expected_comma_count == actual_comma_count
          for comma_loc in 1..expected_comma_count
            if comma_check_string(comma_check_string.length - (comma_loc*4)) != ','
              puts "Fail - A comma is in an incorrect spot."
              return false
            end
          end
        else
          puts "Fail - There are an incorrect amount of commas there should be #{expected_comma_count} however #{actual_comma_count} were found."
          return false
        end
      end
      puts "Value is an accepted currency"
    else
      puts "Fail - Did not receive an accepted input can only receive 'absolute_zero' or 'currency' instead received #{state}."
      return false
    end
    return true
  end

  def verify_balance
      values = [ text_1, text_2, text_3, text_4, text_5 ]
      calculated_total = 0
      expected_total = text_total.text.sub("$","").gsub(",","")
      is_num(expected_total)
      values.each do |value|
        num = value.text.sub("$","").gsub(",","")
        is_num(num)
        calculated_total += num
      end
      if calculated_total == expected_total
        puts "Values correctly add up to total"
        return true
      else
        puts "Fail - values do not add up to total. Expected #{expected_total} received #{calculated_total}"
        return false
      end
  end

end
