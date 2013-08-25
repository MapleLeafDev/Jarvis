module CommandLineHelper

  def display_results(results)
    temp = ""
    results.each do |x|
      temp += "#{x}<br/>"
    end
    return temp.html_safe
  end
end
