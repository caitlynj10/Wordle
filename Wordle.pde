WordleGame engine;

int GUESSES = 0;
int cellSize = 80;
String GUESS = "";
String hiddenWord;
boolean gameEnded = false;
boolean gameWon = false;
ArrayList<String> savedGuesses = new ArrayList<String>();
ArrayList<String> savedResults = new ArrayList<String>();


void setup(){
    size(400,480);
    engine = new WordleGame();
    String allWords = sketchPath("words.txt");
    engine.setRandomWord(allWords);
    hiddenWord = engine.getRandomWord();
    System.out.println(hiddenWord);
    

}

void draw(){
    background(41);
    drawGrid();
    drawLetters();
    colorGuess();
    endGame(); 
}

void drawGrid(){
    strokeWeight(10);
    stroke(173);
    line(0, 0, 400, 0);
    line(0, 0, 0, 480);
    line(0, 480, 400, 480);
    line(400, 0, 400, 480);
    strokeWeight(2);
    for(int i = 1; i<6; i++){
        line(i*cellSize, 0, i*cellSize, 480);
    }
    for(int i = 1; i<7; i++){
        line(0, cellSize*i, 400, i*cellSize);
    }
}

void drawLetters(){
    if(!gameWon && !gameEnded){
        textAlign(CENTER, CENTER);
        textSize(30);
        fill(255);
        
        for(int i = 0; i<GUESS.length(); i++){
            char c = GUESS.charAt(i);
            text(Character.toUpperCase(c), i*cellSize + cellSize/2, GUESSES*cellSize + cellSize/2);
            stroke(255);
            strokeWeight(4);
            noFill();
            rect(i*cellSize, GUESSES*cellSize, cellSize, cellSize);
        }

        strokeWeight(1);
    }
    
}

void endGame(){
    if(gameEnded == true){
        fill(255, 43, 43);
        rect(50, 140, 300, 200);
        fill(0);
        stroke(0);
        text(hiddenWord.toUpperCase(), 200, 240);
        
    }
    if(gameWon == true){
        fill(0, 217, 5);
        rect(50, 140, 300, 200);
        fill(0);
        stroke(0);
        if(GUESSES == 1){
            text("Great! " + GUESSES + " guess!", 200, 240);
        }
        else{
            text("Great! " + GUESSES + " guesses!", 200, 240);

        }
    }
}

void colorGuess(){
    for(int i = 0; i < savedGuesses.size(); i++){
        String guess = savedGuesses.get(i);
        String result = savedResults.get(i);

        for(int j = 0; j< guess.length(); j++){
            Character g = guess.charAt(j);
            Character r = result.charAt(j);
            if(Character.isUpperCase(r)){
                fill(17, 173, 63);
            }
            else if(Character.isLowerCase(r)){
                fill(255, 221, 54);
            }
            else{

                fill(41);

            }
            strokeWeight(2);
            rect(j*cellSize, i*cellSize, cellSize, cellSize);
            fill(255);
            text(Character.toUpperCase(g), j*cellSize + cellSize/2, i*cellSize + cellSize/2);
        }
    }
        
   
}

void keyPressed(){
    if((key == BACKSPACE || key == DELETE)){
        if(GUESS.length() > 0){
            GUESS = GUESS.substring(0, GUESS.length() - 1);
        }
    }
    else if((key == ENTER || key == RETURN) && GUESS.length() == 5){
        if(engine.checkValidWord(GUESS)){
            savedGuesses.add(GUESS);
            if(GUESS.equalsIgnoreCase(hiddenWord)){
                gameWon = true;
            }
            savedResults.add(engine.checkWord(GUESS));
            GUESS = "";
            GUESSES++;
            if(GUESSES == 6){
                gameEnded = true;
            }
        }
    }
    else if(Character.isLetter(key)){
        GUESS += key;

    }       
}


