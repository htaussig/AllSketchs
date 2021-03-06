int r1, r2, r3, v1, v2, v3, a1, a2, a3;

PImage img;

void setup() {
  size(1500, 1208);
  img = loadImage("../vg.jpg", "png");

  calcularMax();
  pintar();
}

void draw() {
}

void mousePressed() {
  saveFrame("f-#####.png");
}

color calcular(PImage img, int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

void pintar() {
  for (int j = 0; j < img.height; j++) {
    for (int i = 0; i < img.width; i++) {
      color col = calcular(img, i, j);

      int rojo, verde, azul;

      float dis1, dis2, dis3;

      dis1 = dist(r1, 0, hue(col), 0);
      dis2 = dist(r2, 0, hue(col), 0);
      dis3 = dist(r3, 0, hue(col), 0);
      if (dis1 < dis2) {
        if (dis1 < dis3) {
          rojo = r1;
        }
        else {
          rojo = r3;
        }
      }
      else {
        if (dis2 < dis3) {
          rojo = r2;
        }
        else {
          rojo = r3;
        }
      }
      dis1 = dist(v1, 0, saturation(col), 0);
      dis2 = dist(v2, 0, saturation(col), 0);
      dis3 = dist(v3, 0, saturation(col), 0);
      if (dis1 < dis2) {
        if (dis1 < dis3) {
          verde = v1;
        }
        else {
          verde = v3;
        }
      }
      else {
        if (dis2 < dis3) {
          verde = v2;
        }
        else {
          verde = v3;
        }
      }
      dis1 = dist(a1, 0, brightness(col), 0);
      dis2 = dist(a2, 0, brightness(col), 0);
      dis3 = dist(a3, 0, brightness(col), 0);
      if (dis1 < dis2) {
        if (dis1 < dis3) {
          azul = a1;
        }
        else {
          azul = a3;
        }
      }
      else {
        if (dis2 < dis3) {
          azul = a2;
        }
        else {
          azul = a3;
        }
      }
      set(i, j, color(rojo, verde, azul));
    }
  }
}

void calcularMax() {
  int[] rojos, verdes, azules;
  rojos = new int[256];
  verdes = new int[256];
  azules = new int[256];
  for (int j = 0; j < img.height; j++) {
    for (int i = 0; i < img.width; i++) {
      color aux = calcular(img, i, j);
      rojos[int(hue(aux))]++;
      verdes[int(saturation(aux))]++;
      azules[int(brightness(aux))]++;
    }
  }
  int mr1 = 0, mr2 = 0, mr3 = 0;
  int mv1 = 0, mv2 = 0, mv3 = 0;
  int ma1 = 0, ma2 = 0, ma3 = 0;
  for (int i = 0; i < 256; i++) {
    //rojo
    if (rojos[i] > mr1) {
      mr3 = mr2;
      r3 = r2;
      mr2 = mr2;
      r2 = r1;
      mr1 = rojos[i];
      r1 = i;
    }
    else if ( rojos[i] > mr2) {
      mr3 = mr2;
      r3 = r2;
      mr2 = rojos[i];
      r2 = i;
    }
    else if (rojos[i] > mr3) {
      mr3 = rojos[i];
      r3 = i;
    }
    //verde
    if (verdes[i] > mv1) {
      mv3 = mv2;
      v3 = v2;
      mv2 = mv2;
      v2 = v1;
      mv1 = verdes[i];
      v1 = i;
    }
    else if ( verdes[i] > mv2) {
      mv3 = mv2;
      v3 = v2;
      mv2 = verdes[i];
      v2 = i;
    }
    else if (verdes[i] > mv3) {
      mv3 = verdes[i];
      v3 = i;
    }
    //azul
    if (azules[i] > ma1) {
      ma3 = ma2;
      a3 = a2;
      ma2 = ma2;
      a2 = a1;
      ma1 = azules[i];
      a1 = i;
    }
    else if ( azules[i] > ma2) {
      ma3 = ma2;
      a3 = a2;
      ma2 = azules[i];
      a2 = i;
    }
    else if (azules[i] > ma3) {
      ma3 = azules[i];
      a3 = i;
    }
  }
}

