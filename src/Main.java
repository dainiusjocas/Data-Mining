import java.util.LinkedList;
import java.util.List;


public class Main {

	
	void dbscan(List<Point> points,double Eps,int MinPts){	
		int ClusterId = 1;
		for (Point p:points){
			if (p.cluster==-1)
				if (ExpandCluster(points,p,ClusterId, Eps, MinPts)){
					ClusterId++;
				}
		}
	}
		
		List<Point>  regionQuery(List<Point> points, Point p,double Eps){
			List<Point> result = new LinkedList<Point>();
			for (Point pt:points){
				if (pt.distance(p)<Eps){
					result.add(pt);
				}
			}
			return result;
		}
		
		void  changeClId(List<Point> points, int clusterId){
			for (Point p:points){
				p.cluster = clusterId;
			}
		}

		boolean ExpandCluster(List<Point> points, Point p,int ClId,double Eps,int MinPts){
			    List<Point> seeds=regionQuery(points,p,Eps);
				if (seeds.size()<MinPts){
					changeClId(seeds,0);
					return false;
				}
				else{
					changeClId(seeds,ClId);
					seeds.remove(p);
					while (!seeds.isEmpty()){
						Point currentP = seeds.get(0);
						List<Point> result = regionQuery(points,currentP,Eps);
						if (result.size() >= MinPts){
							for (Point resultp:result){
								if (resultp.cluster==0 || resultp.cluster==-1){
									if (resultp.cluster==-1){
										seeds.add(resultp);
									}
									resultp.cluster = ClId;
								}
							}
						}
						seeds.remove(currentP);
					}	
				}
			return true;
		}
		
	public static void main(String [ ] args)
	{
	     
		List<Point> result = new LinkedList<Point>();
		
		int temp=0;
		for (int i=0;i<20;i++){
			for (int i2=0;i2<5;i2++){
				Point p = new Point();
				p.value=temp;
				result.add(p);
				temp++;
			}
			temp=temp+10;
		}
		
		new Main().dbscan(result,5,1);
		
		for (Point p:result){
			System.out.println(p.cluster);
		}
	}
	
	
	
}
