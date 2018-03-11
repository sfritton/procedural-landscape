public class TileGrid {
  public float tileSize;
  private float[][] elevations;
  private float[][] temperatures;
  private float[][] precipitations;
  private float seaLevel;
  
  public TileGrid(float gridSize, int numTiles, float elevationScale, float climateScale, float precipitationScale, float seaLevel) {
    this.tileSize = gridSize/numTiles;
    this.seaLevel = seaLevel;
    
    ArrayList elevationStack = waveStack(elevationScale, 4, new PVector(random(numTiles/2), random(numTiles/2)));
    ArrayList climateStack = waveStack(climateScale, 2, new PVector(random(numTiles/2, numTiles), random(numTiles/2, numTiles)));
    ArrayList precipitationStack = waveStack(precipitationScale, 2, new PVector(random(numTiles, numTiles * 2), random(numTiles, numTiles * 2)));
    
    this.elevations = new float[numTiles][numTiles];
    this.temperatures = new float[numTiles][numTiles];
    this.precipitations = new float[numTiles][numTiles];
    
    float multiplier = 0.75;
    
    for (int i=0; i < numTiles; i++) {
      for (int j=0; j < numTiles; j++) {
        this.elevations[i][j] = stackedValueAt(i, j, elevationStack);
        this.temperatures[i][j] = norm(
            stackedValueAt(i, j, climateStack) - multiplier * (this.elevations[i][j] - 0.5),
            multiplier * -0.5, 
            1 + multiplier * 0.5
        );
        this.precipitations[i][j] = stackedValueAt(i, j, precipitationStack);
      }
    }
  }
  
  public void render(MapType mapType) {
    noStroke();
    for (int i=0; i < this.elevations.length; i++) {
      for (int j=0; j < this.elevations[i].length; j++) {
        if (this.elevations[i][j] < seaLevel) {
          renderWater(i, j);
        } else {
          switch (mapType) {
            case ELEVATION:
              renderElevation(i, j);
              break;
            case TEMPERATURE:
              renderTemperature(i, j);
              break;
            case PRECIPITATION:
              renderPrecipitation(i, j);
              break;
            case BIOME:
              renderBiome(i, j);
              break;
          }
        }
      }
    }
  }
  
  private void renderElevation(int i, int j) {
    fill(step(15, this.elevations[i][j]));
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }
  
  private void renderTemperature(int i, int j) {
    fill(step(15, this.temperatures[i][j], TEMPERATURE_COLORS));
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }
  
  private void renderPrecipitation(int i, int j) {
    fill(step(15, this.precipitations[i][j], PRECIPITATION_COLORS));
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }
  
  private void renderBiome(int i, int j) {
    Biome biome = Biome.getBiome(temperatures[i][j], precipitations[i][j]);
    fill(biome.displayColor.x, biome.displayColor.y, biome.displayColor.z);
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }
  
  private void renderWater(int i, int j) {
    fill(WATER);
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }

}