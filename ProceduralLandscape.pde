final float ELEVATION_SCALE = 0.07;
final float CLIMATE_SCALE = 0.007;
final float SEA_LEVEL = 0.45;
TileGrid tileGrid = new TileGrid(1600, 400, ELEVATION_SCALE, CLIMATE_SCALE, SEA_LEVEL);

boolean showClimate = false;

void setup() {
  size(1600, 1600);
  background(0);
  tileGrid.render(showClimate);
}

void draw() {}

void keyPressed() {
  showClimate = !showClimate;
  tileGrid.render(showClimate);
}