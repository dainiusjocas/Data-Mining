
public class Point {
	public int cluster = -1;
	public int value = 0;
	
	public double distance(Point p){
		return Math.abs(this.value-p.value);
	}
}
