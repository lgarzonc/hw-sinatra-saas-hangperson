class HangpersonGame
  
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = '' 
  end
  
  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    
    return result
  end

  def guess(letter)
    # make sure the letter is actually a letter
    if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
    end
    
    # handle different cases
    letter.downcase!
    
    # handle repeated guesses
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    
    #handle case where guess is not a letter
    return false if letter.length != 1
    
    # finally handle check and return true
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    return true
  end
    
    
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end