#little project for python programming

import random
import time
import string


def get_key_word():
    '''get random word from word list'''
    word_list = []  
    with open('words.txt') as file:
        line = str(file.readlines())
        word_list.extend(line.split())
        #print(line.split())
    key_word = random.choice(word_list)  
    key_word = str.upper(key_word)
    return(key_word)


def get_guess_word():
    '''input and test the letter'''
    while True:
        guess_word = input('guess(one letter)：')  
        guess_word = guess_word.strip()
        if guess_word and guess_word in string.ascii_letters and len(guess_word) == 1:
            guess_word = str.upper(guess_word)
            return guess_word
        else:
            print('input is invalid, please type again：')
            continue


def print_hangman(key_word, guess_answer, guess_mistakes):
    '''print hangman : from 0 (hang) to 6 (hanged)'''
    lines = LINES.split('\n')  
    start = guess_mistakes * LINEPERIMAGE
    if guess_mistakes == 6:
        answer_tempt = 'YOU LOSE!'
    elif key_word == guess_answer:
        answer_tempt = 'YOU WIN!'
    else:
        answer_tempt = ' '.join(list(guess_answer)) 
    answer_lines = [' ', ' ', ' ', ' ', answer_tempt, ' ', ' ', ' ', ' ']  
    for i in range(start, start + LINEPERIMAGE):
        print('{:^30}{:<}'.format(answer_lines[i-start], lines[i]))  


def get_exit_flag():
    '''decide exit flag'''
    while True:
        yes_or_no = input('Continue or Quit game?(Cc/Qq)：')  #
        yes_or_no = yes_or_no.strip()
        yes_or_no = str.upper(yes_or_no)
        if yes_or_no == 'C':
            return False
        elif yes_or_no == 'Q':
            return True
        else:
            print('input is invalid, please input again：')
            continue


if __name__ == '__main__':
    '''main function, draw picture'''
    LINEPERIMAGE = 9  # Every LINEPERIMAGE is a perfect picture of hangman
    LINES = '''     ______
    |  |
    |  
    | 
    |  
    |  
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | 
    |  
    | 
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | /
    |  
    | 
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | /|
    |  |
    |  
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | /|\ 
    |  |
    |  
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | /|\ 
    |  |
    | /  
    |_____
    |     |____
    |__________|
     ______
    |  |
    |  O
    | /|\ 
    |  |
    | / \ 
    |_____
    |     |____
    |__________|

    '''

    exit_flag = False  
    while not exit_flag:  

        start_time = time.time()  
        key = get_key_word()  
        temp_key = list(key) 
        answer = '_'*len(key)  
        history = list()  
        mistakes = 0  
        '''guess times'''
        while mistakes < 6 and answer != key:  
            guess = get_guess_word()  
            if guess in answer:
                print('the letter has been guessed, please try again：')
                continue
            history.append(guess)  
            if guess in key:
                print('mistakes : %d' % mistakes)
                start = 0
                while key.find(guess, start) != -1:
                    temp_answer = list(answer)
                    temp_answer[key.find(guess, start)] = temp_key[key.find(guess, start)]
                    answer = ''.join(temp_answer)
                    start = key.find(guess, start)+1
                print_hangman(key, answer, mistakes)
                continue
            else:  
                mistakes += 1
                print('mistakes : %d' % mistakes)
                print_hangman(key, answer, mistakes)
        end_time = time.time()  
        time_used = end_time-start_time  
        print(time_used)
        ''' display outcome'''
        if mistakes < 6:
            print(
                'The secret word is %s, you guess via sequence %s. And YOU WIN!\n' % (key, ''.join(history)))
        elif mistakes == 6:
            print(
                'The secret word is %s, you guess via sequence %s. And YOU LOSE!\n' % (key, ''.join(history)))
        
        exit_flag = get_exit_flag()

        

