final float ELEVATION_SCALE = 0.07;
final float CLIMATE_SCALE = 0.007;
final float PRECIPITATION_SCALE = 0.007;
final float SEA_LEVEL = 0.4;
final int GRID_SIZE = 1600;
final int NUM_TIMES = 400;
TileGrid tileGrid;

MapType mapType = MapType.BIOME;

void setup() {
  size(1600, 1600);
  background(0);
  createWorld();
  tileGrid.render(mapType);
}

void draw() {}

void keyPressed() {
  if (key == ' ') {
    createWorld();
  } else {
    switch(mapType) {
    case ELEVATION:
      mapType = MapType.TEMPERATURE;
      break;
    case TEMPERATURE:
      mapType = MapType.PRECIPITATION;
      break;
    case PRECIPITATION:
      mapType = MapType.BIOME;
      break;
    case BIOME:
      mapType = MapType.ELEVATION;
      break;
    }
  }
  
  tileGrid.render(mapType);
}

void mouseClicked() {
  float tileSize = GRID_SIZE / NUM_TIMES;
  int x = floor(((float) mouseX)/tileSize);
  int y = floor(((float) mouseY)/tileSize);
  print("(" + x + ", " + y + "):\n");
  print("\televation:\t\t" + tileGrid.elevations[x][y] + "\n");
  print("\ttemperature:\t" + tileGrid.temperatures[x][y] + "\n");
  print("\tprecipitation:\t" + tileGrid.precipitations[x][y] + "\n");
  print("\tbiome:\t\t\t" + Biome.getBiome(tileGrid.temperatures[x][y], tileGrid.precipitations[x][y]) + "\n");
}

void createWorld() {
  tileGrid = new TileGrid(GRID_SIZE, NUM_TIMES, ELEVATION_SCALE, CLIMATE_SCALE, PRECIPITATION_SCALE, SEA_LEVEL);
}