public final int FONT_SIZE = 20;

public abstract class MapLegend {
  public abstract void render();
}

public class GradientLegend extends MapLegend {
  private color[] colors;
  private String title;
  
  public GradientLegend(color[] colors, String title) {
    this.colors = colors;
    this.title = title;
  }
  
  public void render() {
    float offset = 40;
    float titleOffset = 40;
    PVector dimensions = new PVector(40, 20);
    
    int numSteps = 15;
    float textSpacing = offset + dimensions.x + 15;
    
    fill(0, 0, 0, 150);
    rect(offset - 8, offset - 8, textSpacing + 64, titleOffset + dimensions.y * (numSteps + 2) + 26);
    
    for (int i=0; i < numSteps; i++) {
      fill(gradient(1 - ((float) i)/numSteps, this.colors));
      rect(offset, offset + titleOffset + i * dimensions.y, dimensions.x, dimensions.y);
    }
    
    fill(WATER);
    rect(offset, offset * 1.5 + titleOffset + numSteps * dimensions.y, dimensions.x, dimensions.y * 1.5);
    
    fill(255);
    textSize(FONT_SIZE);
    text(this.title, offset + 4, offset + titleOffset/2);
    text("high", textSpacing, offset * .9 + titleOffset + dimensions.y);
    text("low", textSpacing, offset * .9 + titleOffset + dimensions.y * numSteps);
    text("water", textSpacing, offset * 1.5 + titleOffset + dimensions.y * (numSteps + 1));
  }
}

public class BiomeLegend extends MapLegend {
  
  public void render() {
    float offset = 40;
    float padding = 8;
    float titleOffset = 40;
    PVector dimensions = new PVector(40, 30);
    
    int numSteps = 10;
    float textSpacing = offset + dimensions.x + 15;
    
    fill(0, 0, 0, 150);
    rect(offset - padding, offset - padding, textSpacing + 80, titleOffset + dimensions.y * (numSteps + 2) + 26);
    
    textSize(FONT_SIZE);
    fill(255);
    text("Biomes", offset + 4, offset + titleOffset/2);
    
    for (int i=0; i < numSteps; i++) {
      Biome biome = Biome.getBiome(i);
      String label;
      
      if (biome == null) {
        fill(WATER);
        label = "water";
      } else {
        fill(biome.displayColor.x, biome.displayColor.y, biome.displayColor.z);
        label = biome.toString().toLowerCase();
      }
      
      rect(offset, offset + titleOffset + i * (dimensions.y + padding), dimensions.x, dimensions.y);
      
      fill(255);
      text(label, textSpacing, offset + titleOffset + i * (dimensions.y + padding) + 22);
    }
    
    fill(255);
    text("Biomes", offset + 4, offset + titleOffset/2);
  }
}

public MapLegend getLegendByType(MapType type) {
  switch(type) {
    case ELEVATION:
      return new GradientLegend(ELEVATION_COLORS, "Elevation");
    case TEMPERATURE:
      return new GradientLegend(TEMPERATURE_COLORS, "Temperature");
    case PRECIPITATION:
      return new GradientLegend(PRECIPITATION_COLORS, "Precipitation");
    case BIOME:
      return new BiomeLegend();
    default:
      return new GradientLegend(ELEVATION_COLORS, "Elevation");
  }
}