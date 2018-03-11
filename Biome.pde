// Loosely based on the Koppen climate classification

public enum Biome {
  ARID(1, 0.55, 0.5, 0, new PVector(227, 179, 101)), // high temp, low precip
  CONTINENTAL(0.5, 0, 1, 0.55, new PVector(18, 99, 65)), // low temp, high precip
  TEMPERATE(1, 0, 1, 0, new PVector(72, 163, 47)), // moderate
  TROPICAL(1, 0.55, 1, 0.55, new PVector(227, 61, 0)), // high temp, high precip
  TUNDRA(0.44, 0, 0.44, 0, new PVector(127, 205, 245)); // low temp, low precip
  
  public PVector displayColor;
  private float maxTemp;
  private float minTemp;
  private float maxPrecip;
  private float minPrecip;
  
  private Biome(float maxTemp, float minTemp, float maxPrecip, float minPrecip, PVector displayColor) {
    this.maxTemp = maxTemp;
    this.minTemp = minTemp;
    this.maxPrecip = maxPrecip;
    this.minPrecip = minPrecip;
    this.displayColor = displayColor;
  }
  
  public static Biome getBiome(float temp, float precip) {
    if (temp < TUNDRA.maxTemp && precip < TUNDRA.maxPrecip) {
      return TUNDRA;
    }
    
    if (temp > TROPICAL.minTemp && precip > TROPICAL.minPrecip) {
      return TROPICAL;
    }
    
    if (temp < CONTINENTAL.maxTemp && precip > CONTINENTAL.minPrecip) {
      return CONTINENTAL;
    }
    
    if (temp > ARID.minTemp && precip < ARID.maxPrecip) {
      return ARID;
    }
    
    return TEMPERATE;
  }
}