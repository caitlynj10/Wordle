import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;


class WordleGame{

static ArrayList<String> wordList = new ArrayList<>();
static String wordToGuess;
static boolean gameOver = false;
static boolean wonGame = false;

static void setRandomWord(){
    try (Scanner fileScan = new Scanner(new File("words.txt"))) {
        while(fileScan.hasNext()){
            wordList.add(fileScan.next());
        }
        int numWords = wordList.size();
        Random rand = new Random();
        int wordNum = rand.nextInt(numWords);
        wordToGuess = wordList.get(wordNum).toLowerCase();
        fileScan.close();
    }catch(FileNotFoundException e){
        System.out.println("File is not found!");
    }
   
}

public static String getRandomWord(){
    return wordToGuess;
}

public String checkWord(String s){
    s.toLowerCase();
    String wordAfterGuess = "";
    for(int i = 0; i<s.length(); i++){
        Character c = s.charAt(i);
        wordAfterGuess += checkLetter(c, i);
    }
    return wordAfterGuess;
}

public Character checkLetter(Character c, int ind){
    Character afterCheck = ' ';
    if(wordToGuess.indexOf(c) != -1){ //wordToGuess contains the letter
        if(wordToGuess.charAt(ind) == c){ //the character at the specified index is the correct letter
            afterCheck = Character.toUpperCase(c);
        }
        else if(wordToGuess.lastIndexOf(c) != wordToGuess.indexOf(c)){
            afterCheck = '-';

        }
        else{
            afterCheck = Character.toLowerCase(c);
        }

    }
    else{
        afterCheck = '-';
    }


    return afterCheck;
}



public boolean checkValidWord(String s){
    if(s.length() != 5 || !wordList.contains(s)){
        return false;
    }

    return true;
}

public void playGame(){
    setRandomWord();
    Scanner scan = new Scanner(System.in);
    System.out.println("What is your first guessed word");
    int guesses = 0;
    int guessesLeft = 6;
    while(gameOver == false){
        String guess = scan.next();
        if(!checkValidWord(guess)){
            System.out.println("This word is invalid. Guess a new word.");
        }
        else{
            guesses++;
            String word = checkWord(guess);
            System.out.println(word);
            if(word.equalsIgnoreCase(wordToGuess)){
                gameOver = true;
                wonGame = true;
            }
            else{
                guessesLeft--;
                if(guessesLeft == 0){
                    gameOver = true;
                }
                System.out.println("You have " + guessesLeft + " guesses left");
            }
        }
        

    }

    if(wonGame == true){
        System.out.println("Congrats! You guessed the correct word in " + guesses + " guesses.");
    }
    else{
        System.out.println("You are out of guesses. The word was " + wordToGuess.toUpperCase());
    }
       
    scan.close();


}

public static void main(String[] args){
    WordleGame game = new WordleGame();
    game.playGame();



}

}

