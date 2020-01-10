/* Forståelsesopgaver
 1. Hvad er forskellen på de tre programmer?
 I Flue1 bevæger fluerne sig ikke, i Flue2 bevæger kun en af flugerne sig ad gangen, og i Flue3 bevæger de sig alle sammen på samme tid
 2. Start Flue1: Tryk fire gange på skærmen, hvor mange objekter tegnes nu hvert frame og hvorfor?
 Der bliver kun tegnet én flue per frame, da der kun er et objekt der hedder "f", og det er den der bliver tegnet i void draw.
 3. Start Flue2move: Tryk fire gange på skærmen, hvor mange objekter bevæges nu hvert frame og hvorfor?
 Der er kun én flue der bevæger sig, da der, ligesom i spørgsmål 2, kun findes et objekt ved navn "f", og derfor er der kun et objekt der bliver flyttet med f.flyt() i draw
 4. Hvis du fjerner pushMatrix og popMatrix i de tre programmer, har det så nogen betydning og hvorfor?
 Flue1 = nej da de nye objecters position, rotation osv ikke opdateres efter den nye bliver skabt med nye værdier for de førnævnte variabler
 Flue2 = nej med samme begrundelse som i Flue1
 Flue3 = ja, da den bruger funktionen rotate for hver enkel objekt, så hvis de ikke var der ville de have den samme rotation hele tiden
 5. I Flue3moveAll bruges ArrayList. Nævn nogle vigtige forskelle på ArrayList og almindelige arrays?
 ArrayLists har ikke en fast 'capacitet' - du kan proppe så mange ting i den som muligt
 ArrayLists kan kun indeholde objecter, ikke ints, floats osv
 */
ArrayList<Flue> flueListe = new ArrayList<Flue>(); //Arraylist med alle fluerne


void setup() {
  size(500, 500);
}

void draw() {
  for (int i=0; i<flueListe.size(); i++) { //Tegner, flytter og assigner en størrelse til alle fluerne i arraylisten
    Flue f = flueListe.get(i);
    f.tegnFlue();
    f.flyt();
    f.flueSize();
  }
  if (keyPressed) { //laver store fluer når der bliver trykket på tasten 'e'
    if (key == 'e' || key == 'E') {
      flueListe.add(new Flue(width/2, height/2, 9));
    }
  }
}

void mousePressed() { //laver en flue hvis man trykker på skærmen
  flueListe.add(new Flue(mouseX, mouseY, random(1, 5)));
}

/////////////////////////////////////////////////////////
class Flue {

  float positionX, positionY;
  float distanceFlyttet;
  float vinkel = 0; 
  float bigness;
  float speed = 0.5;

  Flue() { //assigner en tilfældig vinkel
    vinkel     = random(0, 2*PI);
  }

  Flue(float a, float b, float c) { //tager de floats man giver fluen og assigner dem til fluen
    positionX = a;
    positionY = b;
    vinkel    = random(0, 2*PI);
    bigness = c;
  }

  void flyt() {//flytter fluen og tjekker om den er nået kanten
    if (positionX + (distanceFlyttet * bigness) * cos(vinkel) > width || positionX - (distanceFlyttet * bigness) * cos(PI - vinkel) < 0 || positionY + (distanceFlyttet * bigness) * sin(PI - vinkel) > height || positionY - (distanceFlyttet * bigness) * sin(2 * PI- vinkel) < 0) {
      vinkel = vinkel + PI;
      speed = -speed;
      println("yoink");
    } else {
          distanceFlyttet = distanceFlyttet + speed;

    }
  }

  void flueSize() { //Assigner en random scale-værdi
    if (bigness == 0) {
      bigness = random(1, 5);
    }
  }

  void tegnFlue() {//Her tegnes og flyttes alle dele af fluen
    pushMatrix();
    translate(positionX, positionY);
    rotate(vinkel);
    scale(bigness);
    translate(distanceFlyttet, 0);
    ellipse(0, 0, 20, 8);
    ellipse(0, 0-8, 15, 10);
    ellipse(0, 0+8, 15, 10);
    ellipse(0+6, 0, 8, 8);
    popMatrix();
  }
}
//////////////////////////////////////////////////////
