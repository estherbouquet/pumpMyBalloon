import processing.video.*;
import processing.serial.*;    // Importing the serial library to communicate with the Arduino 
Serial myPort;      // Initializing a vairable named 'myPort' for serial communication
float sensorValue ;   // Variable for changing the background color
float inflation; //how big the balloon is currently
Movie myMovie;
boolean explode;

void setup ( ) {
  fullScreen();
  //size (500, 500);     // Size of the serial window, you can increase or decrease as you want
  myPort  =  new Serial (this, "COM7", 9600); // Set the com port and the baud rate according to the Arduino IDE
  myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE
  myMovie = new Movie(this, "explosion.mp4");
  explode = false;
} 

void serialEvent  (Serial myPort) {
  sensorValue  =  float (myPort.readStringUntil ( '\n' ) ) ;  // Changing the background color according to received data
} 

void draw ( ) {
  background (0);   // Initial background color, when we will open the serial window
  //fill(150,50,background_color/4);
  //noStroke();
  if (sensorValue > 0) {
    inflation+=1/(inflation+1) * 100 + 15;
  } 
  if (inflation > 0) {
    inflation = inflation -  0.5;
  }
  fill(255);
  ellipse(width/2, height/2, 10+inflation, min(10+inflation, height));
  if (inflation > width) {
    explode = true;
  }

  if (explode == true) {
    myMovie.play();
    image(myMovie, 0, 0, width, height);
  }
}

void movieEvent(Movie m) {
  m.read();
}

