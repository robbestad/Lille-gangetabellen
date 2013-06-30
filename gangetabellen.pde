PFont font;
boolean guessedNumber;
int multiplicationTable, totalTries, randomNumber, sizeX, sizeY, cumul, 
    NumberofTries, elapsedTime, scoreTime, chosenTable, 
    fontSmall, fontMedium, fontLarge,fontXlarge,
    answerTime;
    
int[] resultats = new int[9];
String[] temps = new String[11];
PImage img;
//import processing.opengl.*;

void setup() 
{
  sizeX = 320;//screen.width;
  sizeY = 480;//screen.height;
  size(sizeX, sizeY);
  smooth();
  fontSmall=18;
  fontMedium=24;
  fontLarge=32;
  fontXlarge=48;
  answerTime=0;
 
  //println(font.list());
  //textAlign(CENTER);
  //textFont(font, 24);
  multiplicationTable = 11;
  for (int i = 0; i < 11; i = i+1) {
    temps[i] = "";
  }
  cumul = 0;
  NumberofTries = 0;
} 

void draw()
{ 
  answerTime-=1;
  //img = loadImage("bg_wood.jpg");
  //background(img);
  background(237,255,179);

  if(multiplicationTable == 11) {
    menu();
  } 
  else {
    if(guessedNumber == true) {
      answerTime=2;
      propose();
    } 
    else {
      exo();
    }
  }
}

void menu()
{
  font = createFont("Georgia", fontMedium);
  textFont(font);
  textAlign(CENTER, CENTER);
  //fill(199,255,179);
  fill(103,56,255);
  text("Den lille gangetabellen",sizeX/2,16);
  
  for (int i = 1; i < 11; i++) {
    
    textFont(font,fontMedium);
    
    fill(103,56,255);
    if(mouseY > i*sizeY/12 && mouseY < (i+1)*sizeY/12) {
      chosenTable = i;
    // hover mouse
      //fill(199,255,179);
      fill(149,117,255);
    } else {
    //fill(199,255,179);
    
    }
    
    
    //text(i + temps[i], sizeX/2, (sizeY/12)*(i+0.8)-16);
    text(i+"-gangen", sizeX/2, (sizeY/12)*(i+0.8)-16);
  }
  if (NumberofTries == 0)
  {
    fill(63,5,255);
    textFont(font, fontMedium);
    text("Lykke til!", sizeX/2, (sizeY/12)*11.4);
  } 
  else {
    fill(63,5,255);
    textFont(font, fontMedium);
    text("Lykke til!", sizeX/2, (sizeY/12)*11.4);
    /*
    textFont(font, fontSmall);
    text(cumul/(NumberofTries*20) + "sek pr. forsøk", sizeX/2, (sizeY/12)*11.4);
    */
  }
  
  answerTime=0;
}

void exo()
{
  fill(255,102,51);
  textFont(font, sizeY/14);
  scoreTime = second()+minute()*60+hour()*3600-elapsedTime;
  text(scoreTime/60 + " m & " + max(scoreTime-scoreTime/60*60,0) + " sek", sizeX/2, sizeY/15);
  for (int i = totalTries; i > 0; i = i - 1) {
    ellipse((sizeX/totalTries)*i-sizeX/(totalTries*2),80,sizeY/48,sizeY/48);
  }
  textFont(font, fontXlarge);
  text(randomNumber + "x" + multiplicationTable, sizeX/2, 120);
  textFont(font, fontLarge);
  for (int i = 0; i < 3; i = i + 1) {
    for (int j = 0; j < 3; j = j + 1) {
      if(mouseX > sizeX/5*(i+1) && mouseX < sizeX/5*(i+2) && mouseY > sizeY/5*(j+2) && mouseY < sizeY/5*(j+3)) {
        fill(random(90),255,random(90));
        chosenTable=i+3*j;
      } 
      else {
        fill(10+random(10)+i*2,random(20)+30-i*2,60);
      }
      text(resultats[i+3*j], sizeX/5*(i+1.5), sizeY/5*(j+2.5));
    }
  }
}

void propose()
{
  randomNumber = int(random(11));
  for (int i = 0; i < 9; i = i + 1) {
    resultats[i] = int(random(101));
  }
  resultats[int(random(9))] = min(randomNumber*multiplicationTable+10,100);
  resultats[int(random(9))] = max(randomNumber*multiplicationTable-10,0);
  resultats[int(random(9))] = min(randomNumber*multiplicationTable+5,100);
  resultats[int(random(9))] = max(randomNumber*multiplicationTable-5,0);
  resultats[int(random(9))] = min(randomNumber*multiplicationTable+1,100);
  resultats[int(random(9))] = max(randomNumber*multiplicationTable-1,0);
  resultats[int(random(9))] = min(randomNumber*multiplicationTable+2,100);
  resultats[int(random(9))] = max(randomNumber*multiplicationTable-2,0);
  resultats[int(random(9))] = min((randomNumber+1)*multiplicationTable,100);
  resultats[int(random(9))] = max((randomNumber-1)*multiplicationTable,0);
  for (int i = 0; i < 9; i = i + 1) {
    for (int j = 0; j < 9; j = j + 1) {
      if (resultats[i] == resultats[j]) {
        resultats[i] = int(random(101));
      }
    }
  }
  resultats[int(random(9))] = randomNumber*multiplicationTable;
  
  /*
  if(guessedNumber){
    fill(63,5,255);
    textFont(font, fontMedium);
    text("Riktig!", sizeX/2, 160);
    
  }
  */
  
  if(answerTime==0)guessedNumber = false;
  guessedNumber = false;
  totalTries = totalTries - 1;
  chosenTable = 20;
}

void mousePressed() {
  guessedNumber=false;
  if(multiplicationTable != 11 && chosenTable != 20) {
    if(resultats[chosenTable] == randomNumber*multiplicationTable) {
      if(totalTries == 1) {
        temps[multiplicationTable] = " en " + scoreTime/60 + " m & " + max(scoreTime-scoreTime/60*60,0) + " sek.";
        NumberofTries =  NumberofTries + 1;
        cumul = cumul + scoreTime;
        multiplicationTable = 11;
        chosenTable = 20;
      } 
      else {
        guessedNumber = true;
        
      }
    }
    else {
      totalTries = min(20,totalTries + 1);
    }
  }
  if(multiplicationTable == 11 && chosenTable != 20) {
    totalTries = 10;
    guessedNumber = true;
    multiplicationTable = chosenTable;
    elapsedTime = 1+second()+minute()*60+hour()*3600;
  }
}
