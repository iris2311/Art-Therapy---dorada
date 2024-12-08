import javax.swing.JOptionPane;
import processing.pdf.*;

PImage cropImg;
PImage ikona;
PImage img;
PImage borderedImg;
PImage decorImg;
PImage olovka;
PImage pozadina;
PImage gumica;
PImage disketa;
PImage printer;
PImage ploca;
PGraphics pg;
int olovkaSize = 50;          // Veličina olovke
float olovkaX, olovkaY;       // Trenutni položaj olovke
int fillColor = color(255,255,255);   // Defaultna boja za bojanje
int numColors;
int colorWidth;               // Širina svakog kvadrata boje
int colorHeight;              // Visina svakog kvadrata boje
int padding;                  // Prostor između svakog kvadrata boje
int startX;                   // Početna x-koordinata trake s bojama
int startY;                   // Početna y-koordinata trake s bojama
int numberInRow;              // Broj boja u traci
String selectedImage;         // Odabrana slika u opcijama
boolean initialized = false;  // Inicijalizirana početna bojanka
boolean enabled = true;       // Omogućen rad s bojankom


ArrayList<PImage> undoList = new ArrayList<>();
ArrayList<PImage> redoList = new ArrayList<>();


//DODANO: za undo gumb
void spremiUndo() {
    PImage snapshot = borderedImg.copy(); // kopira trenutno stanje slike
    undoList.add(snapshot); // dodaje kopiju na kraj Undo liste
    redoList.clear(); // čisti Redo listu
}


void setup() {
  size(800, 800);
  ikona = loadImage("ikonica1.png");

  surface.setIcon(ikona);
  
  Resetiraj();
}


void draw() {
  
  if(enabled == true){
    // Ažuriranje slike koju bojamo.
    azuriraj();
  
    // Ažuriraj položaj olovke na trenutni položaj miša.
    olovkaX = mouseX;
    olovkaY = mouseY;

    // Ako je miš unutar slike za bojanje, prikaži sliku olovke na trenutnom položaju miša.
    // Inače prikaži cursor miša.
    if(olovkaX <= 600 && olovkaY <= 544) {
      image(olovka, olovkaX - olovkaSize/2 +10 , olovkaY -olovkaSize/2-15 , olovkaSize, olovkaSize);
      noCursor();
    } else {
      cursor();
    }  

    // Iscrtavanje kvadrata s trenutno odabranom bojom.
    fill(fillColor);
    noStroke();
  
    rect(borderedImg.width - colorWidth * 2.5 , startY, colorWidth * 2, colorHeight * 2 + padding);
  }
  /*
  // Ažuriranje slike koju bojamo.
  azuriraj();
  
  // Ažuriraj položaj olovke na trenutni položaj miša.
  olovkaX = mouseX;
  olovkaY = mouseY;

  // Ako je miš unutar slike za bojanje, prikaži sliku olovke na trenutnom položaju miša.
  // Inače prikaži cursor miša.
  if(olovkaX <= 600 && olovkaY <= 544) {
    image(olovka, olovkaX - olovkaSize/2 +10 , olovkaY -olovkaSize/2-15 , olovkaSize, olovkaSize);
    noCursor();
  } else {
    cursor();
  }

  // Iscrtavanje kvadrata s trenutno odabranom bojom.
  fill(fillColor);
  noStroke();
  
  rect(borderedImg.width - colorWidth * 2.5 , startY, colorWidth * 2, colorHeight * 2 + padding);
  */
  
  
// DODANO: gumb za biranje vlastite boje
fill(fillColor); // popuni gumb trenutno odabranom bojom
stroke(0); // crni obrub
strokeWeight(2);
rect(width - 120, 700, 100, 50, 10); // gumb (dimenzije: 100x50, zaobljeni rubovi)

// tekst unutar gumba
fill(0);
textSize(12); 
textAlign(CENTER, CENTER); // centriraj tekst u gumba
text("Odaberi boju", width - 120 + 50, 700 + 25); // centrirano u gumbu

// DODANO: gumb za Undo
fill(200); 
rect(20, height - 70, 50, 50, 10); //pozicija: (20, 730), dimenzije: 50x50
fill(0); 
textAlign(CENTER, CENTER);
text("Undo", 45, height - 45); // tekst centriran unutar gumba

// DODANO: gumb za Redo
fill(200); 
rect(80, height - 70, 50, 50, 10); // pozicija: (80, 730), dimenzije: 50x50
fill(0); 
textAlign(CENTER, CENTER);
text("Redo", 105, height - 45); // tekst centriran unutar gumba



}


 
