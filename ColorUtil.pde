public final color WATER = color(100, 134, 220);

public final color[] ELEVATION_COLORS = {
  color(0, 80, 0),
  color(0, 80, 0),
  color(170, 180, 50),
  color(210, 230, 110)
};

public final color[] TEMPERATURE_COLORS = { color(0, 0, 255), color(255), color(255, 0, 0) };
public final color[] PRECIPITATION_COLORS = {
  color(150, 0, 0),
  color(150, 0, 0),
  color(250, 150, 0),
  color(255),
  color(0, 150, 0),
  color(0, 255, 255),
  color(0, 255, 255)
};

public color gradient(float percent, color color1, color color2) {
  float diffRed = red(color2) - red(color1);
  float diffGreen = green(color2) - green(color1);
  float diffBlue = blue(color2) - blue(color1);
  
  return color(red(color1) + diffRed * percent,
               green(color1) + diffGreen * percent,
               blue(color1) + diffBlue * percent);
}

public color gradient(float percent, color[] colors) {
  switch(colors.length) {
    case 0:
      return color(0);
    case 1:
      return colors[0];
    case 2:
      return gradient(percent, colors[0], colors[1]);
    default:
      for (int i=0; i < colors.length - 1; i++) {
        float max = 1f/(colors.length - 1) * (i + 1);
        float min = 1f/(colors.length - 1) * i;
        
        if (percent < max) {
          return gradient((percent - min)/(max - min), colors[i], colors[i+1]);
        }
      }
      
      return colors[colors.length - 1];
  }
}

public color gradient(float percent) {
  return gradient(percent, ELEVATION_COLORS);
}

public color step(int steps, float percent, color color1, color color2) {
  for (int i=0; i < steps; i++) {
    float step = 1f/steps * (i + 1);
    if (percent < step) {
      return gradient(step, color1, color2);
    }
  }
  
  return color2;
}

public color step(int steps, float percent, color[] colors) {
  for (int i=0; i < steps; i++) {
    float step = 1f/steps * (i + 1);
    if (percent < step) {
      return gradient(step, colors);
    }
  }
  
  return colors[colors.length - 1];
}

public color step(int steps, float percent) {
  return step(steps, percent, ELEVATION_COLORS);
}