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