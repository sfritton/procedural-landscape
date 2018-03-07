public class TileGrid {
  private static final float WATER_LEVEL = .4;
  public float tileSize;
  private float[][] elevations;
  private float[][] climate;
  
  public TileGrid(float gridSize, int numTiles, float scale, float climateScale) {
    this.tileSize = gridSize/numTiles;
    PVector forestSeed = new PVector(random(numTiles, numTiles * 2), random(numTiles, numTiles * 2));
    
    ArrayList elevationStack = new ArrayList<PerlinWave>();
    elevationStack.add(new PerlinWave(scale, 1, random(1), random(1)));
    elevationStack.add(new PerlinWave(scale/2, 2, random(1,2), random(1,2)));
    elevationStack.add(new PerlinWave(scale/4, 4, random(2,4), random(2,4)));
    
    this.elevations = new float[numTiles][numTiles];
    this.climate = new float[numTiles][numTiles];
    
    for (int i=0; i < numTiles; i++) {
      for (int j=0; j < numTiles; j++) {
        this.elevations[i][j] = stackedValueAt(i, j, elevationStack);
        this.climate[i][j] = noise((forestSeed.x + i) * climateScale, (forestSeed.y + j) * climateScale);
      }
    }
  }
  
  public TileGrid(float gridSize, int numTiles) {
    this(gridSize, numTiles, 1, 0.5);
  }
  
  public TileGrid(float gridSize, int numTiles, float scale) {
    this(gridSize, numTiles, scale, 0.5);
  }
  
  public void render() {
    noStroke();
    for (int i=0; i < this.elevations.length; i++) {
      for (int j=0; j < this.elevations[i].length; j++) {
        renderElevation(i, j);
      }
    }
  }
  
  private void renderElevation(int i, int j) {
    if (this.elevations[i][j] < WATER_LEVEL) {
      fill(WATER);
      rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
    } else {
      fill(step(15, this.elevations[i][j]));
      rect(i * this.tileSize, j * this.tileSize, this.tileSize, this.tileSize);
    }
  }

}