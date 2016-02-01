//Amanda Esposito                                                                      
//Project 1: Visualiing text data 
//I took Alice in Wonderland Text and displayed the data in two different data visualizations. 

BufferedReader reader; 
final String FILENAME = "Alice.txt"; 

int state; 
final int DRAW_LETTER_STATE = 0; 
final int DRAW_FREQUENCIES_STATE = 1; 

final int LETTERS_IN_ALAPHABET = 26; 
final int ASCCII_OFFSET = 97; 
int[] frequencies = new int[LETTERS_IN_ALAPHABET]; 
color[] pallette = new color[LETTERS_IN_ALAPHABET]; 
PImage letterViz; 

int [] ellipsePositionX = new int [26]; 
int [] ellipsePositionY = new int [26]; 

int maxFrequency = 0; 
int minFrequency = Integer.MAX_VALUE; 
char leastFrequentLetter; 
char mostFrequentLetter; 
String possibleAlice = ""; 
int alice; 

void setup() { 
  for (int i = 0; i < LETTERS_IN_ALAPHABET; i++){ 
    pallette[i] = color(random(255, 255));
  }
  size (1000, 1000); 
  letterViz = createImage(1000, 1000, RGB);
  letterViz.loadPixels();
  state = DRAW_LETTER_STATE;
  prepareFrequencies(); 
  letterViz.updatePixels();
}

void draw() { 
  background(100);
  fill(0);
  if (state == DRAW_LETTER_STATE){
   drawLetterVisualization(); 
    } else { 
  drawFrequenciesGraph(); 
  }
}

void mousePressed() { 
  state = (state + 1) % 2;  
}

void drawFrequenciesGraph() { 
  image(letterViz, 0, 0); 
} 

void drawLetterVisualization() { 
  background(255);
  text("Drawling all the letters.", 10, 20); 
  text( "Max: " + maxFrequency +  " Most Frequent Letter: " + mostFrequentLetter, 10, 40);
  text( "Min: " + minFrequency + " Least Frequent Letter: " + leastFrequentLetter, 10, 60);
  text( "Alice counter: " + alice, 10, 80); 
  for (int i = 0; i < frequencies.length; ++i) { 
    fill(pallette[i]); 
    ellipse(ellipsePositionX[i], ellipsePositionY[i], frequencies[i]/50, frequencies[i]/50); 
    char letter = (char)(i + 97); 
    fill(0); 
    text(letter, ellipsePositionX[i], ellipsePositionY[i]); 
  }
}
void prepareFrequencies() { 
  for (int i = 0; i < LETTERS_IN_ALAPHABET; i++){ 
    frequencies[i] = 0; 
    ellipsePositionX[i] = (int)random(width);
    ellipsePositionY[i] = (int)random(height);
    pallette[i] = color(random(0, 255), random(0, 255), random(0, 255), 150);
  } 
  reader = createReader(FILENAME);
  int pixelPosition = 0;  
  try { 
    int character; 
    while ((character = reader.read()) != -1) { 
        if (!Character.isAlphabetic(character)) {
           if (possibleAlice.compareTo("alice") == 0){
              alice++; 
          }
          possibleAlice = ""; 
       continue; 
        }  
      char letter = (char)Character.toLowerCase(character);  //converts letter to lower case
      possibleAlice += letter; 
      frequencies[letter - ASCCII_OFFSET]++;  // lower case letter - asccii ASCCII_OFFSET 
      for (int i = 0; i < LETTERS_IN_ALAPHABET; i++) { 
        if (possibleAlice.compareTo("alice") == 1){ 
          letterViz.pixels[pixelPosition] = pallette[0];
          pallette[0] = color(0);  
        } else { 
      pallette[i] = color(random(0, 255), random(0, 255), random(0, 255), 150);
      letterViz.pixels[pixelPosition] = pallette[i];
      }  
        } 
      pixelPosition++;  
      if (frequencies[letter - ASCCII_OFFSET] > maxFrequency) { 
        mostFrequentLetter = letter; 
        maxFrequency = frequencies[letter - ASCCII_OFFSET]; 
      }
      if (frequencies[letter - ASCCII_OFFSET] < minFrequency || leastFrequentLetter == letter) { 
        leastFrequentLetter = letter; 
        minFrequency = frequencies[letter - ASCCII_OFFSET]; 
      }
    }
    } catch (IOException e) { 
    println("Could not read data."); 
    e.printStackTrace(); 
  }
  println(frequencies); 
  println( "max: " + maxFrequency +  " Most Frequent Letter: " + mostFrequentLetter);
  println( "min: " + minFrequency + " Least Frequent Letter: " + leastFrequentLetter);
  println( "Alice counter: " + alice);  
} 



