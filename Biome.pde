// Loosely based on the Koppen climate classification
private static final float LOW_MIN = 0;
private static final float LOW_MAX = 0.33;

private static final float MID_MIN = LOW_MAX;
private static final float MID_MAX = 0.66;

private static final float HIGH_MIN = MID_MAX;
private static final float HIGH_MAX = 1;

public enum Biome {
  TUNDRA(LOW_MAX, LOW_MIN, LOW_MAX, LOW_MIN, new PVector(205, 204, 241)),      // low  temp, low  precip
  MOUNTAIN(LOW_MAX, LOW_MIN, MID_MAX, MID_MIN, new PVector(109, 101, 178)),    // low  temp, mid  precip
  SNOWY(LOW_MAX, LOW_MIN, HIGH_MAX, HIGH_MIN, new PVector(212, 255, 255)),     // low  temp, high precip
  
  ROCKY(MID_MAX, MID_MIN, LOW_MAX, LOW_MIN, new PVector(85, 105, 115)),        // mid  temp, low  precip
  TEMPERATE(MID_MAX, MID_MIN, MID_MAX, MID_MIN, new PVector(18, 99, 65)),      // mid  temp, mid  precip
  MARSH(MID_MAX, MID_MIN, HIGH_MAX, HIGH_MIN, new PVector(168, 221, 117)),     // mid  temp, high precip
  
  DESERT(HIGH_MAX, HIGH_MIN, LOW_MAX, LOW_MIN, new PVector(227, 179, 101)),    // high temp, low  precip
  PRAIRIE(HIGH_MAX, HIGH_MIN, MID_MAX, MID_MIN, new PVector(72, 163, 47)),     // high temp, mid  precip
  RAINFOREST(HIGH_MAX, HIGH_MIN, HIGH_MAX, HIGH_MIN, new PVector(227, 61, 0)); // high temp, high precip
  
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
    if (temp < LOW_MAX) {
      if (precip < LOW_MAX) {
        return TUNDRA;
      }
     
      if (precip < MID_MAX) {
        return MOUNTAIN;
      }
      
      return SNOWY;
    }
    
    if (temp < MID_MAX) {
      if (precip < LOW_MAX) {
        return ROCKY;
      }
     
      if (precip < MID_MAX) {
        return TEMPERATE;
      }
      
      return MARSH;
    }
    
    if (precip < LOW_MAX) {
      return DESERT;
    }
   
    if (precip < MID_MAX) {
      return PRAIRIE;
    }
    
    return RAINFOREST;
  }
  
  public static Biome getBiome(int i) {
    switch(i) {
      case 0:
        return TUNDRA;
      case 1:
        return MOUNTAIN;
      case 2:
        return SNOWY;
      case 3:
        return ROCKY;
      case 4:
        return TEMPERATE;
      case 5:
        return MARSH;
      case 6:
        return DESERT;
      case 7:
        return PRAIRIE;
      case 8:
        return RAINFOREST;
      default:
        return null;
    }
  }
}