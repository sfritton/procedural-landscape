public class PerlinWave {
  private PVector seed;
  private float frequency;
  private float amplitude;
  
  public PerlinWave(float frequency, float amplitude, PVector seed) {
    this.frequency = frequency;
    this.amplitude = amplitude;
    this.seed = seed;
  }
  
  public PerlinWave(float frequency, float amplitude, float seedX, float seedY) {
    this(frequency, amplitude, new PVector(seedX, seedY));
  }
  
  public PerlinWave(float frequency, float amplitude) {
    this(frequency, amplitude, new PVector());
  }
  
  public float valueAt(float i, float j) {
    return this.amplitude * noise((this.seed.x + i) * frequency, (this.seed.y + j) * frequency);
  }
}

public ArrayList<PerlinWave> waveStack(float scale, int numWaves, PVector seed) {
  ArrayList waves = new ArrayList<PerlinWave>();
  
  for (int i=0; i < numWaves; i++) {
    float layer = pow(2, i);
    waves.add(new PerlinWave(scale/layer, layer, seed.x + random(layer - 1, layer), seed.y + random(layer - 1, layer)));
  }
  
  return waves;
}

public ArrayList<PerlinWave> waveStack(float scale, int numWaves) {
  return waveStack(scale, numWaves, new PVector());
}

public float stackedValueAt(float i, float j, ArrayList<PerlinWave> waves) {
  float result = 0;
  float max = 0;
  
  for (int k=0; k < waves.size(); k++) {
    PerlinWave wave = waves.get(k);
    result += wave.valueAt(i, j);
    max += wave.amplitude;
  }
  
  return max > 0 ? norm(result, 0, max) : 0;
}