public class TileGrid {
  public float tileSize;
  private float[][] elevations;
  private float[][] temperatures;
  private float seaLevel;
  
  public TileGrid(float gridSize, int numTiles, float elevationScale, float climateScale, float seaLevel) {
    this.tileSize = gridSize/numTiles;
    this.seaLevel = seaLevel;
    
    ArrayList elevationStack = waveStack(elevationScale, 4);
    ArrayList climateStack = waveStack(climateScale, 2);
    
    this.elevations = new float[numTiles][numTiles];
    this.temperatures = new float[numTiles][numTiles];
    
    float multiplier = 0.75;
    
    for (int i=0; i < numTiles; i++) {
      for (int j=0; j < numTiles; j++) {
        this.elevations[i][j] = stackedValueAt(i, j, elevationStack);
        this.temperatures[i][j] = norm(
            stackedValueAt(i, j, climateStack) - multiplier * (this.elevations[i][j] - 0.5),
            multiplier * -0.5, 
            1 + multiplier * 0.5
        );
      }
    }
  }
  
  public void render(boolean climate) {
    noStroke();
    for (int i=0; i < this.elevations.length; i++) {
      for (int j=0; j < this.elevations[i].length; j++) {
        if (this.elevations[i][j] < seaLevel) {
          renderWater(i, j);
        } else {
          if (climate)
            renderTemperature(i, j);
          else
            renderElevation(i, j);
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
  
  private void renderWater(int i, int j) {
    fill(WATER);
    rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
  }

}