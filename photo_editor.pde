// Imagenes a cargar como menu
PImage cargar;
PImage guardar;
PImage editar;
PImage barra;

// Array de imagenes a editar
PImage[] imagenEdit = new PImage[5];

// Numero de imagen actual en el array
int numImagen = 0;

// Variables que indican cual parametro se esta utilizando
boolean hue = false;    // Tono
boolean sat = false;    // Saturacion
boolean bright = false; // Brillo
boolean ball = false;   // Circulo del slider

// Coordenadas del slider
float y;
float easing = 0.85; // Que tan rapido se mueve el circulo

// Valores de los parametros editables de la imagen
float tono = 128;
float saturacion = 0;
float brillo = 255;

void setup() {
  size(550, 900);
  colorMode(HSB);
  noStroke();

  // Se cargan las imagenes de menu
  cargar = loadImage("cargar.png"); 
  guardar = loadImage("guardar.png");
  editar = loadImage("editar.png");
  barra = loadImage("barra.png");

  // Se cargan las imagenes del array
  imagenEdit[0] = loadImage("imagen_0.jpg");
  imagenEdit[1] = loadImage("imagen_1.jpg");
  imagenEdit[2] = loadImage("imagen_2.jpg");
  imagenEdit[3] = loadImage("imagen_3.jpg");
  imagenEdit[4] = loadImage("imagen_4.jpg");

  image(imagenEdit[numImagen], 0, 0, 550, 900);

  image(cargar, 28, 814, 58, 58);
  image(guardar, 464, 814, 58, 58);
  image(editar, 156, 814, 238, 58);

  y = 450;
}


void draw() {
  tint(tono, saturacion, brillo);
  image(imagenEdit[numImagen], 0, 0, 550, 900);

  if (hue || sat || bright) {
    // La barra del slider aparece solo cuando se selecciona alguno de los parametros a editar
    image(barra, 28, 175, 58, 550);

    if (hue) {
      y = (255 - tono)*490/255 + 205;
    }

    if (sat) {
      y = (255 - saturacion)*490/255 + 205;
    }

    if (bright) {
      y = (255 - brillo)*490/255 + 205;
    }

    if (ball) {
      float dy = mouseY - y;
      y += dy * easing;
    }

    // Mantiene slider en el extremo superior
    if (205 > y) {
      y = 205;
    }

    // Mantiene el slider en el extremo inferior
    if (y > 695) {
      y = 695;
    }

    float value = 255 - (y - 205) / 490 * 255;

    if (hue) {
      tono = value;
    }

    if (sat) {
      saturacion = value;
    }

    if (bright) {
      brillo = value;
    }

    rect(55, y, 4, 695 - y);
    ellipse(57, y, 15, 15);
  }

  noTint();
  image(cargar, 28, 814, 58, 58);
  image(guardar, 464, 814, 58, 58);
  image(editar, 156, 814, 238, 58);
  
  if (hue) {
    stroke(255);
    strokeWeight(2);
    line(170, 865, 206, 865);
  }

  if (sat) {
    stroke(255);
    strokeWeight(2);
    line(257, 865, 293, 865);
  }

  if (bright) {
    stroke(255);
    strokeWeight(2);
    line(344, 865, 380, 865);
  }
}


void mouseClicked() {
  // Guardar screenshot
  if (mouseX > 464 && mouseX < 522 && mouseY > 814 && mouseY < 872) {
    saveFrame("tarea2-##.jpg");
  }

  // Click en boton para cargar nueva imagen
  if (mouseX > 28 && mouseX < 86 && mouseY > 814 && mouseY < 872) {
    numImagen++;
    // Se resetean los parametros a editar
    hue = false;
    sat = false;
    bright = false;
    tono = 128;
    saturacion = 0;
    brillo = 255;

    if (numImagen > 4) {
      numImagen = 0;
    }
  }

  // Click en boton Hue
  if (mouseX > 156 && mouseX < 219 && mouseY > 814 && mouseY < 872) {
    hue = !hue;
    bright = false;
    sat = false;
  }

  // Click en boton Saturacion
  if (mouseX > 243 && mouseX < 307 && mouseY > 814 && mouseY < 872) {
    sat = !sat;
    hue = false;
    bright = false;
  }

  // Click en boton Brillo
  if (mouseX > 330 && mouseX < 394 && mouseY > 814 && mouseY < 872) {
    bright = !bright;
    hue = false;
    sat = false;
  }

  // El slider se mueve solo cuando se da click dentro de la barra
  if (175 < mouseY && mouseY < 725) {
    if (mouseX > 28 && mouseX < 86) {
      ball = !ball;
    } else {
      ball = false;
    }
  }
}
